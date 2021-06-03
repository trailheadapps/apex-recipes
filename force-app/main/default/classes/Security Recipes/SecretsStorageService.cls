public with sharing class SecretsStorageService {
    private static final String ENCRYPTIONALGORITHM = 'AES256';
    private static final String HMACALGO = 'HmacSHA256';
    private SecretsKeyService keyService;

    @testVisible
    private String serializedSecret;

    public class SecretStorageServiceException extends Exception {
    }

    public SecretsStorageService(SecretsKeyService keyService) {
        this.keyService = keyService;
    }

    public SecretsStorageService() {
        this.keyService = new SecretsKeyService();
    }

    public class SecretsDeploymentCallback implements Metadata.DeployCallback {
        public void handleResult(
            Metadata.DeployResult result,
            Metadata.DeployCallbackContext context
        ) {
            if (result.status == Metadata.DeployStatus.Succeeded) {
                // Deployment was successful
                System.debug(LoggingLevel.INFO, 'Metadata success!');
            } else {
                system.debug(LoggingLevel.DEBUG, result);
            }
        }
    }

    public SecretMDT__mdt fetchExistingSecret(String secretName) {
        SecretMDT__mdt secret;
        try {
            secret = [
                SELECT DeveloperName, Value__c
                FROM SecretMDT__mdt
                WHERE DeveloperName = :secretName
                WITH SECURITY_ENFORCED
                LIMIT 1
            ];
        } catch (QueryException queryException) {
            if (
                queryException.getMessage()
                    .containsIgnoreCase('has no rows for assignment')
            ) {
                throw new SecretStorageServiceException(
                    'Secret ' +
                    secretName +
                    ' could not be found. Have you deployed it yet?'
                );
            }
        }
        if (String.isEmpty(secret.value__c)) {
            throw new SecretStorageServiceException(
                'Secret ' +
                secretName +
                ' is empty'
            );
        }
        return secret;
    }

    private Blob encryptValueWithKey(Secrets.Secret newSecret) {
        ensureKeyExists(newSecret);
        return Crypto.encryptWithManagedIV(
            ENCRYPTIONALGORITHM,
            newSecret.key,
            Blob.valueOf(newSecret.clearTextValue)
        );
    }

    private Void ensureKeyExists(Secrets.Secret newSecret) {
        if (newSecret.key == null) {
            newSecret.key = this.keyService.fetchOrCreateNewKey(
                newSecret.keyName
            );
        }
    }

    private String getEncodedHMAC(
        Secrets.Secret newSecret,
        Blob encryptedValue
    ) {
        return EncodingUtil.base64Encode(
            Crypto.generateMac(
                HMACALGO,
                encryptedValue,
                Blob.valueOf(newSecret.name)
            )
        );
    }

    public Void storeSecret(Secrets.Secret newSecret) {
        Blob encryptedValue = encryptValueWithKey(newSecret);
        String encodedEncryptedValue = EncodingUtil.base64Encode(
            encryptedValue
        );
        String hmac = getEncodedHMAC(newSecret, encryptedValue);

        this.serializedSecret = serializeSecret(
            newSecret,
            encodedEncryptedValue,
            hmac
        );
        createAndDispatchMetadataRecordCreation(
            newSecret,
            this.serializedSecret
        );
    }

    private string serializeSecret(
        Secrets.secret newSecret,
        String encodedEncryptedValue,
        String hmac
    ) {
        // Represent the secret value using  the required format of:
        // <ENCRYPTION KEY NAME>~<ENCRYPTION ALGORITHM>~<HMAC ALGORITHM>~<ENCRYPTED VALUE>~<HMAC VALUE>
        return newSecret.keyName +
            '~' +
            ENCRYPTIONALGORITHM +
            '~' +
            HMACALGO +
            '~' +
            encodedEncryptedValue +
            '~' +
            hmac;
    }

    private Void createAndDispatchMetadataRecordCreation(
        Secrets.Secret newSecret,
        String serializedValue
    ) {
        Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
        customMetadata.fullName = 'SecretMDT__mdt';
        Metadata.CustomMetadataValue customFieldValue = new Metadata.CustomMetadataValue();
        customFieldValue.field = 'Value__c';
        customFieldValue.value = serializedValue;
        customMetadata.values.add(customFieldValue);

        Metadata.CustomMetadataValue customFieldName = new Metadata.CustomMetadataValue();
        customFieldName.field = 'DeveloperName';
        customFieldName.value = newSecret.name;
        customMetadata.values.add(customFieldName);

        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetadata);
        SecretsStorageService.SecretsDeploymentCallback callback = new SecretsStorageService.SecretsDeploymentCallback();

        // Enqueue custom metadata deployment
        Id jobId;
        if (!Test.isRunningTest()) {
            jobId = Metadata.Operations.enqueueDeployment(
                mdContainer,
                callback
            );
        }
    }
}
