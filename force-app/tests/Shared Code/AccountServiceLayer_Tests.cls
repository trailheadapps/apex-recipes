@isTest
private inherited sharing class AccountServiceLayer_Tests {
    @isTest
    static void justWriteALogStatementPositive() {
        Test.startTest();
        AccountServiceLayer.justWriteALogStatement('Hello Stream Viewers');
        Test.stopTest();

        System.Assert.areEqual(
            'Hello Stream Viewers',
            AccountServiceLayer.didExecuteMethod,
            'Expected the log to match the input parameter.'
        );
    }

    @isTest
    static void testChangeShippingStreetNegativeNoEditAccess() {
        TriggerHandler.bypass('AccountTriggerHandler');
        Account[] accounts = (Account[]) TestFactory.createSObjectList(
            new Account(),
            5,
            true
        );
        User testUser = TestFactory.createMinAccessUser(true);

        Test.startTest();
        System.runAs(testUser) {
            try {
                AccountServiceLayer.changeShippingStreet(
                    accounts,
                    System.AccessLevel.USER_MODE
                );
                Assert.fail('Expected SecurityException');
            } catch (SecurityException e) {
                Assert.areEqual(
                    'Access to entity \'Account\' denied',
                    e.getMessage()
                );
            }
        }
        Test.stopTest();
    }

    @isTest
    static void incrementDescriptionOnBulkAccountsPositive() {
        List<Account> theAccounts = (List<Account>) TestFactory.createSObjectList(
            new Account(),
            5
        );

        Test.startTest();
        List<Account> updatedAccounts = AccountServiceLayer.incrementCounterInDescription(
            theAccounts,
            false
        );
        Test.stopTest();
        System.Assert.areEqual(
            5,
            updatedAccounts.size(),
            'updatedAccounts should have 5 accounts'
        );
        for (Account ua : updatedAccounts) {
            System.Assert.areEqual(
                1,
                integer.valueOf(ua.Description),
                'Expected the code to have incremented to 1'
            );
        }
    }

    @isTest
    static void incrementDescriptionOnBulkAccountsPositiveInvalidInteger() {
        List<Account> theAccounts = (List<Account>) TestFactory.createSObjectList(
            new Account(description = 'Hello'),
            5
        );
        Test.startTest();
        List<Account> updatedAccounts = AccountServiceLayer.incrementCounterInDescription(
            theAccounts,
            false
        );
        Test.stopTest();
        System.Assert.areEqual(
            5,
            updatedAccounts.size(),
            'updatedAccounts should have 5 accounts'
        );
        for (Account ua : updatedAccounts) {
            System.Assert.areEqual(
                1,
                integer.valueOf(ua.Description),
                'Expected the code to have incremented to 1'
            );
        }
    }

    @isTest
    static void incrementDescriptionOnBulkAccountsNegativeInvalidIntegerSaves() {
        List<Account> theAccounts = (List<Account>) TestFactory.createSObjectList(
            new Account(description = 'Hello'),
            5
        );

        Test.startTest();
        try {
            AccountServiceLayer.incrementCounterInDescription(
                theAccounts,
                true
            );
            Assert.fail('Expected ASLException');
        } catch (AccountServiceLayer.ASLException asle) {
            Assert.isTrue(
                asle.getMessage().containsIgnoreCase('id not specified')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void safelySaveNegative() {
        List<Account> theAccounts = (List<Account>) TestFactory.createSObjectList(
            new Account(description = 'Hello'),
            5
        );
        System.Assert.areEqual(
            5,
            theAccounts.size(),
            'updatedAccounts should have 5 accounts'
        );

        for (Account checkAcct : theAccounts) {
            System.Assert.isNull(checkAcct.Id, 'Expected the ID to be null');
        }

        Test.startTest();
        try {
            AccountServiceLayer.safelySave(theAccounts);
            Assert.fail('Expected ASLException');
        } catch (Exception e) {
            Assert.isInstanceOfType(e, AccountServiceLayer.ASLException.class);
        }
        Test.stopTest();
    }

    @isTest
    static void safelySaveNegativeNoAccessException() {
        List<Account> theAccounts = (List<Account>) TestFactory.createSObjectList(
            new Account(description = 'Hello'),
            5
        );
        User testUser = TestFactory.createMinAccessUser(true);

        Test.startTest();
        System.runAs(testUser) {
            try {
                AccountServiceLayer.safelySave(theAccounts);
                Assert.fail('Expected ASLException');
            } catch (AccountServiceLayer.ASLException asle) {
                Assert.isTrue(
                    asle.getMessage().containsIgnoreCase('No Access')
                );
            }
        }
        Test.stopTest();
    }
}
