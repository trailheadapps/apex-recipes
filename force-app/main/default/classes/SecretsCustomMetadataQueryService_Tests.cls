@isTest
private class SecretsCustomMetadataQueryService_Tests {
    @isTest
    /**
     * There is only a negative test for this code.
     * Because custom metadata cannot be created and inserted
     * via apex without a metadata deploy, there's no way to
     * create test data for this query method to actually find.
     */
    static Void testQueryForSecretByNameNegative() {
        SecretsCustomMetadataQueryService queryService = new SecretsCustomMetadataQueryService();
        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            queryService.queryForSecretByName('someName');
        } catch (SecretsCustomMetadataStorageBase.SecretsStorageServiceException serviceException) {
            if (
                serviceException.getMessage()
                    .containsIgnoreCase('could not be found')
            ) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();
        System.assert(
            didCatchTheRightException,
            'Expected to have caught an exception'
        );
    }
}
