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
            System.assertEquals(
                klass,
                result.name,
                'Expected the name to equal the input'
            );
            System.assert(
                result.apiVersion >= 50.0,
                'Expected the apiVersion to be no earlier than 50.0'
            );
            System.assertNotEquals(
                null,
                result.body,
                'Expected the body to not be null'
            );
            System.assert(
                result.lengthWithoutComments > 0,
                'Expected the length to be greater than 0'
            );
            if (klass.endsWith('_Tests')) {
                System.assert(
                    result.groupName.equalsIgnoreCase('Tests'),
                    'Expected to have recieved the string Tests'
                );
            } else {
                System.assert(
                    result.groupName.equalsIgnoreCase('Shared Code'),
                    'Expected to have recieved the string Shared Code'
                );
            }
        }
        Test.stopTest();
    }
}
