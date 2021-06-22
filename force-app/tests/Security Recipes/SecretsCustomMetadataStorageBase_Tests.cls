@isTest
private class SecretsCustomMetadataStorageBase_Tests {
    @isTest
    static Void testFetchEncryptedValuePositive() {
        SecretMDT__mdt fakeMDTRecord = new SecretMDT__mdt();
        fakeMDTRecord.value__c = 'non-null-value';

        SecretsCustomMetadataQueryService queryService = (SecretsCustomMetadataQueryService) new Stub.Builder(
                SecretsCustomMetadataQueryService.class
            )
            .mockingMethodCall('queryForSecretByName')
            .withParameterTypes(String.class)
            .withParameterValues('secret')
            .returning(fakeMDTRecord)
            .defineStub(true);
        SecretsCustomMetadataStorageBase storageBase = new SecretsCustomMetadataStorageBase();
        storageBase.queryService = queryService;
        Test.startTest();
        String value = storageBase.fetchEncryptedValue('secret');
        Test.stopTest();
        System.assertNotEquals(
            null,
            value,
            'expected this to return a non-null-value'
        );
    }

    @isTest
    static Void testFetchEncryptedValueNegative() {
        SecretMDT__mdt fakeMDTRecord = new SecretMDT__mdt();

        SecretsCustomMetadataQueryService queryService = (SecretsCustomMetadataQueryService) new Stub.Builder(
                SecretsCustomMetadataQueryService.class
            )
            .mockingMethodCall('queryForSecretByName')
            .withParameterTypes(String.class)
            .withParameterValues('secret')
            .returning(fakeMDTRecord)
            .defineStub(true);
        SecretsCustomMetadataStorageBase storageBase = new SecretsCustomMetadataStorageBase();
        storageBase.queryService = queryService;
        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            String value = storageBase.fetchEncryptedValue('secret');
        } catch (SecretsCustomMetadataStorageBase.SecretsStorageServiceException serviceException) {
            if (
                serviceException.getMessage()
                    .containsIgnoreCase('Secret Secret is empty')
            ) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();
        System.assert(
            didCatchTheRightException,
            'expected this to throw an exception when null'
        );
    }
}
