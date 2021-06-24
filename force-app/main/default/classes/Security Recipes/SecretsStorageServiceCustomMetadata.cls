/**
 * @description concrete implementation of a secrets storage service. It
 * features a base class that can be overridden / dependency injected
 * and implements the Secrets Storage Service interface.
 *
 * Note: the design of the Secrets storage and key service are an example of the
 * repository software pattern. To find out more about this pattern please see
 * https://martinfowler.com/eaaCatalog/repository.html
 */
public with sharing class SecretsStorageServiceCustomMetadata implements SecretsStorageService {
    /**
     * @description enum of allowed encryption algorithms.
     */
    public enum EncryptionAlgorithm {
        AES128,
        AES192,
        AES256
    }
    /**
     * @description enum of allowed hmac algorithms.
     */
    public enum HmacAlgorithm {
        HMACSHA256,
        HMACSHA512
    }
    // Sets this implementations default encryption algorithm.
    private EncryptionAlgorithm encryptionAlgo = EncryptionAlgorithm.AES256;
    // Sets this implementations default key size.
    private Integer encryptionKeySize = 256;
    // Sets this implementations default hmac algorithm.
    private HmacAlgorithm hmacAlgo = HmacAlgorithm.HMACSHA256;
    // property holds the dependency injected key service.
    @testVisible
    private SecretsKeyStorageService keyService;
    @testVisible
    private String serializedSecret;
    @testVisible
    private SecretsCustomMetadataStorageBase storageBase = new SecretsCustomMetadataStorageBase();

    /**
     * @description      Standard constructor. This constructor assumes the
     * defaults of this class are desired.
     * @param keyService An instance of a class implementing the KeyService
     * interface.
     */
    public SecretsStorageServiceCustomMetadata(
        SecretsKeyStorageService keyService
    ) {
        this.keyService = keyService;
    }

    /**
     * @description           Standard constructor. This constructor allows
     * developers to override the defaults specified above, so long as the
     * encryptionAlgo and hmacAlgo are valid enums.
     * @param keyService      A valid instance of a class implementing the
     * KeyService interface
     * @param encryptionAlgo  A valid ENUM from above
     * @param hmacAlgo        A valid ENUM from above
     * @param keySize         Integer key size.
     */
    public SecretsStorageServiceCustomMetadata(
        SecretsKeyStorageService keyService,
        EncryptionAlgorithm encryptionAlgo,
        HmacAlgorithm hmacAlgo,
        Integer keySize
    ) {
        this.keyService = keyService;
        this.encryptionAlgo = encryptionAlgo;
        this.hmacAlgo = hmacAlgo;
        this.encryptionKeySize = keySize;
    }

    /**
     * @description   convenience method for creating a key. Pass through to the
     * injected KeyService implementation.
     * @param keyName Name to give this Key.
     * @return        `Boolean`
     */
    public Boolean createKey(String keyName) {
        return this.keyService.createKey(keyName, this.encryptionKeySize);
    }

    /**
     * @description    Finds and decrypts a secret, if appropriate conditions
     * are met.
     * @param itemName Name of the Secret to return.
     * @return         `SecretsData`
     */
    public SecretsData retrieve(String itemName) {
        SecretsData ret = new SecretsData();
        ret.name = itemName;
        ret.encryptedValue = this.storageBase.fetchEncryptedValue(itemName);
        List<String> secretParts = validateSecretFormat(ret.encryptedValue);
        ret.keyName = secretParts[0];
        String payloadAlgorithm = secretParts[1];
        String payloadHmacAlgorithm = secretParts[2];
        Blob payloadEncryptedValue = EncodingUtil.base64Decode(secretParts[3]);
        String payloadHmac = secretParts[4];
        Blob keyValue = keyService.getKey(ret.keyName);
        // validate
        throwIfSecretHasBeenTamperedWith(
            itemName,
            payloadHmac,
            payloadHmacAlgorithm,
            payloadEncryptedValue
        );
        ret.clearTextValue = Crypto.decryptWithManagedIV(
                payloadAlgorithm,
                keyValue,
                payloadEncryptedValue
            )
            .toString();
        return ret;
    }

    /**
     * @description  Ensure the secret value meets the required format of:
     * <ENCRYPTION KEY NAME>~<ENCRYPTION ALGORITHM>~<HMAC ALGORITHM>~<ENCRYPTED VALUE>~<HMAC VALUE>
     * @param secretString
     * @return             `List<String>`
     * @exception          Throws a SecretsStorageServiceException when the
     * secret String does not match this implementations valid format.
     */
    @testVisible
    private List<String> validateSecretFormat(String secretString) {
        List<String> secretData = secretString.split('~');
        if (secretData.size() != 5) {
            throw new SecretsCustomMetadataStorageBase.SecretsStorageServiceException(
                'Secret has invalid format'
            );
        }
        return secretData;
    }

    /**
     * @description  Verify that the data has not been tampered with by
     * generating an HMAC of the encrypted data and comparing it to the HMAC of
     * the retrieved secret. HMAC generation uses the name of the secret as the
     * key to ensure integrity.
     * @param itemName              Name of the secret for comparison.
     * @param payloadHmac           Retrieved hmac for comparison.
     * @param payloadHmacAlgorithm  Retrieved hmac algorithm name for
     * comparison.
     * @param payloadEncryptedValue Retrieved encrypted value for comparison.
     * @exception
     */
    @suppressWarnings('PMD.ExcessiveParameterList')
    private void throwIfSecretHasBeenTamperedWith(
        String itemName,
        String payloadHmac,
        String payloadHmacAlgorithm,
        Blob payloadEncryptedValue
    ) {
        String hmac = EncodingUtil.base64Encode(
            crypto.generateMac(
                payloadHmacAlgorithm,
                payloadEncryptedValue,
                Blob.valueOf(itemName)
            )
        );
        // Use a (relatively) time constant comparison operation to mitigate timing attacks
        if (!ConstantTimeCompare(hmac, payloadHmac)) {
            throw new SecretsCustomMetadataStorageBase.SecretsStorageServiceException(
                'Secret (' +
                itemName +
                '?) has invalid HMAC'
            );
        }
    }

    /**
     * @description     Encrypts the given clear text with the specified key.
     * @param keyName   Key to retrieve and use for encryption
     * @param clearText clearText to encrypt.
     * @return          `Blob`
     */
    private Blob encryptValueWithKey(String keyName, String clearText) {
        Blob key = getKey(keyName);
        return Crypto.encryptWithManagedIV(
            encryptionAlgo.name(),
            key,
            Blob.valueOf(clearText)
        );
    }

    /**
     * @description   Passthrough convenience method for retrieving the key.
     * @param keyName Name of the key to retrieve.
     * @return        `Blob`
     */
    private Blob getKey(String keyName) {
        return keyService.getKey(keyName);
    }

    /**
     * @description          Generates the hmac for this secret and encodes it.
     * @param integrityValue name of the secret
     * @param encryptedValue encrypted blob.
     * @return               `String`
     */
    private String generateBase64EncodedHMAC(
        String integrityValue,
        Blob encryptedValue
    ) {
        return EncodingUtil.base64Encode(
            Crypto.generateMac(
                hmacAlgo.name(),
                encryptedValue,
                Blob.valueOf(integrityValue)
            )
        );
    }

    /**
     * @description     Stores a secret by generating the serialized format and
     * triggering a metadata deploy with the secret.
     * @param keyName   Key to use
     * @param itemName  Name to store this secret under. Use this same name to
     * retrieve the secret later.
     * @param clearText The clear text value.
     * @return          `Boolean`
     */
    public Boolean store(String keyName, String itemName, String clearText) {
        if (String.isEmpty(clearText)) {
            throw new SecretsCustomMetadataStorageBase.SecretsStorageServiceException(
                'ClearText parameter is empty'
            );
        }
        Blob encryptedValue = encryptValueWithKey(keyName, clearText);
        String hmac = generateBase64EncodedHMAC(itemName, encryptedValue);
        String encodedEncryptedValue = EncodingUtil.base64Encode(
            encryptedValue
        );
        this.serializedSecret = serializeSecret(
            keyName,
            encodedEncryptedValue,
            hmac
        );
        this.storageBase.createAndDispatchMetadataRecordCreation(
            itemName,
            this.serializedSecret
        );
        return true;
    }

    /**
     * @description  Represent the secret value using  the required format of:
     * <ENCRYPTION KEY NAME>~<ENCRYPTION ALGORITHM>~<HMAC ALGORITHM>~<ENCRYPTED VALUE>~<HMAC VALUE>
     * @param keyName               Key name to use
     * @param encodedEncryptedValue Encoded and encrypted blob of the clear text
     * @param hmac                  hmac of the secret
     * @return                      `String`
     */
    @TestVisible
    private String serializeSecret(
        String keyName,
        String encodedEncryptedValue,
        String hmac
    ) {
        return keyName +
            '~' +
            encryptionAlgo +
            '~' +
            hmacAlgo +
            '~' +
            encodedEncryptedValue +
            '~' +
            hmac;
    }

    /**
     * @description  An approximate constant time comparison algorithm
     * @param first  first string to compare
     * @param second second string to compare
     * @return       `Boolean`
     */
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
