/**
 * @description A class to encrypt and decypt (store and retrieve) secrets
 * that require two-factor usage.
 * Note: Do not use this class, if you're simply storing a user/pass for an api
 * callout - use a named credential instead for that use case.
 */
public inherited sharing class Secrets {
    public class SecretException extends Exception {
    }
    public class SecretDeployCallback implements Metadata.DeployCallback {
        public void handleResult(
            Metadata.DeployResult result,
            Metadata.DeployCallbackContext context
        ) {
            if (result.status == Metadata.DeployStatus.Succeeded) {
                // Deployment was successful
            } else {
                system.debug(result);
            }
        }
    }

    private static final String DEFAULTKEY = 'default';
    private static final String ENCRYPTIONALGO = 'AES256';
    private static Blob memoizedKey;

    private static Blob key {
        get {
            if (memoizedKey == null) {
                Secrets__c keyRecord = Secrets__c.getValues(DEFAULTKEY);
                memoizedKey = EncodingUtil.base64Decode(
                    keyRecord.Private_key__c
                );
            }
            return memoizedKey;
        }
        private set {
        }
    }

    public static String fetchSecret(String secretName) {
        SecretMDT__mdt secret = [
            SELECT DeveloperName, Value__c
            FROM SecretMDT__mdt
            WHERE DeveloperName = :secretName
        ];
        Blob decryptedSecret = Crypto.decryptWithManagedIV(
            ENCRYPTIONALGO,
            key,
            EncodingUtil.base64Decode(secret.Value__c)
        );
        return decryptedSecret.toString();
    }

    public static Boolean storeSecret(String secretName, String secret) {
        if (key == null) {
            throw new SecretException(
                'Key is not set, cannot store a new secret'
            );
        }
        Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
        customMetadata.fullName = 'SecretMDT__mdt';

        String value = EncodingUtil.base64Encode(
            Crypto.encryptWithManagedIV(
                ENCRYPTIONALGO,
                key,
                Blob.valueOf(secret)
            )
        );
        Metadata.CustomMetadataValue customFieldValue = new Metadata.CustomMetadataValue();
        customFieldValue.field = 'Value__c';
        customFieldValue.value = value;
        customMetadata.values.add(customFieldValue);

        Metadata.CustomMetadataValue customFieldName = new Metadata.CustomMetadataValue();
        customFieldName.field = 'DeveloperName';
        customFieldName.value = secretName;
        customMetadata.values.add(customFieldName);

        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetadata);
        Secrets.SecretDeployCallback callback = new Secrets.SecretDeployCallback();

        // Enqueue custom metadata deployment
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
        return true;
    }

    public static String boostrapKey() {
        return EncodingUtil.base64Encode(Crypto.generateAesKey(256));
    }
}
