@isTest
private inherited sharing class AuraEnabledRecipes_Tests {
    @isTest
    static void testUpdateAccountNamePositive() {
        Account acct = (Account) TestFactory.createSObject(
            new Account(name = 'Original Name'),
            true
        );

        Test.startTest();
        AuraEnabledRecipes.updateAccountName(acct.Id, 'New Name');
        Test.stopTest();

        Account updatedAcct = [SELECT Name FROM Account WHERE Id = :acct.Id];
        System.Assert.areEqual(
            updatedAcct.Name,
            'New Name',
            'Expected the account name to be updated.'
        );
    }

    @isTest
    static void testUpdateAccountNameNegativeInvalidName() {
        Account acct = (Account) TestFactory.createSObject(
            new Account(name = 'Original'),
            true
        );

        Boolean didCatchTheRightException = false; // this defaults to a null, but non true or false state;

        Test.startTest();
        try {
            AuraEnabledRecipes.updateAccountName(acct.Id, '');
        } catch (System.AuraHandledException ahe) {
            if (
                ahe.getMessage().containsIgnoreCase('Script-thrown exception')
            ) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();

        System.Assert.isTrue(
            didCatchTheRightException,
            'Expected to have recieved an Aura Handled Exception'
        );
    }

    @isTest
    static void testUpdateAccountNameNegativeMinAccessProfile() {
        Account acct = (Account) TestFactory.createSObject(
            new Account(name = 'Original Name'),
            true
        );
        Boolean didCatchTheRightException = false;

        User u = TestFactory.createMinAccessUser(true);
        System.runAs(u) {
            try {
                AuraEnabledRecipes.updateAccountName(acct.Id, 'newValue');
            } catch (System.AuraHandledException ahe) {
                if (
                    ahe.getMessage()
                        .containsIgnoreCase('Script-thrown exception')
                ) {
                    didCatchTheRightException = true;
                }
            }
        }
        System.Assert.isTrue(
            didCatchTheRightException,
            'Expected a user with min access profile to not be able to execute the DML update.'
        );
    }

    @isTest
    static void testGetFieldValue() {
        System.Assert.isTrue(
            AuraEnabledRecipes.getFieldValue().equalsIgnoreCase('hello world'),
            'Expected to receive hello world'
        );
    }
}
