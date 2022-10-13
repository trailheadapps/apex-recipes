@isTest
private inherited sharing class MetadataCatalogRecipes_Tests {
    @isTest
    static void testFindAllFormulaFieldsPositive() {
        Map<String, Map<String, String>> results;
        Test.startTest();
        results = MetadataCatalogRecipes.findAllFormulaFields();
        Test.stopTest();

        // This assertion isn't terribly specific, but given that end users can modify the org's shape, it'll have to do
        System.Assert.isNotNull(
            results,
            'Expected the findAllFormulaFields to return some data'
        );
    }

    @isTest
    static void testFindAllContactFieldsThatLookupToAccountPositive() {
        List<MetadataCatalogRecipes.LookupRelationshipDefinition> relatesToAccounts;
        Test.startTest();
        relatesToAccounts = MetadataCatalogRecipes.findAllContactFieldsThatLookupToAccount();
        Test.stopTest();

        // Like the first unit test, this assertion isn't terribly specific, but since end users can modify the org shape, we can only assert that at least one is found
        System.Assert.isNotNull(
            relatesToAccounts,
            'Expected to find at least one field on an object that relates to account'
        );
    }
}
