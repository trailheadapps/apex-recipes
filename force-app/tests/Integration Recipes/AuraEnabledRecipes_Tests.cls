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
            'New Name',
            updatedAcct.Name,
            'Expected the account name to be updated.'
        );
    }

    @isTest
    static void testUpdateAccountNameNegativeInvalidName() {
        Account acct = (Account) TestFactory.createSObject(
            new Account(name = 'Original'),
            true
        );
        Test.startTest();
        try {
            AuraEnabledRecipes.updateAccountName(acct.Id, '');
            System.Assert.fail('Expected AuraHandledException');
        } catch (System.AuraHandledException ahe) {
            System.Assert.isTrue(
                ahe.getMessage().containsIgnoreCase('Script-thrown exception')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUpdateAccountNameNegativeMinAccessProfile() {
        Account acct = (Account) TestFactory.createSObject(
            new Account(name = 'Original Name'),
            true
        );
        User u = TestFactory.createMinAccessUser(true);
        Test.startTest();
        System.runAs(u) {
            try {
                AuraEnabledRecipes.updateAccountName(acct.Id, 'newValue');
                System.Assert.fail('Expected AuraHandledException');
            } catch (System.QueryException qe) {
                System.Assert.isTrue(
                    qe.getMessage()
                        .containsIgnoreCase(
                            'sObject type \'account\' is not supported'
                        )
                );
            }
        }
        Test.stopTest();
    }

    @isTest
    static void testGetFieldValue() {
        Test.startTest();
        System.Assert.isTrue(
            AuraEnabledRecipes.getFieldValue().equalsIgnoreCase('hello world'),
            'Expected to receive hello world'
        );
        Test.stopTest();
    }
}
