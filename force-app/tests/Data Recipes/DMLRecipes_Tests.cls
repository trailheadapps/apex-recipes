@isTest
public class DMLRecipes_Tests {
    @isTest
    static void testInsertInSystemModePositive() {
        Test.startTest();
        Account insertedAccount = DMLRecipes.insertAccountViaInsertKeywordInSystemMode(
            'testAccount'
        );
        Test.stopTest();

        Account acct = [
            SELECT Name
            FROM Account
            WHERE Id = :insertedAccount.Id
        ];
        System.Assert.areEqual(
            'testAccount',
            acct.Name,
            'We should have found the account we just created'
        );
    }

    @isTest
    static void testInsertInUserModePositive() {
        Test.startTest();
        Account insertedAccount = DMLRecipes.insertAccountViaInsertKeywordInUserMode(
            'testAccount'
        );
        Test.stopTest();

        Account acct = [
            SELECT Name
            FROM Account
            WHERE Id = :insertedAccount.Id
        ];
        System.Assert.areEqual(
            'testAccount',
            acct.Name,
            'We should have found the account we just created'
        );
    }

    @isTest
    static void testInsertInSystemModeNegative() {
        Test.startTest();
        try {
            // Inserting a record with a null name should fail
            DMLRecipes.insertAccountViaInsertKeywordInSystemMode(null);
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
            // Inserting a record with a null name should fail
            DMLRecipes.insertAccountViaInsertKeywordInUserMode(null);
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
            new List<String>{ 'Texas' },
            false,
            AccessLevel.SYSTEM_MODE
        );
        Test.stopTest();

        List<Account> accts = [
            SELECT Id, Name
            FROM Account
        ];
        System.Assert.areEqual(
            1,
            accts.size(),
            'Expected the list of accounts to have a single account'
        );
        System.Assert.areEqual(
            'Texas',
            accts[0].name,
            'Expected the account name to be Texas'
        );
    }

    @isTest
    static void testDatabaseMethodInsertInUserModePositive() {
        Test.startTest();
        DMLRecipes.insertAccountsViaDatabaseMethod(
            new List<String>{ 'Texas' },
            false,
            AccessLevel.USER_MODE
        );
        Test.stopTest();

        List<Account> accts = [
            SELECT Id, Name
            FROM Account
        ];
        System.Assert.areEqual(
            1,
            accts.size(),
            'Expected the list of accounts to have a single account'
        );
        System.Assert.areEqual(
            'Texas',
            accts[0].name,
            'Expected the account name to be Texas'
        );
    }

    @isTest
    static void testDatabaseMethodInsertInSystemModeNegative() {
        Test.startTest();
        try {
            DMLRecipes.insertAccountsViaDatabaseMethod(
                new List<String>{ 'Texas', null },
                true,
                AccessLevel.SYSTEM_MODE
            );
            System.Assert.fail('Expected CustomDmlException');
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
            List<Account> accts = [
                SELECT Id, Name
                FROM Account
            ];
            System.Assert.areEqual(
                0,
                accts.size(),
                'Expected the no account record to be inserted'
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testDatabaseMethodInsertInUserModeNegative() {
        Test.startTest();
        try {
            DMLRecipes.insertAccountsViaDatabaseMethod(
                new List<String>{ 'Texas' },
                true,
                AccessLevel.USER_MODE
            );
        } catch (DMLRecipes.CustomDmlException theException) {
            System.Assert.isTrue(
                theException.getMessage().containsIgnoreCase('failed')
            );
            List<Account> accts = [
                SELECT Id, Name
                FROM Account
            ];
            System.Assert.areEqual(
                0,
                accts.size(),
                'Expected the no account record to be inserted'
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
            WHERE Name = :acct.Name
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
            WHERE Name = :acct.Name
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
            WHERE Name = :acct.Name
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
            WHERE Name = :acct.Name
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
            System.Assert.fail('Expected DML Exception');
        } catch (DMLException DMLe) {
            System.Assert.isTrue(
                DMLe.getMessage()
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

        String checkAcct = [SELECT Name FROM Account WHERE Id = :acct.Id].Name;
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

        String checkAcct = [SELECT Name FROM Account WHERE Id = :acct.Id].Name;
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
            // Note: this is an intentionally invalid ID used for triggering an error state
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
            // Note: this is an intentionally invalid ID used for triggering an error state
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

        String checkAcct = [SELECT Name FROM Account WHERE Id = :acct.Id].Name;
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
        String checkAcct = [SELECT Name FROM Account WHERE Id = :acct.Id].Name;
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
            String checkAcct = [SELECT Name FROM Account WHERE Id = :acct.Id]
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
            String checkAcct = [SELECT Name FROM Account WHERE Id = :acct.Id]
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
            String checkAcct = [SELECT Name FROM Account WHERE Id = :acct.Id]
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
            String checkAcct = [SELECT Name FROM Account WHERE Id = :acct.Id]
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
            WHERE Id = :acct.Id
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
            WHERE Id = :acct.Id
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
            WHERE Id = :acct.Id
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
            WHERE Id = :acct.Id
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
