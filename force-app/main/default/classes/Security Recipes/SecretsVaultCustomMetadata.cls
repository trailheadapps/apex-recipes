/**
 * @description  This implementation of SecretsStorageService is focused on the
 * acceptance and storage of Hashicorp's Vault format.
 */
public with sharing class SecretsVaultCustomMetadata implements SecretsStorageService {
    @testVisible
    private SecretsKeyStorageService keyService;
    @testVisible
    private SecretsCustomMetadataStorageBase storageBase;
    @testVisible
    private String serializedSecret;
    /**
     * @description      Constructor requiring injected keyService
     * @param keyService Key service instance
     */
    public SecretsVaultCustomMetadata(SecretsKeyStorageService keyService) {
        this.keyService = keyService;
    }

    /**
     * @description   Required to conform to interface, but not used in this
     * implementation
     * @param keyName Name to use
     * @return        `Boolean`
     */
    public Boolean createKey(String keyName) {
        return false;
    }

    /**
     * @description     Required to conform to interface, but not used in this
     * implementation
     * @param keyName   Key to use
     * @param itemName  Name of the Secret
     * @param clearText Clear text to encode/encrypt
     * @return          `Boolean`
     */
    public Boolean store(String keyName, String itemName, String clearText) {
        if (String.isEmpty(clearText)) {
            throw new SecretsCustomMetadataStorageBase.SecretsStorageServiceException(
                'ClearText parameter is empty'
            );
        }
        String encryptedValue = encryptData(keyName, itemName, clearText);
        this.serializedSecret = serializeSecret(
            keyName,
            encryptedValue
        );
        this.storageBase.createAndDispatchMetadataRecordCreation(
            itemName,
            this.serializedSecret
        );
        return true;
    }

    /**
     * @description
     * @param itemName
     * @return         `SecretsData`
     */
    public SecretsData retrieve(String itemName) {
        SecretsData ret = new SecretsData();
        ret.name = itemName;
        ret.encryptedValue = this.storageBase.fetchEncryptedValue(itemName);
        List<String> secretParts = validateSecretFormat(ret.encryptedValue);
        ret.keyName = secretParts[0];
        ret.clearTextValue = decryptData(
            ret.keyName,
            itemName,
            ret.encryptedValue
        );
        return ret;
    }

    /**
     * @description     Uses Hasicorp Vault transit encryption to encrypt a clear text String and return the encrypted value.
     * Note this relies on a named credential being setup.
     * @param keyName   Key to use
     * @param itemName  Name of the secret
     * @param clearText Unencrypted String to encrypt
     * @return          `String`
     */
    @testVisible
    private String encryptData(
        String keyName,
        String itemName,
        String clearText
    ) {
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('callout:ApexToken/v1/transit/encrypt/' + keyName);
        req.setHeader('X-Vault-Token', '{!$Credential.Password}');
        String context = EncodingUtil.base64Encode(Blob.valueOf(itemName));
        String plaintext = EncodingUtil.base64Encode(Blob.valueOf(clearText));
        req.setBody(
            '{"context": "' +
            context +
            '", "plaintext": "' +
            plaintext +
            '"}'
        );
        Http http = new Http();
        HTTPResponse res = http.send(req);
        VaultEncrypt data = VaultEncrypt.parse(res.getBody());
        return data.Data.ciphertext;
    }

    /**
     * @description      Makes a callout to Hashicorp's Vault transit encryption service to 
     * decrypt the secret data and returns the clear text.
     * @param keyName    Key to use
     * @param itemName   Secret to fetch
     * @param cipherText Local encrypted version of the secret
     * @return           `String`
     */
    @testVisible
    private String decryptData(
        String keyName,
        String itemName,
        String cipherText
    ) {
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('callout:ApexToken/v1/transit/decrypt/' + keyName);
        req.setHeader('X-Vault-Token', '{!$Credential.Password}');
        String context = EncodingUtil.base64Encode(Blob.valueOf(itemName));
        req.setBody(
            '{"context": "' +
            context +
            '", "ciphertext": "' +
            cipherText +
            '"}'
        );
        Http http = new Http();
        HTTPResponse res = http.send(req);
        VaultEncrypt data = VaultEncrypt.parse(res.getBody());
        return EncodingUtil.base64Decode(data.Data.plaintext).toString();
    }

    @testVisible
    /**
     * @description        Validates that the stored secret string matches the
     * expected format.
     * @param secretString Retrieved Secret string.
     * @return             `List<String>`
     * @exception
     */
    private List<String> validateSecretFormat(String secretString) {
        // Ensure the secret value meets the required format of:
        // <ENCRYPTION KEY NAME>~<ENCRYPTED VALUE>
        List<String> secretData = secretString.split('~');
        if (secretData.size() != 2) {
            throw new SecretsCustomMetadataStorageBase.SecretsStorageServiceException(
                'Secret ' + 'has invalid format'
            );
        }
        return secretData;
    }

    @testVisible
    /**
     * @description  Represent the secret value using  the required format of:
     * <ENCRYPTION KEY NAME>~<ENCRYPTED VALUE>
     * @param keyName               Key name to use
     * @param encryptedValue        Encoded and encrypted blob of the clear text
     * @return                      `String`
     */
    private string serializeSecret(String keyName, string encryptedValue ) {
        return keyName + '~' + encryptedValue;
    }
}
