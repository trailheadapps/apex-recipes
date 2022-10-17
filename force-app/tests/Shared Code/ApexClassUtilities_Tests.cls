@isTest
private class ApexClassUtilities_Tests {
    @isTest
    static void testGetRelatedClassesFromClassBodyPositive() {
        ApexClass acu = [
            SELECT id, body
            FROM ApexClass
            WHERE name LIKE 'ApexClassUtilities'
        ];
        Test.startTest();
        String results = ApexClassUtilities.getRelatedClassesFromClassBody(acu);
        Test.stopTest();

        System.Assert.isTrue(
            results.containsIgnoreCase('RecipeTreeViewController'),
            'Expected to see RecipeTreeViewController'
        );
        System.Assert.isTrue(
            results.containsIgnoreCase('FormattedRecipeDisplayController'),
            'Expected to see FormattedRecipeDisplayController'
        );
    }

    @isTest
    static void testGetRelatedClassesFromClassBodyNegativeToComplex() {
        ApexClass klass = [
            SELECT id, body, name
            FROM ApexClass
            WHERE name LIKE 'DynamicSOQLRecipes_Tests'
        ];
        Test.startTest();
        String results = ApexClassUtilities.getRelatedClassesFromClassBody(
            klass
        );
        Test.stopTest();
        System.Assert.areEqual('', results, 'Expected empty string');
    }
}
