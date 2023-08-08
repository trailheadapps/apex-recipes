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
        List<String> relatedClasses = ApexClassUtilities.getRelatedClassesFromClassBody(
            acu
        );
        Test.stopTest();

        System.Assert.isTrue(
            relatedClasses.contains('RecipeTreeViewController'),
            'Expected to see RecipeTreeViewController'
        );
        System.Assert.isTrue(
            relatedClasses.contains('FormattedRecipeDisplayController'),
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
        List<String> relatedClasses = ApexClassUtilities.getRelatedClassesFromClassBody(
            klass
        );
        Test.stopTest();
        System.Assert.areEqual(0, relatedClasses.size(), 'Expected empty list');
    }
}
