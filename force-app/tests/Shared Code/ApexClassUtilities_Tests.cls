@isTest
private class ApexClassUtilities_Tests {
    @isTest
    static void testGetGroupFromClassBodyPositive() {
        ApexClass klass = [
            SELECT name, body
            FROM ApexClass
            WHERE Name LIKE 'ApexClassUtilities'
        ];
        Test.startTest();
        String groupName = ApexClassUtilities.getGroupFromClassBody(klass);
        Test.stopTest();

        System.Assert.areEqual('Shared Code', groupName);
    }

    @isTest
    static void testGetRelatedClassesFromClassBodyPositive() {
        ApexClass klass = [
            SELECT name, body
            FROM ApexClass
            WHERE Name LIKE 'ApexClassUtilities'
        ];
        Test.startTest();
        List<String> relatedClasses = ApexClassUtilities.getRelatedClassesFromClassBody(
            klass
        );
        Test.stopTest();

        System.Assert.areEqual(2, relatedClasses.size());
        System.Assert.areEqual('RecipeTreeViewController', relatedClasses[0]);
        System.Assert.areEqual(
            'FormattedRecipeDisplayController',
            relatedClasses[1]
        );
    }

    @isTest
    static void testGetRelatedClassesFromClassBodyNegativeToComplex() {
        ApexClass klass = [
            SELECT name, body
            FROM ApexClass
            WHERE Name LIKE 'DynamicSOQLRecipes_Tests'
        ];
        Test.startTest();
        List<String> relatedClasses = ApexClassUtilities.getRelatedClassesFromClassBody(
            klass
        );
        Test.stopTest();

        System.Assert.areEqual(0, relatedClasses.size(), 'Expected empty list');
    }
}
