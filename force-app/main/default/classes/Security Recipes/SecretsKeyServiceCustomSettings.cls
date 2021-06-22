/**
 * @description Concrete implementation of the SecretsKeyStorageService
 * interface that stores the keys inside custom settings. Note, as a reminder,
 * custom settings are not deployable and are thus not able to be put in SCM.
 * @group Secrets Recipes
 * @see Secrets, SecretsKeyStorageService
 */
public with sharing class SecretsKeyServiceCustomSettings implements SecretsKeyStorageService {
    /**
     * @description internally used exception subclass.
     */
    private class SecretsKeyServiceException extends exception {
    }

    /**
     * Because retrieving keys can be a time consuming, or query burning
     * activity, this code 'memoizes' the keys previously accessed in this
     * transaction
     */
    private static Map<String, Blob> memoizedKeys = new Map<String, Blob>();

    /**
     * @description   Retrieves the key from custom settings
     * @param keyName Name of the key to return
     * @return        `Blob`
     * @exception     Throws if key is blank or doesn't exist.
     */
    public Blob getKey(String keyName) {
        if (memoizedKeys.containsKey(keyName)) {
            return memoizedKeys.get(keyName);
        } else {
            List<Secrets__c> foundKeys = queryForKey(keyName);
            if (
                foundKeys.size() <= 0 ||
                String.isBlank(foundKeys.get(0).private_key__c)
            ) {
                throw new SecretsKeyServiceException(
                    'Unable to retrieve key:' + keyName
                );
            }
            memoizedKeys.put(
                keyName,
                EncodingUtil.base64Decode(foundKeys.get(0).private_key__c)
            );
            return memoizedKeys.get(keyName);
        }
    }

    /**
     * @description   Creates a new key and stores it in custom settings
     * @param keyName Name of the key
     * @param keySize Size of the key
     * @return        `Boolean`
     */
    public Boolean createKey(String keyName, Integer keySize) {
        return this.writeKey(keyName, keySize);
    }

    /**
     * @description   Method uses Soql to query Key
     * @param keyName Name of the key to find
     * @return        `List<Secrets__c>`
     */
    @suppressWarnings('PMD.ApexCRUDViolation')
    private List<Secrets__c> queryForKey(String keyName) {
        if (!CanTheUser.read(new Secrets__c())) {
            throw new SecretsKeyServiceException(
                'User has no read access to the Secrets__c custom setting'
            );
        }

        return [
            SELECT Name, Private_Key__c
            FROM Secrets__c
            WHERE Name = :keyName
            LIMIT 1
        ];
    }

    /**
     * @description   Method to generate a new random encryption key
     * @param keyName Name of the key to generate
     * @param keySize Size of the key to generate
     * @return        `Boolean`
     */
    private Boolean writeKey(String keyName, Integer keySize) {
        return this.writeKey(
            keyName,
            EncodingUtil.base64Encode(Crypto.generateAesKey(keySize))
        );
    }

    /**
     * @description    Method to write a new encryption key with a specified value
     * @param keyName  Name of the key to generate
     * @param keyValue Value to give the key
     * @return         `Boolean`
     * @exception      throws SecretsKeyServiceException if the key name
     * already exists. Keys are immutable.
     */
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
