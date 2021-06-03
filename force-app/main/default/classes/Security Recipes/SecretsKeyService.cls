public with sharing class SecretsKeyService {
    private class SecretsKeyServiceException extends exception {
    }

    private static final Integer ENCRYPTIONKEYSIZE = 256;
    private static Map<String, Blob> memoizedKeys = new Map<String, Blob>();

    public Blob getKey(String keyName) {
        if (memoizedKeys.containsKey(keyName)) {
            return memoizedKeys.get(keyName);
        } else {
            Secrets__c keyRecord = queryForKey(keyName)[0];
            if (String.isBlank(keyRecord.Private_Key__c)) {
                throw new SecretsKeyServiceException(
                    'Unable to retrieve key:' + keyName
                );
            }
            memoizedKeys.put(
                keyName,
                EncodingUtil.base64Decode(keyRecord.Private_Key__c)
            );
            return memoizedKeys.get(keyName);
        }
    }

    public Boolean createKey(String keyName) {
        return this.writeKey(keyName);
    }

    public Blob fetchOrCreateNewKey(String keyName) {
        try {
            Blob key = getKey(keyName);
            return key;
        } catch (SecretsKeyServiceException skse) {
            createKey(keyName);
            return getKey(keyName);
        }
    }

    private List<Secrets__c> queryForKey(String keyName) {
        return [
            SELECT Name, Private_Key__c
            FROM Secrets__c
            WHERE Name = :keyName
            LIMIT 1
        ];
    }

    // Method to generate a new random encryption key
    private Boolean writeKey(String keyName) {
        return this.writeKey(
            keyName,
            EncodingUtil.base64Encode(Crypto.generateAesKey(ENCRYPTIONKEYSIZE))
        );
    }

    // Method to write a new encryption key with a specified value
    private Boolean writeKey(String keyName, String keyValue) {
        List<Secrets__c> keyRecord = queryForKey(keyName);
        if (keyRecord.isEmpty()) {
            Secrets__c rec = new Secrets__c(
                Name = keyName,
                Private_Key__c = keyValue
            );
            Database.insert(rec);
            return true;
        } else {
            throw new SecretsKeyServiceException(
                'Cannot write value of an existing key'
            );
        }
    }
}
