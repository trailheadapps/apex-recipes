public virtual class SecretsCustomMetadataStorageBase {
 
    public class SecretsStorageServiceException extends Exception {
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

    protected String fetchEncryptedValue(String itemName) {
        SecretMDT__mdt secret;
        try {
            secret = [
                SELECT DeveloperName, Value__c
                FROM SecretMDT__mdt
                WHERE DeveloperName = :itemName
                WITH SECURITY_ENFORCED
                LIMIT 1
            ];
        } catch (QueryException queryException) {
            if (
                queryException.getMessage()
                    .containsIgnoreCase('has no rows for assignment')
            ) {
                throw new SecretsStorageServiceException(
                    'Secret ' +
                    itemName +
                    ' could not be found. Have you deployed it yet?'
                );
            }
        }
        if (String.isEmpty(secret.Value__c)) {
            throw new SecretsStorageServiceException(
                'Secret ' +
                itemName +
                ' is empty'
            );
        }
        return secret.Value__c;
    }

    protected Void createAndDispatchMetadataRecordCreation(
        string itemName,
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
        customFieldName.value = itemName;
        customMetadata.values.add(customFieldName);

        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetadata);
        SecretsCustomMetadataStorageBase.SecretsDeploymentCallback callback = new SecretsCustomMetadataStorageBase.SecretsDeploymentCallback();

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