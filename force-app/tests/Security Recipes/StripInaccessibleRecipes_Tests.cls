@isTest
private inherited sharing class StripInaccessibleRecipes_Tests {
    @TestSetup
    static void createCampaigns() {
        TestFactory.createSObjectList(
            new Campaign(budgetedCost = 200, actualCost = 299),
            150,
            true
        );

        List<Account> accounts = (List<Account>) TestFactory.createSObjectList(
            new Account(),
            150,
            true
        );
        List<Contact> contacts = new List<Contact>();
        for (Account acct : accounts) {
            contacts.addAll(
                (List<Contact>) TestFactory.createSObjectList(
                    new Contact(accountId = acct.Id),
                    10
                )
            );
        }
        insert contacts;
    }

    @isTest
    static void testStripInaccessibleFromQueryPositive() {
        Test.startTest();
        List<Campaign> results = StripInaccessibleRecipes.stripInaccessibleFromQuery();
        Test.stopTest();

        System.Assert.areNotEqual(
            0,
            results.size(),
            'Results should not have a size of 0'
        );

        for (Campaign cmp : results) {
            System.Assert.isNotNull(
                cmp.BudgetedCost,
                'Expected the system profile to be able to see the budgeted cost'
            );
            System.Assert.isNotNull(
                cmp.ActualCost,
                'Expected the system profile to be able to see the actual cost'
            );
        }
    }

    @isTest
    static void testStripInaccessibleFromQueryNegative() {
        User minAccess = TestFactory.createMinAccessUser(true);
        Boolean didCatchTheRightException = false;

        System.runAs(minAccess) {
            Test.startTest();
            try {
                StripInaccessibleRecipes.stripInaccessibleFromQuery();
            } catch (NoAccessException nae) {
                if (
                    nae.getMessage().containsIgnoreCase('no access to entity')
                ) {
                    didCatchTheRightException = true;
                }
            }
            Test.stopTest();
        }

        System.Assert.isTrue(
            didCatchTheRightException,
            'Expected to receive a no Access Exception'
        );
    }

    @isTest
    static void testStripInaccessibleFromQueryMinAccessWithPermsetPositive() {
        User minAccessWithPermset = TestFactory.createMinAccessUser(true);
        TestFactory.assignPermSetToUser(
            minAccessWithPermset,
            'provides_access_to_actual_cost_field_on_campaign'
        );

        List<Campaign> results;
        Test.startTest();
        System.runAs(minAccessWithPermset) {
            results = StripInaccessibleRecipes.stripInaccessibleFromQuery();
        }
        Test.stopTest();
        System.Assert.areNotEqual(
            0,
            results.size(),
            'Results should be greater than 0 in size'
        );
        for (Campaign cmp : results) {
            System.Assert.areEqual(
                299,
                cmp.ActualCost,
                'Expected the user with the permset to be able to see the actual cost'
            );
        }
    }

    @isTest
    static void testStripInaccessibleFromQueryMinAccessWithPermsetNegative() {
        User minAccessWithPermset = TestFactory.createMinAccessUser(true);
        TestFactory.assignPermSetToUser(
            minAccessWithPermset,
            'provides_access_to_actual_cost_field_on_campaign'
        );

        List<Campaign> results;
        Test.startTest();
        System.runAs(minAccessWithPermset) {
            results = StripInaccessibleRecipes.stripInaccessibleFromQuery();
        }
        Test.stopTest();

        Map<Id, Boolean> assertionChecks = new Map<Id, Boolean>();

        for (Campaign cmp : results) {
            assertionChecks.put(cmp.Id, false);
            try {
                System.debug(System.LoggingLevel.NONE, cmp.BudgetedCost);
            } catch (SObjectException soe) {
                if (
                    soe.getMessage()
                        .containsIgnoreCase(
                            'row was retrieved via SOQL without querying the requested field'
                        )
                ) {
                    assertionChecks.put(cmp.Id, true);
                }
            }
        }

        for (Boolean boolCheck : assertionChecks.values()) {
            System.Assert.isTrue(
                boolCheck,
                'Expected every row to throw exception on budged cost'
            );
        }
    }

    @isTest
    static void testStripInaccessibleFromSubQueryMinAccessWithpermsetPositive() {
        User minAccess = TestFactory.createMinAccessUser(true);
        TestFactory.assignPermSetToUser(
            minAccess,
            'Provides_Read_Only_Access_to_Account_and_all_fields'
        );
        TestFactory.assignPermSetToUser(
            minAccess,
            'Provides_Read_Access_to_Contact_and_Contact_Name_field'
        );
        Map<Id, Boolean> assertionChecks = new Map<Id, Boolean>();
        List<Account> results;
        Test.startTest();
        System.runAs(minAccess) {
            results = StripInaccessibleRecipes.stripInaccessibleFromSubquery();
        }
        Test.stopTest();
        for (Account acct : results) {
            assertionChecks.put(acct.id, false);
            List<Contact> contacts = acct.getSObjects('Contacts');
            if (contacts.size() != 0) {
                assertionChecks.put(acct.id, true);
            }
        }
        System.Assert.areNotEqual(
            0,
            assertionChecks.values().size(),
            'assertionChecks should be greater than 0 in size'
        );
        for (Boolean boolCheck : assertionChecks.values()) {
            System.Assert.isTrue(
                boolCheck,
                'Expected every row to throw exception on attempt to access Contacts'
            );
        }
    }

    @isTest
    static void testStripInaccessibleFromSubQueryMinAccessWithPermsetNegative() {
        User minAccess = TestFactory.createMinAccessUser(true);
        TestFactory.assignPermSetToUser(
            minAccess,
            'Provides_Read_Only_Access_to_Account_and_all_fields'
        );
        Map<Id, Boolean> assertionChecks = new Map<Id, Boolean>();

        List<Account> results;
        Test.startTest();
        System.runAs(minAccess) {
            results = StripInaccessibleRecipes.stripInaccessibleFromSubquery();
        }
        Test.stopTest();

        for (Account acct : results) {
            assertionChecks.put(acct.Id, false);
            try {
                List<Contact> contacts = acct.getSObjects('Contacts');
                if (contacts == null) {
                    assertionChecks.put(acct.Id, true);
                }
            } catch (SObjectException soe) {
                System.debug(
                    LoggingLevel.INFO,
                    '%%%% Caught SObject Exception'
                );
                if (
                    soe.getMessage()
                        .containsIgnoreCase(
                            'row was retrieved via SOQL without querying the requested field'
                        )
                ) {
                    assertionChecks.put(acct.Id, true);
                }
            } catch (Exception e) {
                System.debug(LoggingLevel.INFO, '###### ' + e.getMessage());
            }
        }
        System.Assert.areNotEqual(
            0,
            assertionChecks.values().size(),
            'assertionChecks should be greater than 0 in size'
        );
        for (Boolean boolCheck : assertionChecks.values()) {
            System.Assert.isTrue(
                boolCheck,
                'Expected every row to throw exception on attempt to access Contacts'
            );
        }
    }

    @isTest
    static void testStripInaccessibleBeforeDMLMinAccessWithPermSetPositive() {
        User minAccessWithPermSet = TestFactory.createMinAccessUser(true);
        TestFactory.assignPermSetToUser(
            minAccessWithPermSet,
            'Provides_create_access_to_Contact_and_contact_email_field'
        );
        List<Contact> contacts = (List<Contact>) TestFactory.createSObjectList(
            new Contact(email = 'foo@bar.com', title = 'Awesome'),
            150
        );

        Test.startTest();
        System.runAs(minAccessWithPermSet) {
            StripInaccessibleRecipes.stripInaccessibleBeforeDML(contacts);
        }
        Test.stopTest();

        // Our @TestSetup method creates 1500 contacts, so this query specifically limits to the known email adddress
        List<contact> checkContacts = [
            SELECT email, title
            FROM Contact
            WHERE email = 'foo@bar.com'
        ];
        System.Assert.areEqual(
            150,
            checkContacts.size(),
            'Expected to find 150 contacts'
        );
        for (Contact cnt : checkContacts) {
            System.Assert.areNotEqual(
                'Awesome',
                cnt.title,
                'Expected stripInaccessible to strip out the title field'
            );
        }
    }

    @isTest
    static void testStripInaccessibleBeforeDMLMinAccessProfileNegative() {
        User minAccess = TestFactory.createMinAccessUser(true);
        List<Contact> contacts = (List<Contact>) TestFactory.createSObjectList(
            new Contact(),
            150
        );
        Boolean didCatchRightException = false;
        Test.startTest();
        System.runAs(minAccess) {
            try {
                StripInaccessibleRecipes.stripInaccessibleBeforeDML(contacts);
            } catch (NoAccessException nae) {
                if (
                    nae.getMessage().containsIgnoreCase('no access to entity')
                ) {
                    didCatchRightException = true;
                }
            }
        }
        Test.stopTest();

        System.Assert.isTrue(
            didCatchRightException,
            'Expected to have caught a no access exception when run as the minimum access user'
        );
    }

    @isTest
    static void testStripInaccessibleFromUntrustedDataMinAccessWithPermSetPositive() {
        User minAccessWithPermSet = TestFactory.createMinAccessUser(true);
        TestFactory.assignPermSetToUser(
            minAccessWithPermSet,
            'Provides_edit_access_to_Accounts_except_shippingStreet'
        );
        List<Account> accounts = [SELECT Name FROM Account];
        for (Account acct : accounts) {
            acct.shippingStreet = '123 main st.';
        }

        Test.startTest();
        System.runAs(minAccessWithPermSet) {
            StripInaccessibleRecipes.stripInaccessibleFromUntrustedData(
                JSON.serialize(accounts)
            );
        }
        Test.stopTest();

        List<Account> checkAccounts = [
            SELECT Name, ShippingStreet
            FROM Account
        ];
        System.Assert.areEqual(
            150,
            checkAccounts.size(),
            'Expected to find 150 accounts'
        );

        for (Account acct : checkAccounts) {
            System.Assert.isTrue(
                acct.ShippingStreet.containsIgnoreCase('123 main st.'),
                'Expected that a user with this perm set assigned should be able to update the shipping street'
            );
        }
    }

    @isTest
    static void testStripInaccessibleFromUntrustedDataNegative() {
        User minAccess = TestFactory.createMinAccessUser(true);
        List<Account> acct = (List<Account>) TestFactory.createSObjectList(
            new Account(name = 'secure'),
            1,
            true
        );
        acct[0].ShippingStreet = '123 main st.';
        Boolean didCatchRightException = false;

        Test.startTest();
        System.runAs(minAccess) {
            try {
                StripInaccessibleRecipes.stripInaccessibleFromUntrustedData(
                    JSON.serialize(acct)
                );
            } catch (NoAccessException nae) {
                if (
                    nae.getMessage().containsIgnoreCase('no access to entity')
                ) {
                    didCatchRightException = true;
                }
            }
        }
        Test.stopTest();
        System.Assert.isTrue(
            didCatchRightException,
            'Expected to have caught a NoAccessException'
        );
    }
}
