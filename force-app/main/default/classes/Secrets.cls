/**
 * @description A class to encrypt and decypt (store and retrieve) secrets
 * where the encyrption keys are stored as custom settings.
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
                System.debug('Metadata success!');
            } else {
                system.debug(result);
            }
        }
    }

    private static final String ENCRYPTIONALGO = 'AES256';
    private static final Integer ENCRYPTIONKEYSIZE = 256;
    private static final String HMACALGO = 'HmacSHA256';
    private static Map<String, Blob> memoizedKeys = new Map<String, Blob>();

    private static Blob getKey(String keyName) {
        if (memoizedKeys.containsKey(keyname)) {
            return memoizedKeys.get(keyName);
        } else {
            List<Secrets__c> keyRecord = [
                SELECT Name, Private_Key__c
                FROM Secrets__c
                WHERE Name = :keyName
                LIMIT 1
            ];
            if (keyRecord.isEmpty()) {
                throw new SecretException('Unable to retrieve key:' + keyName);
            }
            memoizedKeys.put(
                keyName,
                EncodingUtil.base64Decode(keyRecord[0].Private_Key__c)
            );
            return memoizedKeys.get(keyName);
        }
    }

    // Method to generate a new random encryption key
    private static Boolean writeKey(String keyName) {
        return writeKey(
            keyName,
            EncodingUtil.base64Encode(Crypto.generateAesKey(ENCRYPTIONKEYSIZE))
        );
    }

    // Method to write a new encryption key with a specified value
    private static Boolean writeKey(String keyName, String keyValue) {
        List<Secrets__c> keyRecord = [
            SELECT Name, Private_Key__c
            FROM Secrets__c
            WHERE Name = :keyName
            LIMIT 1
        ];
        if (keyRecord.isEmpty()) {
            Secrets__c rec = new Secrets__c(
                Name = keyName,
                Private_Key__c = keyValue
            );
            Database.insert(rec);
            return true;
        } else {
            throw new SecretException('Cannot write value of an existing key');
        }
    }

    public static Boolean storeSecret(
        String secretName,
        String secretValue,
        string keyName
    ) {
        Blob key = getKey(keyName);
        if (key == null) {
            throw new SecretException(
                'Key is not set, cannot store a new secret'
            );
        }
        // Encrypt the data
        Blob encryptedAsBlob = Crypto.encryptWithManagedIV(
            ENCRYPTIONALGO,
            key,
            Blob.valueOf(secretValue)
        );
        String encrypted = EncodingUtil.base64Encode(encryptedAsBlob);
        // Generate an HMAC of the encrypted data to mitigate tampering. Use the name of the secret as the HMAC key to ensure data integrity.
        String hmac = EncodingUtil.base64Encode(
            crypto.generateMac(
                HMACALGO,
                encryptedAsBlob,
                Blob.valueOf(secretName)
            )
        );
        // Represent the secret value using  the required format of:
        // <ENCRYPTION KEY NAME>~<ENCRYPTION ALGORITHM>~<HMAC ALGORITHM>~<ENCRYPTED VALUE>~<HMAC VALUE>
        String value =
            keyName +
            '~' +
            ENCRYPTIONALGO +
            '~' +
            HMACALGO +
            '~' +
            encrypted +
            '~' +
            hmac;

        Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
        customMetadata.fullName = 'SecretMDT__mdt';
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
        Id jobId;
        if (!Test.isRunningTest()) {
            jobId = Metadata.Operations.enqueueDeployment(
                mdContainer,
                callback
            );
        }
        return true;
    }

    public static String fetchSecret(String secretName) {
        List<SecretMDT__mdt> secret = [
            SELECT DeveloperName, Value__c
            FROM SecretMDT__mdt
            WHERE DeveloperName = :secretName
            LIMIT 1
        ];
        if (secret.isEmpty()) {
            throw new SecretException('Secret ' + secretName + 'is empty');
        }
        // Ensure the secret value meets the required format of:
        // <ENCRYPTION KEY NAME>~<ENCRYPTION ALGORITHM>~<HMAC ALGORITHM>~<ENCRYPTED VALUE>~<HMAC VALUE>
        List<String> data = secret[0].Value__c.split('~');
        if (data.size() != 5) {
            throw new SecretException(
                'Secret ' +
                secretName +
                'has invalid format'
            );
        }
        Blob key = getKey(data[0]);
        String algo = data[1];
        String hmacalgoPayload = data[2];
        Blob enc = EncodingUtil.base64Decode(data[3]);
        String hmacPayload = data[4];
        // Verify that the data has not been tampred with by generating an HMAC of the encrypted data and comparing it to the HMAC of the payload.
        // HMAC generation uses the name of the secret as the key to ensure integrity.
        String hmac = EncodingUtil.base64Encode(
            crypto.generateMac(hmacalgoPayload, enc, Blob.valueOf(secretName))
        );
        // Use a (relatively) time constant comparison operation to mitigate timing attacks
        if (!ConstantTimeCompare(hmac, hmacPayload)) {
            throw new SecretException(
                'Secret ' +
                secretName +
                'has invalid HMAC'
            );
        }
        // The data has not been tampered with so decrypt the data
        Blob decryptedSecret = Crypto.decryptWithManagedIV(algo, key, enc);
        return decryptedSecret.toString();
    }

    // An approximate constant time comparison algorithm
    private static Boolean ConstantTimeCompare(String First, String Second) {
        Boolean result = true;
        if (First.length() != Second.length()) {
            result = false;
        }
        Integer max = First.length() > Second.length()
            ? Second.length()
            : First.length();
        for (Integer i = 0; i < max; i++) {
            if (First.substring(i, i + 1) != Second.substring(i, i + 1)) {
                result = false;
            }
        }
        return result;
    }

    public static Boolean createKey(String keyName) {
        return Secrets.writeKey(keyName);
    }
}
