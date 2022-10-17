@isTest
private class RelatedCodeTabsController_Tests {
    @isTest
    static void testGetRelatedClassesPositive() {
        Test.startTest();
        String[] relatedClasses = RelatedCodeTabsController.getRelatedClasses(
            'ApiServiceRecipes'
        );
        Test.stopTest();
        Set<String> rcSet = new Set<String>(relatedClasses);
        System.Assert.isTrue(
            rcSet.contains('RestClient'),
            'Expected to see RestClient listed'
        );
        System.Assert.isTrue(
            rcSet.contains('ApiServiceRecipesDataModel'),
            'Expected to see the DTO object listed'
        );
    }

    @isTest
    static void testGetRElatedClassesNegative() {
        Boolean didCatchProperException = false;
        Test.startTest();
        try {
            RelatedCodeTabsController.getRelatedClasses(
                'FormattedRecipeController_Tests' // this is a non-existant class
            );
        } catch (QueryException qe) {
            if (qe.getMessage().containsIgnoreCase('no rows for assignment')) {
                didCatchProperException = true;
            }
        }

        Test.stopTest();
        System.Assert.isTrue(
            didCatchProperException,
            'Expected to catch a query exception'
        );
    }

    @isTest
    static void testGetRElatedClassesNegativeNoRelated() {
        Test.startTest();
        String[] relatedClasses = RelatedCodeTabsController.getRelatedClasses(
            'DMLRecipes_Tests'
        );

        Test.stopTest();
        System.Assert.areEqual(
            0,
            relatedClasses.size(),
            'Expected to catch a query exception'
        );
    }
}
