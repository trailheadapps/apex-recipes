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
            WHERE name = 'Proving_With_Security_Enforced_works'
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
            System.assertEquals(
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
                List<Account> testAccounts = SOQLRecipes.getRecords();
            } catch (QueryException qe) {
                if (
                    qe.getMessage()
                        .containsIgnoreCase(
                            'secure query included inaccessible'
                        )
                ) {
                    didCatchProperException = true;
                }
            }
            Test.stopTest();
        }
        System.assert(
            didCatchProperException,
            'Expected to have recieved a secure query exception'
        );
    }

    @isTest
    static void testSimplegetRecordsPositive() {
        TestDataHelpers.createAccount(false, '');

        System.assertEquals(
            [SELECT Id FROM Account].size(),
            1,
            'Expected only one account'
        );
        Test.startTest();
        List<Account> testAccounts = SOQLRecipes.getRecords();
        Test.stopTest();
        System.assertEquals(
            testAccounts.size(),
            1,
            'We found more or less than 1 account having created exactly 1 account'
        );
        System.assert(
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
        List<Account> testAccounts = (List<Account>) TestFactory.createSObjectList(
            new Account(),
            3000,
            true
        );

        System.assertEquals(
            [SELECT Id FROM Account].size(),
            3000,
            'expected to have created 3k records'
        );
        Test.startTest();
        Integer count = SOQLRecipes.getLargeNumberOfRecords();
        Test.stopTest(); // forces all asych work to complete
        System.assertEquals(count, 3000, 'Expected to find 3k records');
    }

    /**
     * @description Executes a positive test case against getRecordsByFieldValue
     */
    @isTest
    static void testQueryWithFilterWithNoMatchingAcctsPositive() {
        TestDataHelpers.createAccount(false, '');
        System.assertEquals(
            [SELECT Id FROM Account].size(),
            1,
            'Expected only one account'
        );
        Test.startTest();
        List<Account> testAccounts = SOQLRecipes.getRecordsByFieldValue();
        Test.stopTest();
        System.assertEquals(
            testAccounts.size(),
            0,
            'Expected to find no UK accounts'
        );
    }

    @isTest
    static void testQueryWithFilterNegativeNoPermsToAccountNegative() {
        TestDataHelpers.createAccount(true, 'UK');
        System.assertEquals(
            [SELECT ID FROM ACCOUNT].size(),
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
                            'secure query included inaccessible field'
                        )
                ) {
                    didCatchProperException = true;
                }
            }
        }
        Test.stopTest();

        System.assert(
            didCatchProperException,
            'Expected to catch security query exception'
        );

        System.assertEquals(
            testAccounts.size(),
            0,
            'we expected to find no UK accounts'
        );
    }

    @isTest
    static void testQueryWithFilterPositive() {
        TestDataHelpers.createAccount(true, 'UK');
        System.assertEquals(
            [SELECT Id FROM Account].size(),
            1,
            'Expected only one account'
        );
        Test.startTest();
        List<Account> testAccounts = SOQLRecipes.getRecordsByFieldValue();
        Test.stopTest();
        System.assertEquals(
            testAccounts.size(),
            1,
            'Expected to find 1 UK accounts'
        );
    }

    @isTest
    static void testComplexFilterOmnibusPositive() {
        Account acct1 = (Account) TestFactory.createSObject(
            new Account(
                Name = 'With Fast Food',
                ShippingCountry = 'US',
                ShippingState = 'IN',
                Industry = 'Fast Food - made whole'
            ),
            true
        );
        Account acct2 = (Account) TestFactory.createSObject(
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
        System.assertEquals(
            results.size(),
            1,
            'Expected to find 1 filtered account'
        );
    }

    @isTest
    static void testComplexFilterOmnibusPositiveNoResults() {
        List<Account> accounts = (List<Account>) TestFactory.createSObjectList(
            new Account(),
            5,
            true
        );
        Test.startTest();
        List<Account> results = SOQLRecipes.getRecordsByMultipleFieldValues();
        Test.stopTest();
        System.assertEquals(
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
        System.assertEquals(
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
        System.assertEquals(
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
        System.assertEquals(
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
        insert toInsert;

        Test.startTest();
        List<Account> accts = SOQLRecipes.getAccountRecordsInState('Tx');
        List<Account> acctsInWA = SOQLRecipes.getAccountRecordsInState('Wa');
        Test.stopTest();

        System.assertEquals(
            accts.size(),
            3,
            'Expected to find 3 accounts in Tx'
        );
        System.assertNotEquals(
            acctsInWA.size(),
            3,
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
            WITH SECURITY_ENFORCED
            ORDER BY Industry DESC
            LIMIT 10
        ];

        System.assertEquals(
            10,
            accts.size(),
            'Expected to get a full 10 records back'
        );

        System.assertNotEquals(
            first10Accounts,
            accts,
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

        System.assertEquals(5, accts.size(), 'Expected to get 5 records back');
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
        System.assertEquals(
            5,
            returnAccounts.size(),
            'expected a simple result of 5 accounts returned'
        );
        Map<Id, Account> accountMap = new Map<Id, Account>(accts);
        for (Account acct : returnAccounts) {
            List<Contact> testContacts = acct.getSObjects('Contacts');
            System.assertEquals(
                5,
                testContacts.size(),
                'Expected to find 5 contacts'
            );
            for (Contact testContact : testContacts) {
                System.assertNotEquals(
                    null,
                    testContact.Name,
                    'Expected the Name to not be null'
                );
                System.assert(
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
        insert accts;
        Contact cnt = new Contact(
            LastName = 'Hello James',
            AccountId = accts[0].Id
        );
        insert cnt;

        Test.startTest();
        List<Contact> testContacts = SOQLRecipes.getParentRecordDetailsFromChildRecord();
        Test.stopTest();

        System.assertEquals(
            1,
            testContacts.size(),
            'Expected to find a single contact'
        );
        System.assertNotEquals(
            null,
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

        System.assertNotEquals(
            null,
            results[0].parent1__r.Name,
            'Expected parent1\' name to not be mull'
        );
        System.assertNotEquals(
            null,
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

        System.assertEquals(
            5000.00,
            results,
            'Expected that 5 x 1000 = 5000, and that the sum method worked'
        );
    }
}
