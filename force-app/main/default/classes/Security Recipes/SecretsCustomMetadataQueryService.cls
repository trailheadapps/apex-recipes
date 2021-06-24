public with sharing class SecretsCustomMetadataQueryService {
    public SecretMDT__mdt queryForSecretByName(String secretName) {
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
            // We want to catch query exceptions to provide better error
            // messaging to users (developers). In this case we don't want to
            // rely on a QueryException, because it's not intuitive that a
            // query exception would occur during the retrieval of a secret.
            if (
                queryException.getMessage()
                    .containsIgnoreCase('has no rows for assignment')
            ) {
                throw new SecretsCustomMetadataStorageBase.SecretsStorageServiceException(
                    'Secret ' +
                    secretName +
                    ' could not be found. Have you deployed it yet?'
                );
            }
        }
        return secret;
    }
}
