/**
 * @description Base class for storing secrets in custom metadata.
 * @group Secrets Recipes
 * @see   Secrets, SecretsStorageServiceCustomMetadata
 */
public with sharing virtual class SecretsCustomMetadataStorageBase {
    // The actual query methods are in their own class so that they can be
    // stubbed. This is important, because we can't guarantee there will be any
    // actual real Secrets_MDT records in the db, and even if their were, good
    // unit tests don't rely on existing data!
    @testvisible
    private SecretsCustomMetadataQueryService queryService = new SecretsCustomMetadataQueryService();
    /**
     * Custom exception used by storage providers.
     */
    public class SecretsStorageServiceException extends Exception {
    }

    /**
     * @description This is the callback method fired after a metadata
     * deployment. This implementation doesn't do much, other than log success
     * or failure; but this is here to demonstrate how you can hook into the
     * deployment process after a new metadata backed secret is stored.
     */
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

    /**
     * @description This method is responsible for retrieving the encrypted data
     * from the custom metadata. It's built out as it's own method so that this
     * method can be stubbed during unit testing.
     */
    public String fetchEncryptedValue(String itemName) {
        SecretMDT__mdt secret = queryService.queryForSecretByName(itemName);
        // we also want to ensure we're not returning an empty secret.
        if (String.isEmpty(secret.Value__c)) {
            throw new SecretsStorageServiceException(
                'Secret ' +
                itemName +
                ' is empty'
            );
        }
        return secret.Value__c;
    }

    /**
     * @description           This method is responsible for creating new
     * metadata records, and triggering a metadata deploy to save them. Note:
     * don't forget that custom metadata records cannot be inserted/updated with
     * dml.
     * @param itemName
     * @param serializedValue
     * @return                `Void`
     */
    public Void createAndDispatchMetadataRecordCreation(
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
