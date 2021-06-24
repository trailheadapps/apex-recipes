public with sharing class SecretsVaultCustomMetadata extends SecretsCustomMetadataStorageBase implements SecretsStorageService {

    private SecretsKeyStorageService keyService;


    public SecretsVaultCustomMetadata(SecretsKeyStorageService keyService) {
        this.keyService = keyService;
    }

    private SecretsVaultCustomMetadata() { }

    public Boolean createKey(String keyName) {
        return false;
    }

    public Boolean store(String keyName, string itemName, String clearText) {
        String encodedEncryptedValue = encryptData(
            keyName, 
            itemName, 
            clearText
        );
        String serializedSecret = serializeSecret(
            keyName,
            encodedEncryptedValue
        );
        createAndDispatchMetadataRecordCreation(
            itemName,
            serializedSecret
        );
        return true;
    }

    public SecretsData retrieve(string itemName) {
        SecretsData ret = new SecretsData();
        ret.name = itemName;
        ret.encryptedValue = fetchEncryptedValue(itemName);
        List<String> secretParts = validateSecretFormat(ret.encryptedValue);
        ret.keyName = secretParts[0];
        ret.clearTextValue = decryptData(ret.keyName, itemName, ret.encryptedValue);
        return ret;
    }

    private string encryptData(String keyName, string itemName, String clearText) {
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('callout:HashiCorpVaultToken/v1/transit/encrypt/' + keyName);
        req.setHeader('X-Vault-Token','{!$Credential.Password}');
        String context = EncodingUtil.base64Encode(Blob.valueOf(itemName));
        String plaintext = EncodingUtil.base64Encode(Blob.valueOf(clearText));
        req.setBody('{"context": "' + context + '", "plaintext": "' + plaintext + '"}');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        VaultEncrypt data = VaultEncrypt.parse(res.getBody());
        return data.Data.ciphertext;
    }

    private string decryptData(String keyName, string itemName, string cipherText) {
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('callout:HashiCorpVaultToken/v1/transit/decrypt/' + keyName);
        req.setHeader('X-Vault-Token','{!$Credential.Password}');
        String context = EncodingUtil.base64Encode(Blob.valueOf(itemName));
        req.setBody('{"context": "' + context + '", "ciphertext": "' + cipherText + '"}');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        VaultEncrypt data = VaultEncrypt.parse(res.getBody());
        return EncodingUtil.base64Decode(data.Data.plaintext).toString();
    }

    private string serializeSecret(String keyName, String cipherText) {
        return keyName + '~' + cipherText;
    }

    @testVisible
    private List<String> validateSecretFormat(String secretString) {
        // Ensure the secret value meets the required format of:
        // <ENCRYPTION KEY NAME>~<ENCRYPTED VALUE>
        List<String> secretData = secretString.split('~');
        if (secretData.size() != 2) {
            throw new SecretsStorageServiceException(
                'Secret ' +
                'has invalid format'
            );
        }
        return secretData;
    }


}
