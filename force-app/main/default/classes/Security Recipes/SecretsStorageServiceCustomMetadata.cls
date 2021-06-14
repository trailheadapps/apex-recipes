public with sharing class SecretsStorageServiceCustomMetadata extends SecretsCustomMetadataStorageBase implements SecretsStorageService {
    public enum EncryptionAlgorithm { AES128, 
        AES192, 
        AES256 
    }
    public enum HmacAlgorithm { HmacSHA256,
        HmacSHA512
    }
    private EncryptionAlgorithm ENCRYPTION_ALGO = EncryptionAlgorithm.AES256;
    private Integer ENCRYPTION_KEYSIZE = 256;
    private HmacAlgorithm HMAC_ALGO = HmacAlgorithm.HmacSHA256;
    private SecretsKeyStorageService keyService;

    public SecretsStorageServiceCustomMetadata(SecretsKeyStorageService keyService) {
        this.keyService = keyService;
    }

    public SecretsStorageServiceCustomMetadata(
        SecretsKeyStorageService keyService, 
        EncryptionAlgorithm encyryptionAlgo,
        HmacAlgorithm hmacAlgo,
        Integer keySize
        ) {
            this.keyService = keyService;
            this.ENCRYPTION_ALGO = encyryptionAlgo;
            this.HMAC_ALGO = hmacAlgo;
            this.ENCRYPTION_KEYSIZE = keySize;
    }

    private SecretsStorageServiceCustomMetadata() { }


    public Boolean createKey(String keyName) {
        return this.keyService.createKey(keyName, this.ENCRYPTION_KEYSIZE);
    }

    public SecretsData retrieve(string itemName) {
        SecretsData ret = new SecretsData();
        ret.name = itemName;
        ret.encryptedValue = fetchEncryptedValue(itemName);
        List<String> secretParts = validateSecretFormat(ret.encryptedValue);
        ret.keyName = secretParts[0];
        String payloadAlgorithm = secretParts[1];
        String payloadHmacAlgorithm = secretParts[2];
        Blob payloadEncryptedValue = EncodingUtil.base64Decode(
            secretParts[3]
        );
        String payloadHmac = secretParts[4];
        Blob keyValue = keyService.getKey(ret.keyName);
        // validate 
        throwIfSecretHasBeenTamperedWith(itemName, payloadHmac, payloadHmacAlgorithm, payloadEncryptedValue);
        ret.clearTextValue = Crypto.decryptWithManagedIV(
            payloadAlgorithm,
            keyValue,
            payloadEncryptedValue
        ).toString();
        return ret;
    }

    @testVisible
    private List<String> validateSecretFormat(String secretString) {
        // Ensure the secret value meets the required format of:
        // <ENCRYPTION KEY NAME>~<ENCRYPTION ALGORITHM>~<HMAC ALGORITHM>~<ENCRYPTED VALUE>~<HMAC VALUE>
        List<String> secretData = secretString.split('~');
        if (secretData.size() != 5) {
            throw new SecretsStorageServiceException(
                'Secret ' +
                'has invalid format'
            );
        }
        return secretData;
    }

    private void throwIfSecretHasBeenTamperedWith(string itemName, String payloadHmac, String payloadHmacAlgorithm, Blob payloadEncryptedValue ) {
        // Verify that the data has not been tampred with by generating an HMAC of the encrypted data and comparing it to the HMAC of the payload.
        // HMAC generation uses the name of the secret as the key to ensure integrity.

        String hmac = EncodingUtil.base64Encode(
            crypto.generateMac(
                payloadHmacAlgorithm,
                payloadEncryptedValue,
                Blob.valueOf(itemName)
            )
        );
        // Use a (relatively) time constant comparison operation to mitigate timing attacks
        if (!ConstantTimeCompare(hmac, payloadHmac)) {
            throw new SecretsStorageServiceException(
                'Secret ' +
                itemName +
                'has invalid HMAC'
            );
        }
    }

    private Blob encryptValueWithKey(String keyName, string clearText) {
        Blob key = getKey(keyName);
        return Crypto.encryptWithManagedIV(
            ENCRYPTION_ALGO.name(),
            key,
            Blob.valueOf(clearText)
        );
    }

    private Blob getKey(String keyName) {
        return keyService.getKey(keyName);
    }

    private String getEncodedHMAC(
        string integrityValue,
        Blob encryptedValue
    ) {
        return EncodingUtil.base64Encode(
            Crypto.generateMac(
                HMAC_ALGO.name(),
                encryptedValue,
                Blob.valueOf(integrityValue)
            )
        );
    }

    public Boolean store(String keyName, string itemName, String clearText) {
        Blob encryptedValue = encryptValueWithKey(keyName, clearText);
        String hmac = getEncodedHMAC(itemName, encryptedValue);
        String encodedEncryptedValue = EncodingUtil.base64Encode(
            encryptedValue
        );
        String serializedSecret = serializeSecret(
            keyName,
            encodedEncryptedValue,
            hmac
        );
        createAndDispatchMetadataRecordCreation(
            itemName,
            serializedSecret
        );
        return true;
    }

    private string serializeSecret(String keyName, 
        String encodedEncryptedValue,
        String hmac
    ) {
        // Represent the secret value using  the required format of:
        // <ENCRYPTION KEY NAME>~<ENCRYPTION ALGORITHM>~<HMAC ALGORITHM>~<ENCRYPTED VALUE>~<HMAC VALUE>
        return keyName +
            '~' +
            ENCRYPTION_ALGO +
            '~' +
            HMAC_ALGO +
            '~' +
            encodedEncryptedValue +
            '~' +
            hmac;
    }

    // An approximate constant time comparison algorithm
    @testVisible
    private Boolean constantTimeCompare(String first, String second) {
        Boolean result = true;
        if (first.length() != second.length()) {
            result = false;
        }
        Integer max = first.length() > second.length()
            ? second.length()
            : first.length();
        for (Integer i = 0; i < max; i++) {
            if (first.substring(i, i + 1) != second.substring(i, i + 1)) {
                result = false;
            }
        }
        return result;
    }
    
}
