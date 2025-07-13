@isTest
public with sharing class DataWeaveErrorRecipes_Tests {
    @isTest
    static void testRuntimeError() {
        try {
            Test.startTest();
            DataWeaveErrorRecipes.runtimeError();
            Test.stopTest();

            Assert.fail('Exception expected');
        } catch (Exception ex) {
            Assert.isInstanceOfType(
                ex,
                DataWeaveScriptException.class,
                'Exception of type DataWeaveScriptException expected'
            );
            Assert.isTrue(ex.getMessage().startsWith('Division by zero'));
        }
    }

    @isTest
    static void testConvertContactsToExcel() {
        List<Contact> contacts = new List<Contact>{
            new Contact(FirstName = 'John', LastName = 'Doe')
        };

        try {
            Test.startTest();
            DataWeaveErrorRecipes.convertContactsToExcel(contacts);
            Test.stopTest();

            Assert.fail(
                'Exception expected: application/xlsx is not currently a supported output type'
            );
        } catch (Exception ex) {
            Assert.isInstanceOfType(
                ex,
                DataWeaveScriptException.class,
                'Exception of type DataWeaveScriptException expected'
            );
            Assert.isTrue(
                ex.getMessage()
                    .contains('Unknown content type `application/xlsx`')
            );
        }
    }
}
