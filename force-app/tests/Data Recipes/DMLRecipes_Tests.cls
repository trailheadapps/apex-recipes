@isTest
public class DMLRecipes_Tests {
    @isTest
    static void testInsertInSystemModePositive() {
        Test.startTest();
        DMLRecipes.insertAccountViaInsertKeywordInSystemMode('mumbledore');
        Test.stopTest();

        List<Account> acct = [SELECT ID FROM Account WHERE name = 'mumbledore'];
        System.Assert.areEqual(
            1,
            acct.size(),
            'We should have found the account we just created'
        );
    }

    @isTest
    static void testInsertInUserModePositive() {
        Test.startTest();
        DMLRecipes.insertAccountViaInsertKeywordInUserMode('mumbledore');
        Test.stopTest();

        List<Account> acct = [SELECT ID FROM Account WHERE name = 'mumbledore'];
        System.Assert.areEqual(
            1,
            acct.size(),
            'We should have found the account we just created'
        );
    }

    @isTest
    static void testInsertInSystemModeNegative() {
        Test.startTest();
        try {
            DMLRecipes.insertAccountViaInsertKeywordInSystemMode('');
            System.Assert.fail('Expected CustomDmlException');
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testInsertInUserModeNegative() {
        Test.startTest();
        try {
            DMLRecipes.insertAccountViaInsertKeywordInUserMode('');
            System.Assert.fail('Expected CustomDmlException');
        } catch (DMLRecipes.CustomDmlException theException) {
            Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testDatabaseMethodInsertInSystemModePositive() {
        Test.startTest();
        DMLRecipes.insertAccountsViaDatabaseMethod(
            'Texas',
            false,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();

        List<Account> acct = [
            SELECT ID, Name
            FROM Account
            WHERE name = 'Texas'
        ];

        System.Assert.areEqual(
            1,
            acct.size(),
            'Expected the list of accounts to have a single account'
        );
        System.Assert.areEqual(
            'Texas',
            acct[0].name,
            'Expected the account name to be Texas'
        );
    }

    @isTest
    static void testDatabaseMethodInsertInUserModePositive() {
        Test.startTest();
        DMLRecipes.insertAccountsViaDatabaseMethod(
            'Texas',
            false,
            AccessLevel.USER_MODE
        );
        Test.stopTest();

        List<Account> acct = [
            SELECT ID, Name
            FROM Account
            WHERE name = 'Texas'
        ];

        System.Assert.areEqual(
            1,
            acct.size(),
            'Expected the list of accounts to have a single account'
        );
        System.Assert.areEqual(
            'Texas',
            acct[0].name,
            'Expected the account name to be Texas'
        );
    }

    @isTest
    static void testDatabaseMethodInsertInSystemModeNegative() {
        Test.startTest();
        try {
            DMLRecipes.insertAccountsViaDatabaseMethod(
                'Texas',
                true,
                AccessLevel.SYSTEM_MODE
            );
            System.Assert.fail('Expected CustomDmlException');
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testDatabaseMethodInsertInUserModeNegative() {
        Test.startTest();
        try {
            DMLRecipes.insertAccountsViaDatabaseMethod(
                'Texas',
                true,
                AccessLevel.USER_MODE
            );
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUpsertAccountViaUpsertKeywordInSystemModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');

        Test.startTest();
        DMLRecipes.upsertAccountViaUpsertKeywordInSystemMode(acct);
        Test.stopTest();

        List<Account> resultingAccounts = [
            SELECT Name
            FROM Account
            WHERE name = :acct.Name
        ];
        System.Assert.areEqual(
            1,
            resultingAccounts.size(),
            'We expect to find a single account with that name'
        );
    }

    @isTest
    static void testUpsertAccountViaUpsertKeywordInUserModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');

        Test.startTest();
        DMLRecipes.upsertAccountViaUpsertKeywordInUserMode(acct);
        Test.stopTest();

        List<Account> resultingAccounts = [
            SELECT Name
            FROM Account
            WHERE name = :acct.Name
        ];
        System.Assert.areEqual(
            1,
            resultingAccounts.size(),
            'We expect to find a single account with that name'
        );
    }

    @isTest
    static void testUpsertAccountViaUpsertKeywordInSystemModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'Ca');
        // Note: this is an intentionally invalid ID, used to trigger the failure case.
        acct.Id = '0019A000008GTAYQA4'; //NOPMD
        Test.startTest();
        try {
            DMLRecipes.upsertAccountViaUpsertKeywordInSystemMode(acct);
            System.Assert.fail('Expected DML Exception');
        } catch (DMLException dmlException) {
            System.Assert.isTrue(
                dmlException.getMessage()
                    .containsIgnoreCase('invalid cross reference id')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUpsertAccountViaDatabaseMethodInSystemModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'Ca');
        Database.UpsertResult result;
        Test.startTest();
        result = DMLRecipes.upsertAccountViaDatabaseMethod(
            acct,
            true,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        List<Account> resultingAccounts = [
            SELECT Name
            FROM Account
            WHERE name = :acct.Name
        ];
        System.Assert.areEqual(
            1,
            resultingAccounts.size(),
            'We expect to find a single account with that name'
        );
    }

    @isTest
    static void testUpsertAccountViaDatabaseMethodInUserModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'Ca');
        Database.UpsertResult result;
        Test.startTest();
        result = DMLRecipes.upsertAccountViaDatabaseMethod(
            acct,
            true,
            AccessLevel.USER_MODE
        );
        Test.stopTest();
        List<Account> resultingAccounts = [
            SELECT Name
            FROM Account
            WHERE name = :acct.Name
        ];
        System.Assert.areEqual(
            1,
            resultingAccounts.size(),
            'We expect to find a single account with that name'
        );
    }

    @isTest
    static void testUpsertAccountViaUpsertKeywordInUserModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'Ca');
        // Note: this is an intentionally invalid ID, used to trigger the failure case.
        acct.Id = '0019A000008GTAYQA4'; //NOPMD
        Test.startTest();
        try {
            DMLRecipes.upsertAccountViaUpsertKeywordInUserMode(acct);
            System.Assert.fail('Expected Security Exception');
        } catch (SecurityException securityException) {
            System.Assert.isTrue(
                securityException.getMessage()
                    .containsIgnoreCase('invalid cross reference id')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUpsertAccountViaDatabaseMethodInSystemModeNegative() {
        Account badAcct = TestDataHelpers.genAccountWithOptions(true, 'Ca');
        // Note: this is an intentionally invalid ID, used to trigger the failure case.
        badAcct.Id = '0019A000008GTAYQA4'; //NOPMD
        Database.UpsertResult result;
        Test.startTest();
        try {
            result = DMLRecipes.upsertAccountViaDatabaseMethod(
                badAcct,
                true,
                AccessLevel.SYSTEM_MODE
            );
            System.Assert.fail('Expected CustomDmlException');
        } catch (DMLRecipes.CustomDmlException cde) {
            System.Assert.isTrue(cde.getMessage().containsIgnoreCase('failed'));
        }
        Test.stopTest();
    }

    @isTest
    static void testUpsertAccountViaDatabaseMethodInUserModeNegative() {
        Account badAcct = TestDataHelpers.genAccountWithOptions(true, 'Ca');
        // Note: this is an intentionally invalid ID, used to trigger the failure case.
        badAcct.Id = '0019A000008GTAYQA4'; //NOPMD
        Database.UpsertResult result;
        Test.startTest();
        try {
            result = DMLRecipes.upsertAccountViaDatabaseMethod(
                badAcct,
                true,
                AccessLevel.USER_MODE
            );
            System.Assert.fail('Expected CustomDmlException');
        } catch (DMLRecipes.CustomDmlException cde) {
            System.Assert.isTrue(cde.getMessage().containsIgnoreCase('failed'));
        }
        Test.stopTest();
    }

    @isTest
    static void testUpdateAcccountViaKeywordInUserModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;

        Test.startTest();
        acct.Name += ' + Updated';
        DMLRecipes.updateAcccountViaKeywordInUserMode(
            new List<Account>{ acct }
        );
        Test.stopTest();

        String checkAcct = [SELECT name FROM Account WHERE id = :acct.Id].Name;
        System.Assert.isTrue(
            checkAcct.containsIgnoreCase('updated'),
            'Expected to find the keyword updated in the account name'
        );
    }

    @isTest
    static void testUpdateAcccountViaKeywordInSystemModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;

        Test.startTest();
        acct.Name += ' + Updated';
        DMLRecipes.updateAcccountViaKeywordInSystemMode(
            new List<Account>{ acct }
        );
        Test.stopTest();

        String checkAcct = [SELECT name FROM Account WHERE id = :acct.Id].Name;
        System.Assert.isTrue(
            checkAcct.containsIgnoreCase('updated'),
            'Expected to find the keyword updated in the account name'
        );
    }

    @isTest
    static void testUpdateAcccountViaKeywordInSystemModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        Test.startTest();
        try {
            // Note: this is an intentionally invalid id used for triggering an error state
            acct.Id = '0019A000008GTAYQA4'; //NOPMD
            DMLRecipes.updateAcccountViaKeywordInSystemMode(
                new List<Account>{ acct }
            );
            System.Assert.fail('Expected CustomDMLException');
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUpdateAcccountViaKeywordInUserModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        Test.startTest();
        try {
            // Note: this is an intentionally invalid id used for triggering an error state
            acct.Id = '0019A000008GTAYQA4'; //NOPMD
            DMLRecipes.updateAcccountViaKeywordInUserMode(
                new List<Account>{ acct }
            );
            System.Assert.fail('Expected CustomDMLException');
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUpdateAcccountViaDatabaseMethodInSystemModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;

        Test.startTest();
        acct.Name += ' + Updated';
        DMLRecipes.updateAccountViaDatabaseMethod(
            new List<Account>{ acct },
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();

        String checkAcct = [SELECT name FROM Account WHERE id = :acct.Id].Name;
        System.Assert.isTrue(
            checkAcct.containsIgnoreCase('updated'),
            'Expected to find the keyword updated in the account name'
        );
    }

    @isTest
    static void testUpdateAcccountViaDatabaseMethodInUserModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;

        Test.startTest();
        acct.Name += ' + Updated';
        DMLRecipes.updateAccountViaDatabaseMethod(
            new List<Account>{ acct },
            AccessLevel.USER_MODE
        );
        Test.stopTest();
        String checkAcct = [SELECT name FROM Account WHERE id = :acct.Id].Name;
        System.Assert.isTrue(
            checkAcct.containsIgnoreCase('updated'),
            'Expected to find the keyword updated in the account name'
        );
    }

    @isTest
    static void testUpdateAcccountViaDatabaseMethodInSystemModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        Test.startTest();
        try {
            // Note: This is an intentionally invalid ID used for triggering an error state
            acct.Id = '0019A000008GTAYQA4'; //NOPMD
            DMLRecipes.updateAccountViaDatabaseMethod(
                new List<Account>{ acct },
                AccessLevel.SYSTEM_MODE
            );
            System.Assert.fail('expected CustomDmlException');
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUpdateAcccountViaDatabaseMethodInUserModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            // Note: This is an intentionally invalid ID used for triggering an error state
            acct.Id = '0019A000008GTAYQA4'; //NOPMD
            DMLRecipes.updateAccountViaDatabaseMethod(
                new List<Account>{ acct },
                AccessLevel.USER_MODE
            );
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testDeleteAccountViaKeywordInSystemModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;

        Test.startTest();
        DMLRecipes.deleteAccountViaKeywordInSystemMode(
            new List<Account>{ acct }
        );
        Test.stopTest();
        try {
            String checkAcct = [SELECT name FROM Account WHERE id = :acct.Id]
            .Name; //NOPMD
            System.Assert.fail('expected QueryException');
        } catch (QueryException qe) {
            System.Assert.isTrue(
                qe.getMessage()
                    .containsIgnoreCase('list has no rows for assignment')
            );
        }
    }

    @isTest
    static void testDeleteAccountViaKeywordInUserModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;

        Test.startTest();
        DMLRecipes.deleteAccountViaKeywordInUserMode(new List<Account>{ acct });
        Test.stopTest();
        try {
            String checkAcct = [SELECT name FROM Account WHERE id = :acct.Id]
            .Name; //NOPMD
            System.Assert.fail('expected QueryException');
        } catch (QueryException qe) {
            System.Assert.isTrue(
                qe.getMessage()
                    .containsIgnoreCase('list has no rows for assignment')
            );
        }
    }

    @isTest
    static void testDeleteAccountViaKeywordInSystemModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        delete acct;

        Test.startTest();
        try {
            DMLRecipes.deleteAccountViaKeywordInSystemMode(
                new List<Account>{ acct }
            );
            System.Assert.fail('expected CustomDmlException');
        } catch (DMLRecipes.CustomDmlException cde) {
            System.Assert.isTrue(cde.getMessage().containsIgnoreCase('failed'));
        }
        Test.stopTest();
    }

    @isTest
    static void testDeleteAccountViaKeywordInUserModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        delete acct;

        Test.startTest();
        try {
            DMLRecipes.deleteAccountViaKeywordInUserMode(
                new List<Account>{ acct }
            );
            System.Assert.fail('expected CustomDmlException');
        } catch (DMLRecipes.CustomDmlException cde) {
            System.Assert.isTrue(cde.getMessage().containsIgnoreCase('failed'));
        }
        Test.stopTest();
    }

    @isTest
    static void testDeleteAccountViaDatabaseMethodInUserModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;

        Test.startTest();
        DMLRecipes.deleteAccountViaDatabaseMethod(
            new List<Account>{ acct },
            AccessLevel.USER_MODE
        );
        Test.stopTest();
        try {
            String checkAcct = [SELECT name FROM Account WHERE id = :acct.Id]
            .Name; //NOPMD
            System.Assert.fail('expected QueryException');
        } catch (QueryException qe) {
            System.Assert.isTrue(
                qe.getMessage()
                    .containsIgnoreCase('list has no rows for assignment')
            );
        }
    }

    @isTest
    static void testDeleteAccountViaDatabaseMethodInSystemModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;

        Test.startTest();
        DMLRecipes.deleteAccountViaDatabaseMethod(
            new List<Account>{ acct },
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        try {
            String checkAcct = [SELECT name FROM Account WHERE id = :acct.Id]
            .Name; //NOPMD
            System.Assert.fail('expected QueryException');
        } catch (QueryException qe) {
            System.Assert.isTrue(
                qe.getMessage()
                    .containsIgnoreCase('list has no rows for assignment')
            );
        }
    }

    @isTest
    static void testDeleteAccountViaDatabaseMethodInUserModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        delete acct;

        Test.startTest();
        try {
            DMLRecipes.deleteAccountViaDatabaseMethod(
                new List<Account>{ acct },
                AccessLevel.USER_MODE
            );
            System.Assert.fail('expected CustomDmlException');
        } catch (DMLRecipes.CustomDmlException cde) {
            System.Assert.isTrue(cde.getMessage().containsIgnoreCase('failed'));
        }
        Test.stopTest();
    }

    @isTest
    static void testDeleteAccountViaDatabaseMethodInSystemNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        delete acct;

        Test.startTest();
        try {
            DMLRecipes.deleteAccountViaDatabaseMethod(
                new List<Account>{ acct },
                AccessLevel.SYSTEM_MODE
            );
            System.Assert.fail('expected CustomDmlException');
        } catch (DMLRecipes.CustomDmlException cde) {
            System.Assert.isTrue(cde.getMessage().containsIgnoreCase('failed'));
        }
        Test.stopTest();
    }

    @isTest
    static void testUndeleteAccountViaKeywordInUserModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct;
        delete acct;
        Test.startTest();
        DMLRecipes.undeleteAccountViaKeywordInUserMode(
            new List<Account>{ acct }
        );
        Test.stopTest();
        List<Account> checkAcct = [
            SELECT name
            FROM Account
            WHERE id = :acct.Id
        ];
        System.Assert.areEqual(
            1,
            checkAcct.size(),
            'Expected to find a single account'
        );
    }

    @isTest
    static void testUndeleteAccountViaKeywordInSystemModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct;
        delete acct;
        Test.startTest();
        DMLRecipes.undeleteAccountViaKeywordInSystemMode(
            new List<Account>{ acct }
        );
        Test.stopTest();
        List<Account> checkAcct = [
            SELECT name
            FROM Account
            WHERE id = :acct.Id
        ];
        System.Assert.areEqual(
            1,
            checkAcct.size(),
            'Expected to find a single account'
        );
    }

    @isTest
    static void testUndeleteAccountViaKeywordInSystemModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct;
        Test.startTest();
        try {
            DMLRecipes.undeleteAccountViaKeywordInSystemMode(
                new List<Account>{ acct }
            );
            System.Assert.fail('Expected CustomDMLException');
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUndeleteAccountViaKeywordInUserModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct;
        Test.startTest();
        try {
            DMLRecipes.undeleteAccountViaKeywordInUserMode(
                new List<Account>{ acct }
            );
            System.Assert.fail('Expected CustomDMLException');
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUndeleteAccountViaDatabaseMethodInSystemModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct;
        delete acct;
        Test.startTest();
        DMLRecipes.undeleteAccountViaDatabaseMethod(
            new List<Account>{ acct },
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();
        List<Account> checkAcct = [
            SELECT name
            FROM Account
            WHERE id = :acct.Id
        ];
        System.Assert.areEqual(
            1,
            checkAcct.size(),
            'Expected to find a single account'
        );
    }

    @isTest
    static void testUndeleteAccountViaDatabaseMethodInUserModePositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct;
        delete acct;
        Test.startTest();
        DMLRecipes.undeleteAccountViaDatabaseMethod(
            new List<Account>{ acct },
            AccessLevel.USER_MODE
        );
        Test.stopTest();
        List<Account> checkAcct = [
            SELECT name
            FROM Account
            WHERE id = :acct.Id
        ];
        System.Assert.areEqual(
            1,
            checkAcct.size(),
            'Expected to find a single account'
        );
    }

    @isTest
    static void testUndeleteAccountViaDatabaseMethodInSystemModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct;
        Test.startTest();
        try {
            DMLRecipes.undeleteAccountViaDatabaseMethod(
                new List<Account>{ acct },
                AccessLevel.SYSTEM_MODE
            );
            System.Assert.fail('Expected CustomDMLException');
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testUndeleteAccountViaDatabaseMethodInUserModeNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct;
        Test.startTest();
        try {
            DMLRecipes.undeleteAccountViaDatabaseMethod(
                new List<Account>{ acct },
                AccessLevel.USER_MODE
            );
            System.Assert.fail('Expected CustomDMLException');
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
        }
        Test.stopTest();
    }
}
