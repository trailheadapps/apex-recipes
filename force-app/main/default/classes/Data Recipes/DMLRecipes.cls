/**
 * @description Demonstrates various ways of making Data Manipulation Language
 * (DML) calls. Note that this class demonstrates both Database.* methods as
 * well as DML Keywords.
 *
 * Note: There is a @suppressWarnings annotation on this class for Cyclomatic
 * Complexity. You can read more about what Cyclomatic Complexity is here:
 * https://en.wikipedia.org/wiki/Cyclomatic_complexity Classes with a high
 * Cyclomatic Compelexity score are harder to test, and more prone to bugs
 * because of the sheer number of branching logic paths available. This class
 * is made up of a number of small methods, each of whom does CRUD/FLS Checks
 * and therefor every method includes at least one branching path - but not
 * much else. Because this class is designed to teach safe DML I've decided to
 * mute this warning. Other classes in this repository do not have such a high
 * Cyclomatic Complexity because the ratio of logic to if/else statments is much
 * lower.
 *
 * @group Data Recipes
 * @see CanTheUser
 */
@SuppressWarnings('PMD.CyclomaticComplexity')
public inherited sharing class DMLRecipes {
    /**
     * @description This exception is for throwing a custom exception to
     * highlight how negative tests operate.
     */
    public class CustomDMLException extends Exception {
    }

    /**
     * @description Demonstrates how to use the insert keyword to persist a
     * net-new record to the database
     * @param  name name passed through to the name of the created account
     * @example DMLRecipes.insertAccountViaInsertKeyword('Hello');
     */
    public static void insertAccountViaInsertKeyword(String name) {
        Account acct = new Account();
        acct.name = name;

        try {
            if (CanTheUser.create(acct)) {
                insert acct; //NOPMD
                //- Note: This will cause PMD to raise a violation for not
                // checking CRUD/FLS. However, we're doing just that in the Line
                // above - PMD just isn't aware of CanTheUser.*
            }
        } catch (DMLException DMLe) {
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @description Demonstrates how to use the Database.insert() method to
     * persist a net-new record to the database.
     * @param  name         name Passed through to the account created
     * @param  allOrNothing allOrNothing determines whether or not all accounts
     * to be inserted must insert successfully
     * @example
     * DMLRecipes.insertAccountsViaDatabaseMethod('Hello', false);
     */
    public static void insertAccountsViaDatabaseMethod(
        String name,
        Boolean allOrNothing
    ) {
        Account acct = new Account(name = name);
        Account acct2 = new Account();

        try {
            if (CanTheUser.create(acct)) {
                Database.insert(new List<Account>{ acct, acct2 }, allOrNothing);
            }
        } catch (DMLException DMLe) {
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @description Demonstrates the use of the upsert keyword to either insert
     * or update a record
     * @param acct account to upsert
     * @return Account
     * @example
     * DMLRecipes.upsertAccountViaUpsertKeyword(new Account(name='Hello World'));
     **/
    public static Account upsertAccountViaUpsertKeyword(Account acct) {
        //Upsert = (up)date or in(sert)
        if (CanTheUser.create(acct) && CanTheUser.edit(acct)) {
            try {
                upsert acct; //NOPMD
                //- Note: This will cause PMD to raise a violation for not
                // checking CRUD/FLS. However, we're doing just that in the Line
                // above - PMD just isn't aware of CanTheUser.*
            } catch (DmlException dmle) {
                System.debug(LoggingLevel.INFO, dmle.getMessage());
                throw dmle;
            }
        }
        return acct;
    }

    /**
     * @description Upserts an account with a potential of all or nothing, using
     * the Database.upsert method
     * @param acct The account object to upsert
     * @param allOrNothing all or nothing flag
     * @return UpsertResult
     * @example
     * DMLRecipes.upsertAccountViaDatabaseMethod(
     *            new Account(name='Hello World'), false);
     **/
    public static Database.UpsertResult upsertAccountViaDatabaseMethod(
        Account acct,
        Boolean allOrNothing
    ) {
        Database.UpsertResult results;
        if (CanTheUser.create(acct) && CanTheUser.edit(acct)) {
            results = Database.upsert(acct, allOrNothing);
        } else {
            throw new CustomDMLException(
                'User has no access to create and edit accounts'
            );
        }
        return results;
    }

    /**
     * @description Demonstrates how to Update a list of accounts via the Update
     * DML keyword
     * @param accts List of accounts to update
     * @return List<Account>
     * @example
     * Account acct = new Account(name='Hello World');
     * insert acct;
     * DMLRecipes.updateAcccountViaKeyword(acct);
     **/
    public static List<Account> updateAcccountViaKeyword(List<Account> accts) {
        for (Account acct : accts) {
            acct.Name += ' Updated via Keyword';
        }
        try {
            if (CanTheUser.edit(accts[0])) {
                update accts;
            }
        } catch (DMLException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return accts;
    }

    /**
     * @description Demonstrates how to update a list of accounts via the
     * Database.update() method
     * @param accts list of accounts to update
     * @return List<Account>
     * @example
     * List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
     * insert accounts;
     * List<Account> results = DMLRecipes.updateAccountViaDatabaseMethod(accounts);
     * System.debug(results);
     **/
    public static List<Account> updateAccountViaDatabaseMethod(
        List<Account> accts
    ) {
        for (Account acct : accts) {
            acct.Name += ' Updated via Keyword';
        }
        try {
            if (CanTheUser.edit(accts[0])) {
                try {
                    Database.update(accts);
                } catch (DmlException dmle) {
                    System.debug(LoggingLevel.INFO, dmle.getMessage());
                    throw dmle;
                }
            }
        } catch (DMLException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return accts;
    }

    /**
     * @description Deletes a list of accounts via the delete DML keyword
     * @param accts list of accounts to delete
     * @example
     * List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
     * insert accounts;
     * DMLRecipes.deleteAccountViaDatabaseMethod(accounts);
     **/
    public static Void deleteAccountViaKeyword(List<Account> accts) {
        try {
            if (CanTheUser.destroy(accts[0])) {
                try {
                    delete accts;
                } catch (DmlException dmle) {
                    System.debug(LoggingLevel.INFO, dmle.getMessage());
                }
            }
        } catch (DMLException DMLe) {
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @description Deletes a list of accounts via the Database.delete method
     * @param accts List of Accounts to delete
     * @example
     * List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
     * insert accounts;
     * DMLRecipes.deleteAccountViaDatabaseMethod(accounts);
     **/
    public static Void deleteAccountViaDatabaseMethod(List<Account> accts) {
        try {
            if (CanTheUser.destroy(accts[0])) {
                Database.delete(accts);
            }
        } catch (DMLException DMLe) {
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @description Undeletes a list of accounts via the undelete DML keyword
     * @param accts List of accounts to undelete
     * @return List<Account>
     * @example
     * List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
     * insert accounts;
     * delete accounts;
     * List<Account> results = DMLRecipes.undeleteAccountViaKeyword(accounts);
     * System.debug(results);
     **/
    public static List<Account> undeleteAccountViaKeyword(List<Account> accts) {
        try {
            if (CanTheUser.read(accts[0])) {
                try {
                    undelete accts;
                } catch (DmlException dmle) {
                    System.debug(LoggingLevel.INFO, dmle.getMessage());
                    throw dmle;
                }
            }
        } catch (DMLException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return accts;
    }

    /**
     * @description undeletes a list of accounts via the Database.undelete method.
     * @param accts list of accounts to undelete
     * @return List<Account>
     * @example
     * List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
     * insert accounts;
     * delete accounts;
     * List<Account> results = DMLRecipes.undeleteAccountViaDatabaseMethod(accounts);
     * System.debug(results);
     **/
    public static List<Account> undeleteAccountViaDatabaseMethod(
        List<Account> accts
    ) {
        try {
            if (CanTheUser.read(accts[0])) {
                Database.undelete(accts);
            }
        } catch (DMLException DMLe) {
            throw new CustomDMLException('Failed');
        }
        return accts;
    }
}
