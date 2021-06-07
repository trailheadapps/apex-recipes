@isTest
@SuppressWarnings('PMD.CyclomaticComplexity')
/**
 * @description There is a @suppressWarnings annotation on this class for Cyclomatic Complexity.
 * You can read more about what Cyclomatic Complexity is here: https://en.wikipedia.org/wiki/Cyclomatic_complexity
 * Classes with a high Cyclomatic Complexity score are harder to test, and more prone to
 * bugs because of the sheer number of branching logic paths available. This class' is made
 * up of a number of small methods, each of whom does Crud/FLS Checks and therefor every method
 * includes at least one branching path. Because this class is designed to teach safe DML
 * I've decided to mute this warning. Other classes in this Repo do not have such a high
 * Cyclomatic Complexity, because the ratio of logic to if/else statements is much lower.
 *
 */
public class DMLRecipes_Tests {
    @isTest
    static void testInsertPositive() {
        Test.startTest();
        DMLRecipes.insertAccountViaInsertKeyword('mumbledore');
        Test.stopTest();

        List<Account> acct = [SELECT ID FROM Account WHERE name = 'mumbledore'];
        System.assertEquals(
            1,
            acct.size(),
            'We should have found the account we just created'
        );
    }

    @isTest
    static void testInsertNegative() {
        Test.startTest();
        Boolean didCatchTheRightException = false;
        try {
            DMLRecipes.insertAccountViaInsertKeyword('');
        } catch (DMLRecipes.CustomDmlException theException) {
            if (theException.getMessage().contains('Failed')) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();

        System.assert(
            didCatchTheRightException,
            'Should have caught the exception'
        );
    }

    @isTest
    static void testDatabaseMethodInsertPositive() {
        Test.startTest();
        DMLRecipes.insertAccountsViaDatabaseMethod('Texas', false);
        Test.stopTest();

        List<Account> acct = [
            SELECT ID, Name
            FROM Account
            WHERE name = 'Texas'
        ];

        System.assert(
            acct.size() == 1,
            'Expected the list of accounts to have a single account'
        );
        System.assert(
            acct[0].name == 'Texas',
            'Expected the account name to be Texas'
        );
    }

    @isTest
    static void testDatabaseMethodInsertNegative() {
        Test.startTest();
        Boolean didCatchTheRightException = false;
        try {
            DMLRecipes.insertAccountsViaDatabaseMethod('Texas', true);
        } catch (DMLRecipes.CustomDmlException theException) {
            if (theException.getMessage().contains('Failed')) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();

        System.assert(
            didCatchTheRightException,
            'Should have caught the exception'
        );
    }

    @isTest
    static void testUpsertAccountViaUpsertKeywordTestPositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');

        Test.startTest();
        DMLRecipes.upsertAccountViaUpsertKeyword(acct);
        Test.stopTest();

        List<Account> resultingAccounts = [
            SELECT Name
            FROM Account
            WHERE name = :acct.Name
        ];
        System.assertEquals(
            1,
            resultingAccounts.size(),
            'We expect to find a single account with that name'
        );
    }

    @isTest
    static void testUpsertAccountViaUpsertKeywordPositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct; // Gives us the ID property.
        List<Account> accounts = [SELECT Name FROM Account WHERE id = :acct.Id];

        System.assertEquals(
            1,
            accounts.size(),
            'We expect to find one account'
        );

        Test.startTest();
        acct.Name = 'flufflernutter';
        DMLRecipes.upsertAccountViaUpsertKeyword(acct);
        Test.stopTest();

        List<Account> testAccounts = [SELECT Name FROM Account];

        System.assertEquals(
            1,
            testAccounts.size(),
            'There should be only one account'
        );
    }

    @isTest
    static void testUpsertAccountViaUpsertKeywordNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'Ca');
        // Note: this is an intentionally invalid ID, used to trigger the failure case.
        acct.Id = '0019A000008GTAYQA4'; //NOPMD

        Boolean didCatchTheRightException = false;
        try {
            DMLRecipes.upsertAccountViaUpsertKeyword(acct);
        } catch (DmlException dmlexception) {
            if (dmlexception.getDmlMessage(0) == 'invalid cross reference id') {
                didCatchTheRightException = true;
            }
        }
        System.assert(
            didCatchTheRightException,
            'Expected to get an Invalid Cross Reference Id exception'
        );
    }

    @isTest
    static void testUpsertAccountViaDatabaseMethodNegative() {
        Account badAcct = TestDataHelpers.genAccountWithOptions(true, 'Ca');
        // Note: this is an intentionally invalid ID, used to trigger the failure case.
        badAcct.Id = '0019A000008GTAYQA4'; //NOPMD
        Database.UpsertResult result;
        Boolean didCatchTheRightException = false;
        try {
            result = DMLRecipes.upsertAccountViaDatabaseMethod(badAcct, true);
        } catch (DMLException dmlexception) {
            if (dmlexception.getDmlMessage(0) == 'invalid cross reference id') {
                didCatchTheRightException = true;
            }
        }
        System.assert(
            didCatchTheRightException,
            'Expected to get an Invalid Cross Reference Id exception'
        );
    }

    @isTest
    static void testUpdateAcccountViaKeywordPositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;

        Test.startTest();
        acct.Name += ' + Updated';
        DMLRecipes.updateAcccountViaKeyword(new List<Account>{ acct });
        Test.stopTest();

        String checkAcct = [SELECT name FROM Account WHERE id = :acct.Id].Name;
        System.assert(
            checkAcct.containsIgnoreCase('updated'),
            'Expected to find the keyword updated in the account name'
        );
    }

    @isTest
    static void testUpdateAcccountViaKeywordNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            // Note: this is an intentionally invalid id used for triggering an error state
            acct.Id = '0019A000008GTAYQA4'; //NOPMD
            DMLRecipes.updateAcccountViaKeyword(new List<Account>{ acct });
        } catch (DMLRecipes.CustomDmlException theException) {
            if (theException.getMessage().contains('Failed')) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();

        System.assert(
            didCatchTheRightException,
            'Expected to receive a CustomDMLException with message Failed'
        );
    }

    @isTest
    static void testUpdateAcccountViaDatabaseMethodPositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;

        Test.startTest();
        acct.Name += ' + Updated';
        DMLRecipes.updateAccountViaDatabaseMethod(new List<Account>{ acct });
        Test.stopTest();

        String checkAcct = [SELECT name FROM Account WHERE id = :acct.Id].Name;
        System.assert(
            checkAcct.containsIgnoreCase('updated'),
            'Expected to find the keyword updated in the account name'
        );
    }

    @isTest
    static void testUpdateAcccountViaDatabaseMethodNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            // Note: This is an intentionally invalid ID used for triggering an error state
            acct.Id = '0019A000008GTAYQA4'; //NOPMD
            DMLRecipes.updateAccountViaDatabaseMethod(
                new List<Account>{ acct }
            );
        } catch (DMLRecipes.CustomDmlException theException) {
            if (theException.getMessage().contains('Failed')) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();

        System.assert(
            didCatchTheRightException,
            'Expected to recieve a CustomDMLException with message Failed'
        );
    }

    @isTest
    static void testDeleteAccountViaKeywordPositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;

        Test.startTest();
        DMLRecipes.deleteAccountViaKeyword(new List<Account>{ acct });
        Test.stopTest();
        try {
            String checkAcct = [SELECT name FROM Account WHERE id = :acct.Id]
            .Name; //NOPMD
        } catch (QueryException qe) {
            if (
                qe.getMessage()
                    .containsIgnoreCase('list has no rows for assignment')
            ) {
                System.assert(
                    true,
                    'Expected to get query exception as record was deleted'
                );
            }
        }
    }

    @isTest
    static void testDeleteAccountViaKeywordNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        delete acct;

        Test.startTest();
        try {
            DMLRecipes.deleteAccountViaKeyword(new List<Account>{ acct });
        } catch (DMLRecipes.CustomDmlException cde) {
            if (cde.getMessage().containsIgnoreCase('failed')) {
                System.assert(
                    true,
                    'Expected to get query exception as record was deleted'
                );
            }
        }
        Test.stopTest();
    }

    @isTest
    static void testDeleteAccountViaDatabaseMethodPositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;

        Test.startTest();
        DMLRecipes.deleteAccountViaDatabaseMethod(new List<Account>{ acct });
        Test.stopTest();
        try {
            String checkAcct = [SELECT name FROM Account WHERE id = :acct.Id]
            .Name; //NOPMD
        } catch (QueryException qe) {
            if (
                qe.getMessage()
                    .containsIgnoreCase('list has no rows for assignment')
            ) {
                System.assert(
                    true,
                    'Expected to get query exception as record was deleted'
                );
            }
        }
    }

    @isTest
    static void testDeleteAccountViaDatabaseMethodNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'It');
        insert acct;
        delete acct;

        Test.startTest();
        try {
            DMLRecipes.deleteAccountViaDatabaseMethod(
                new List<Account>{ acct }
            );
        } catch (DMLRecipes.CustomDmlException cde) {
            if (cde.getMessage().containsIgnoreCase('failed')) {
                System.assert(
                    true,
                    'Expected to get query exception as record was deleted'
                );
            }
        }
        Test.stopTest();
    }

    @isTest
    static void testUndeleteAccountViaKeywordPositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct;
        delete acct;
        Test.startTest();
        DMLRecipes.undeleteAccountViaKeyword(new List<Account>{ acct });
        Test.stopTest();
        List<Account> checkAcct = [
            SELECT name
            FROM Account
            WHERE id = :acct.Id
        ];
        System.assert(
            checkAcct.size() == 1,
            'Expected to find a single account'
        );
    }

    @isTest
    static void testUndeleteAccountViaKeywordNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct;
        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            DMLRecipes.undeleteAccountViaKeyword(new List<Account>{ acct });
        } catch (DMLRecipes.CustomDmlException theException) {
            if (theException.getMessage().contains('Failed')) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();
        System.assert(
            didCatchTheRightException,
            'Expected to find a single account'
        );
    }

    @isTest
    static void testUndeleteAccountViaDatabaseMethodPositive() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct;
        delete acct;
        Test.startTest();
        DMLRecipes.undeleteAccountViaDatabaseMethod(new List<Account>{ acct });
        Test.stopTest();
        List<Account> checkAcct = [
            SELECT name
            FROM Account
            WHERE id = :acct.Id
        ];
        System.assert(
            checkAcct.size() == 1,
            'Expected to find a single account'
        );
    }

    @isTest
    static void testUndeleteAccountViaDatabaseMethodNegative() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'IR');
        insert acct;
        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            DMLRecipes.undeleteAccountViaDatabaseMethod(
                new List<Account>{ acct }
            );
        } catch (DMLRecipes.CustomDmlException theException) {
            if (theException.getMessage().contains('Failed')) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();
        System.assert(
            didCatchTheRightException,
            'Expected to find a single account'
        );
    }
}
