/**
 * @description Concrete implementation of the SecretsKeyStorageService
 * interface that stores the keys inside AWS Secrets Manager vaults.
 * @group Secrets Recipes
 * @see Secrets, SecretsKeyStorageService
 */
public with sharing class SecretsKeyServiceAWSSecretManager implements SecretsKeyStorageService {
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
     * @description   Retrieves the key from AWS Secrets Manager
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
     * @description   Stubbed out implementation that would create a new key and stores it in Secrets Manager
     * @param keyName Name of the key
     * @param keySize Size of the key
     * @return        `Boolean`
     */
    public Boolean createKey(String keyName, Integer keySize) {
        return false; //this.writeKey(keyName, keySize);
    }

    /**
     * @description   Method uses AWS REST API for query for key
     * @param keyName Name of the key to find
     * @return        `List<Secrets__c>`
     */
    private List<Secrets__c> queryForKey(String keyName) {
        List<Secrets__c> ret = new List<Secrets__c>();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:AWS_Secret/?Action=GetSecretValue');
        req.setMethod('POST');
        req.setHeader('X-Amz-Target', 'secretsmanager.GetSecretValue');
        req.setHeader('Content-Type', 'application/x-amz-json-1.1');
        req.setBody(
            '{"SecretId": "' +
            keyName +
            '" }' 
        );
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if(res.getStatusCode() == 200) {
            AWSSecretDTO data = AWSSecretDTO.parse(res.getBody());
            Secrets__c work = new Secrets__c();
            work.Name = keyName;
            work.Private_Key__c =  data.StringValue;
            ret.add(work);
        }
        return ret;
    }


}
