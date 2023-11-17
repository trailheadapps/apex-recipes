@isTest
private class SOQLRecipes_Tests {
    @isTest
    static void testPermSetGrantsAccessToAccountNamePositve() {
        // create user account
        User testUser = TestFactory.createTestUser(true, 'Standard User');
        // assign the permission set
        Id permSetId = [
            SELECT Id
            FROM PermissionSet
            WHERE Name = 'Proving_With_User_Mode_Works'
            LIMIT 1
        ]
        .Id;
        PermissionSetAssignment psa = new PermissionSetAssignment(
            PermissionSetId = permsetId,
            AssigneeId = testUser.Id
        );
        insert psa;

        System.runAs(testUser) {
            TestDataHelpers.createAccount(false, '');
            Test.startTest();
            List<Account> testAccounts = SOQLRecipes.getRecords();
            Test.stopTest();
            System.Assert.areEqual(
                1,
                testAccounts.size(),
                'Expected to find one account'
            );
        }
    }

    @isTest
    static void testProfileDeniesAccountAccessNegative() {
        TestDataHelpers.createAccount(false, '');
        User testUser = TestFactory.createMinAccessUser(true);
        Boolean didCatchProperException = false;
        System.runAs(testUser) {
            Test.startTest();
            try {
                SOQLRecipes.getRecords();
            } catch (QueryException qe) {
                if (
                    qe.getMessage()
                        .containsIgnoreCase(
                            'sObject type \'Account\' is not supported'
                        )
                ) {
                    didCatchProperException = true;
                }
            }
            Test.stopTest();
        }
        System.Assert.isTrue(
            didCatchProperException,
            'Expected to have received a secure query exception'
        );
    }

    @isTest
    static void testSimplegetRecordsPositive() {
        TestDataHelpers.createAccount(false, '');

        System.Assert.areEqual(
            1,
            [SELECT COUNT() FROM Account],
            'Expected only one account'
        );
        Test.startTest();
        List<Account> testAccounts = SOQLRecipes.getRecords();
        Test.stopTest();
        System.Assert.areEqual(
            1,
            testAccounts.size(),
            'We found more or less than 1 account having created exactly 1 account'
        );
        System.Assert.isTrue(
            testAccounts[0].Name.contains('Awesome'),
            'Expected account to have awesome in the name'
        );
    }

    @isTest
    static void testCountOfLargeDataVolumesPositive() {
        /**
         * this next line is a feature of the trigger handler in use
         * it demonstrates the kinds of gotcha's you can hit when testing large data volumes
         * in this case we need 3k accounts - but inserting them means running two triggers
         * Creating those 3k accounts exceeds our CPU governor limit. By inserting after
         * setting the TriggerHandler bypass for accountTriggerHandler, the trigger framework will
         * skip that particular set of triggers.
         */
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MetadataTriggerHandler');
        TestFactory.createSObjectList(new Account(), 3000, true);

        System.Assert.areEqual(
            3000,
            [SELECT COUNT() FROM Account],
            'expected to have created 3k records'
        );
        Test.startTest();
        Integer count = SOQLRecipes.getLargeNumberOfRecords();
        Test.stopTest(); // forces all asych work to complete
        System.Assert.areEqual(3000, count, 'Expected to find 3k records');
    }

    @isTest
    /**
     * @description This test method demonstrates an alternative form of a soql
     * for loop. This form gives you lists of records, rather than one record
     * at a time.
     */
    static void testGetChunksOfLargeNumbersOfRecords() {
        /**
         * this next line is a feature of the trigger handler in use
         * it demonstrates the kinds of gotcha's you can hit when testing large data volumes
         * in this case we need 3k accounts - but inserting them means running two triggers
         * Creating those 3k accounts exceeds our CPU governor limit. By inserting after
         * setting the TriggerHandler bypass for accountTriggerHandler, the trigger framework will
         * skip that particular set of triggers.
         */
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MetadataTriggerHandler');
        TestFactory.createSObjectList(new Account(), 3000, true);

        System.Assert.areEqual(
            [SELECT COUNT() FROM Account],
            3000,
            'expected to have created 3k records'
        );
        Test.startTest();
        Integer[] counts = SOQLRecipes.getChunksOfLargeNumbersOfRecords();
        Test.stopTest(); // forces all asych work to complete
        System.Assert.areEqual(
            15,
            counts[0],
            'Expected the chunk count to be 15 - 3000 / 200'
        );
        System.Assert.areEqual(3000, counts[1], 'Expected to find 3k records');
    }

    /**
     * @description Executes a positive test case against getRecordsByFieldValue
     */
    @isTest
    static void testQueryWithFilterWithNoMatchingAcctsPositive() {
        TestDataHelpers.createAccount(false, '');
        System.Assert.areEqual(
            [SELECT COUNT() FROM Account],
            1,
            'Expected only one account'
        );
        Test.startTest();
        List<Account> testAccounts = SOQLRecipes.getRecordsByFieldValue();
        Test.stopTest();
        System.Assert.areEqual(
            0,
            testAccounts.size(),
            'Expected to find no UK accounts'
        );
    }

    @isTest
    static void testQueryWithFilterNegativeNoPermsToAccountNegative() {
        TestDataHelpers.createAccount(true, 'UK');
        System.Assert.areEqual(
            [SELECT COUNT() FROM ACCOUNT],
            1,
            'expected only one account'
        );
        User minAccess = TestFactory.createMinAccessUser(true);
        List<Account> testAccounts = new List<Account>();
        Test.startTest();
        Boolean didCatchProperException = false;
        System.runAs(minAccess) {
            try {
                testAccounts = SOQLRecipes.getRecordsByFieldValue();
            } catch (QueryException qe) {
                if (
                    qe.getMessage()
                        .containsIgnoreCase(
                            'sObject type \'Account\' is not supported'
                        )
                ) {
                    didCatchProperException = true;
                }
            }
        }
        Test.stopTest();

        System.Assert.isTrue(
            didCatchProperException,
            'Expected to catch security query exception'
        );

        System.Assert.areEqual(
            0,
            testAccounts.size(),
            'we expected to find no UK accounts'
        );
    }

    @isTest
    static void testQueryWithFilterPositive() {
        TestDataHelpers.createAccount(true, 'UK');
        System.Assert.areEqual(
            [SELECT COUNT() FROM Account],
            1,
            'Expected only one account'
        );
        Test.startTest();
        List<Account> testAccounts = SOQLRecipes.getRecordsByFieldValue();
        Test.stopTest();
        System.Assert.areEqual(
            1,
            testAccounts.size(),
            'Expected to find 1 UK accounts'
        );
    }

    @isTest
    static void testComplexFilterOmnibusPositive() {
        TestFactory.createSObject(
            new Account(
                Name = 'With Fast Food',
                ShippingCountry = 'US',
                ShippingState = 'IN',
                Industry = 'Fast Food - made whole'
            ),
            true
        );
        TestFactory.createSObject(
            new Account(
                Name = 'With Slow Food',
                ShippingCountry = 'US',
                ShippingState = 'IN',
                Industry = 'Slow Food - Made whole'
            ),
            true
        );

        Test.startTest();
        List<Account> results = SOQLRecipes.getRecordsByMultipleFieldValues();
        Test.stopTest();
        System.Assert.areEqual(
            1,
            results.size(),
            'Expected to find 1 filtered account'
        );
    }

    @isTest
    static void testComplexFilterOmnibusPositiveNoResults() {
        TestFactory.createSObjectList(new Account(), 5, true);
        Test.startTest();
        List<Account> results = SOQLRecipes.getRecordsByMultipleFieldValues();
        Test.stopTest();
        System.Assert.areEqual(
            0,
            results.size(),
            'expected not to find any accounts as none match the criteria'
        );
    }

    @isTest
    static void testLimitClauseMoreThan10AccountsPositive() {
        /**
         * Our method is limited to 10, so we need to
         * make two assertions.
         * 1. that we have exactly 10 results when there's more than 10 rows in
         * 2. when there's less than 10 rows, we see the exact number of rows.
         */
        List<Account> toInsert = TestDataHelpers.genXnumberOfAccounts(15);
        insert toinsert;
        Test.startTest();
        List<Account> accts = SOQLRecipes.getSpecificNumberOfRecords();
        Test.stopTest();
        System.Assert.areEqual(
            10,
            accts.size(),
            'We inserted 15 accounts, expected this method to give us back 10'
        );
    }

    /**
     * @description Executes a postiive test case against
     * .getSpecifiedNumberOfResults()
     */
    @isTest
    static void testLimitClauseLessThan10AccountsPositive() {
        // our method is limited to 10, so we need to
        // make two assertions.
        // 1. that we have exactly 10 results when there's more than 10 rows in
        // 2. when there's less than 10 rows, we see the exact number of rows.

        List<Account> toInsert = TestDataHelpers.genXnumberOfAccounts(3);
        insert toinsert;
        Test.startTest();
        List<Account> accts = SOQLRecipes.getSpecificNumberOfRecords();
        Test.stopTest();
        System.Assert.areEqual(
            3,
            accts.size(),
            'We inserted 3 accounts, expected this method to give us back 3'
        );
    }

    @isTest
    static void testDynamicLimitClausePositive() {
        List<Account> toInsert = TestDataHelpers.genXnumberOfAccounts(8);
        insert toInsert;
        Test.startTest();
        List<Account> accts = SOQLRecipes.getFirstXRecords(3);
        Test.stopTest();
        System.Assert.areEqual(
            3,
            accts.size(),
            'We inserted 3 accounts, expected this method to give us back 3'
        );
    }

    @isTest
    static void testGetAccountFilterByStatePositive() {
        List<Account> toInsert = TestDataHelpers.genXnumberOfAccounts(3);
        for (Account acct : toInsert) {
            acct.shippingState = 'Tx';
        }
        TriggerHandler.bypass('MetadataTriggerHandler');
        insert toInsert;

        Test.startTest();
        List<Account> accts = SOQLRecipes.getAccountRecordsInState('Tx');
        List<Account> acctsInWA = SOQLRecipes.getAccountRecordsInState('Wa');
        Test.stopTest();

        System.Assert.areEqual(
            3,
            accts.size(),
            'Expected to find 3 accounts in Tx'
        );
        System.Assert.areNotEqual(
            3,
            acctsInWA.size(),
            'Expected to find 0 accounts in Wa'
        );
    }

    // we get a full 10 results when there's > 20 records
    @isTest
    static void testGetRecords11Through20Positive() {
        List<Account> toInsert = TestDataHelpers.genXnumberOfAccounts(25);
        insert toInsert;

        Test.startTest();
        List<Account> accts = SOQLRecipes.getSecond10AccountRecords();
        Test.stopTest();

        List<Account> first10Accounts = [
            SELECT id
            FROM Account
            WITH USER_MODE
            ORDER BY Industry DESC
            LIMIT 10
        ];

        System.Assert.areEqual(
            10,
            accts.size(),
            'Expected to get a full 10 records back'
        );

        System.Assert.areNotEqual(
            accts,
            first10Accounts,
            'Expected this to be two different lists'
        );
    }

    // we get say 5, when there's only 15 records
    @isTest
    static void testGetRecords11Through15Positive() {
        List<Account> toInsert = TestDataHelpers.genXnumberOfAccounts(15);
        insert toinsert;

        Test.startTest();
        List<Account> accts = SOQLRecipes.getSecond10AccountRecords();
        Test.stopTest();

        System.Assert.areEqual(
            5,
            accts.size(),
            'Expected to get 5 records back'
        );
    }

    @isTest
    static void testGetAccountsAndContactsPositive() {
        List<Account> accts = TestDataHelpers.genXnumberOfAccounts(5);
        insert accts;
        List<Contact> contacts = new List<Contact>();
        for (Account acct : accts) {
            for (Integer i = 0; i < 5; i++) {
                Contacts.add(TestDataHelpers.genContactForAccount(acct.Id));
            }
        }
        insert contacts;

        Test.startTest();
        List<Account> returnAccounts = SOQLRecipes.getRecordsWithRelatedRecords();
        Test.stopTest();

        // we get 5 accounts.
        System.Assert.areEqual(
            5,
            returnAccounts.size(),
            'expected a simple result of 5 accounts returned'
        );
        Map<Id, Account> accountMap = new Map<Id, Account>(accts);
        for (Account acct : returnAccounts) {
            List<Contact> testContacts = acct.getSObjects('Contacts');
            System.Assert.areEqual(
                5,
                testContacts.size(),
                'Expected to find 5 contacts'
            );
            for (Contact testContact : testContacts) {
                System.Assert.isNotNull(
                    testContact.Name,
                    'Expected the Name to not be null'
                );
                System.Assert.isTrue(
                    accountMap.keySet().contains(testContact.accountId),
                    'Expected that the accountIds are known to us'
                );
            }
        }
    }

    @isTest
    static void testGetAccountInfoWhenQueryingContactPositive() {
        List<Account> accts = TestDataHelpers.genXnumberOfAccounts(1);
        accts[0].ShippingState = 'KS';
        TriggerHandler.bypass('MetadataTriggerHandler');
        insert accts;
        Contact cnt = new Contact(
            LastName = 'Hello James',
            AccountId = accts[0].Id
        );
        insert cnt;

        Test.startTest();
        List<Contact> testContacts = SOQLRecipes.getParentRecordDetailsFromChildRecord();
        Test.stopTest();

        System.Assert.areEqual(
            1,
            testContacts.size(),
            'Expected to find a single contact'
        );
        System.Assert.isNotNull(
            TestContacts[0].account.Name,
            'Expected our account name to be populated'
        );
    }

    @isTest
    static void testgetDetailsFromBothParentRecordsPositive() {
        Junction_Demo_1__c jd1 = new Junction_Demo_1__c();
        Junction_Demo_2__c jd2 = new Junction_Demo_2__c();

        insert jd1;
        insert jd2;

        Junction__c junction = new Junction__c(
            parent1__c = jd1.Id,
            parent2__c = jd2.Id
        );

        insert junction;

        Test.startTest();
        List<Junction__c> results = SOQLRecipes.getDetailsFromBothParentRecords();
        Test.stopTest();

        System.Assert.isNotNull(
            results[0].parent1__r.Name,
            'Expected parent1\' name to not be mull'
        );
        System.Assert.isNotNull(
            results[0].parent2__r.Name,
            'Expected parent2\'s name field to not be null'
        );
    }

    @isTest
    static void testgetSumOfOpportunityRecordsPositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        List<Opportunity> opps = new List<Opportunity>();
        for (integer i = 0; i < 5; i++) {
            opps.add(
                new Opportunity(
                    accountId = acct.Id,
                    amount = 1000.00,
                    stageName = 'Qualification',
                    name = 'Epic Opportunity ' + i,
                    closeDate = Date.today().addDays(14)
                )
            );
        }
        insert opps;

        Test.startTest();
        Double results = SOQLRecipes.getSumOfOpportunityRecords(acct.Id);
        Test.stopTest();

        System.Assert.areEqual(
            5000.00,
            results,
            'Expected that 5 x 1000 = 5000, and that the sum method worked'
        );
    }
}
