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
        Boolean didCatchTheProperException = false;

        Test.startTest();
        System.runAs(testUser) {
            try {
                AccountServiceLayer.changeShippingStreet(accounts);
            } catch (CanTheUser.CanTheUserException ctue) {
                if (
                    ctue.getMessage()
                        .containsIgnoreCase('no permission to edit')
                ) {
                    didCatchTheProperException = true;
                }
            }
        }

        Test.stopTest();

        System.Assert.isTrue(
            didCatchTheProperException,
            'Expected to catch a CanTheUserException reporting no edit access'
        );
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
            System.Assert.isTrue(
                integer.valueOf(ua.Description) == 1,
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
            System.Assert.isTrue(
                integer.valueOf(ua.Description) == 1,
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
        Boolean didCatchTheRightException = false;

        Test.startTest();
        try {
            AccountServiceLayer.incrementCounterInDescription(
                theAccounts,
                true
            );
        } catch (AccountServiceLayer.ASLException asle) {
            if (asle.getMessage().containsIgnoreCase('id not specified')) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();

        System.Assert.isTrue(
            didCatchTheRightException,
            'Expected to see the save fail'
        );
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

        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            AccountServiceLayer.safelySave(theAccounts);
        } catch (AccountServiceLayer.ASLException asle) {
            System.debug(LoggingLevel.INFO, asle.getMessage());
            didCatchTheRightException = true;
        }
        Test.stopTest();

        System.Assert.isTrue(
            didCatchTheRightException,
            'Expected to have caught a DML exception'
        );
    }

    @isTest
    static void safelySaveNegativeNoAccessException() {
        List<Account> theAccounts = (List<Account>) TestFactory.createSObjectList(
            new Account(description = 'Hello'),
            5
        );
        User testUser = TestFactory.createMinAccessUser(true);

        Boolean didCatchTheRightException = false;
        Test.startTest();
        System.runAs(testUser) {
            try {
                AccountServiceLayer.safelySave(theAccounts);
            } catch (AccountServiceLayer.ASLException asle) {
                if (asle.getMessage().containsIgnoreCase('No Access')) {
                    didCatchTheRightException = true;
                }
            }
        }

        Test.stopTest();

        System.Assert.isTrue(
            didCatchTheRightException,
            'Expected to have caught a No Access Exception exception'
        );
    }
}
