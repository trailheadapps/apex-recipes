@isTest
private class FormattedRecipeDisplayController_Tests {
    @isTest
    /**
     * @description Tests the getRecipeCode with both a
     * production class, and a test class.
     *
     * Note: This test does not create any of it's own data (classes)
     * and it does not require seeAllData=true because ApexClass objects
     * while queryable are not true data objects, but metadata objects.
     */
    static void testGetRecipeCodePositive() {
        String[] classes = new List<String>{
            'FormattedRecipeDisplayController',
            'FormattedRecipeDisplayController_Tests'
        };

        Test.startTest();
        for (String klass : classes) {
            FormattedRecipeDisplayController.ClassData result = FormattedRecipeDisplayController.getRecipeCode(
                klass
            );
            System.Assert.areEqual(
                klass,
                result.name,
                'Expected the name to equal the input'
            );
            System.Assert.isTrue(
                result.apiVersion >= 62.0,
                'Expected the apiVersion to be no earlier than 62.0'
            );
            System.Assert.isNotNull(
                result.body,
                'Expected the body to not be null'
            );
            System.Assert.isTrue(
                result.lengthWithoutComments > 0,
                'Expected the length to be greater than 0'
            );
            if (klass.endsWith('_Tests')) {
                System.Assert.isTrue(
                    result.groupName.equalsIgnoreCase('Tests'),
                    'Expected to have received the string Tests'
                );
            } else {
                System.Assert.isTrue(
                    result.groupName.equalsIgnoreCase('Shared Code'),
                    'Expected to have received the string Shared Code'
                );
            }
        }
        Test.stopTest();
    }
}
