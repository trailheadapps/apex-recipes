/**
 * @description Demonstrates various ways of making Data Manipulation Language
 * (DML) calls. Note that this class demonstrates both Database.* methods as
 * well as DML Keywords.
 * @group Data Recipes
 */
public with sharing class DMLRecipes {
    /**
     * @description This exception is for throwing a custom exception to
     * highlight how negative tests operate.
     */
    public class CustomDMLException extends Exception {
    }

    /**
     * @description Demonstrates how to use the insert keyword to persist a
     * net-new record to the database in system mode
     * @param  name name passed through to the name of the created account
     * @example DMLRecipes.insertAccountViaInsertKeywordInSystemMode('Hello');
     */
    public static void insertAccountViaInsertKeywordInSystemMode(String name) {
        Account acct = new Account();
        acct.Name = name;
        try {
            insert acct;
        } catch (DmlException ex) {
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @description Demonstrates how to use the insert keyword to persist a
     * net-new record to the database in user mode
     * @param  name name passed through to the name of the created account
     * @example
     * DMLRecipes.insertAccountViaInsertKeywordInUserMode('Hello');
     */
    public static void insertAccountViaInsertKeywordInUserMode(String name) {
        Account acct = new Account();
        acct.Name = name;
        try {
            insert as user acct;
        } catch (SecurityException ex) {
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
     * DMLRecipes.insertAccountsViaDatabaseMethod('Hello', false, AccessLevel.USER_MODE);
     */
    public static void insertAccountsViaDatabaseMethod(
        String name,
        Boolean allOrNothing,
        System.AccessLevel accessLevel
    ) {
        Account acct = new Account(Name = name);
        Account acct2 = new Account();
        try {
            Database.insert(
                new List<Account>{ acct, acct2 },
                allOrNothing,
                accessLevel
            );
            // In user mode a security exception is thrown
            // while in the system mode a DML Exception is thrown
        } catch (SecurityException ex) {
            throw new CustomDMLException('Failed');
        } catch (DmlException ex) {
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @description Demonstrates the use of the upsert keyword to either insert
     * or update a record in system mode
     * @param acct account to upsert
     * @return Account
     * @example
     * DMLRecipes.upsertAccountViaUpsertKeywordInSystemMode(new Account(name='Hello World'));
     **/
    public static Account upsertAccountViaUpsertKeywordInSystemMode(
        Account acct
    ) {
        //Upsert = (up)date or in(sert)
        try {
            upsert acct;
        } catch (DmlException ex) {
            System.debug(LoggingLevel.INFO, ex.getMessage());
            throw ex;
        }
        return acct;
    }

    /**
     * @description Demonstrates the use of the upsert keyword to either insert
     * or update a record in user mode
     * @param acct account to upsert
     * @return Account
     * @example
     * DMLRecipes.upsertAccountViaUpsertKeywordInUserMode(new Account(name='Hello World'));
     **/
    public static Account upsertAccountViaUpsertKeywordInUserMode(
        Account acct
    ) {
        //Upsert = (up)date or in(sert)
        try {
            upsert as user acct;
        } catch (SecurityException ex) {
            System.debug(LoggingLevel.INFO, ex.getMessage());
            throw ex;
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
     *            new Account(name='Hello World'), false, AccessLevel.USER_MODE);
     **/
    public static Database.UpsertResult upsertAccountViaDatabaseMethod(
        Account acct,
        Boolean allOrNothing,
        System.AccessLevel accessLevel
    ) {
        try {
            Database.UpsertResult results;
            results = Database.upsert(acct, allOrNothing, accessLevel);
            return results;
        } catch (SecurityException ex) {
            throw new CustomDMLException('Failed');
        } catch (DmlException ex) {
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @description Demonstrates how to Update a list of accounts via the Update
     * DML keyword in System Mode
     * @param accts List of accounts to update
     * @return List<Account>
     * @example
     * Account acct = new Account(name='Hello World');
     * insert acct;
     * DMLRecipes.updateAcccountViaKeywordInSystemMode(acct);
     **/
    public static List<Account> updateAcccountViaKeywordInSystemMode(
        List<Account> accts
    ) {
        for (Account acct : accts) {
            acct.Name += ' Updated via Keyword';
        }
        try {
            update accts;
        } catch (DmlException ex) {
            throw new CustomDMLException('Failed');
        }
        return accts;
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
    public static List<Account> updateAcccountViaKeywordInUserMode(
        List<Account> accts
    ) {
        for (Account acct : accts) {
            acct.Name += ' Updated via Keyword';
        }
        try {
            update as user accts;
        } catch (SecurityException ex) {
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
     * List<Account> results = DMLRecipes.updateAccountViaDatabaseMethod(accounts, AccessLevel.USER_MODE);
     * System.debug(results);
     **/
    public static List<Account> updateAccountViaDatabaseMethod(
        List<Account> accts,
        System.AccessLevel accessLevel
    ) {
        for (Account acct : accts) {
            acct.Name += ' Updated via Keyword';
        }
        try {
            Database.update(accts, accessLevel);
            // In user mode a security exception is thrown
            // while in the system mode a DML Exception is thrown
        } catch (SecurityException ex) {
            System.debug(LoggingLevel.INFO, ex.getMessage());
            throw new CustomDMLException('Failed');
        } catch (DmlException ex) {
            System.debug(LoggingLevel.INFO, ex.getMessage());
            throw new CustomDMLException('Failed');
        }
        return accts;
    }

    /**
     * @description Deletes a list of accounts via the delete DML keyword
     * @param accts list of accounts to delete in system mode
     * @example
     * List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
     * insert accounts;
     * DMLRecipes.deleteAccountViaKeywordInSystemMode(accounts);
     **/
    public static Void deleteAccountViaKeywordInSystemMode(
        List<Account> accts
    ) {
        try {
            delete accts;
        } catch (DmlException ex) {
            System.debug(LoggingLevel.INFO, ex.getMessage());
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @description Deletes a list of accounts via the delete DML keyword
     * @param accts list of accounts to delete in user mode
     * @example
     * List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
     * insert accounts;
     * DMLRecipes.deleteAccountViaKeywordInUserMode(accounts);
     **/
    public static Void deleteAccountViaKeywordInUserMode(List<Account> accts) {
        try {
            delete as user accts;
        } catch (SecurityException ex) {
            System.debug(LoggingLevel.INFO, ex.getMessage());
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @description Deletes a list of accounts via the Database.delete method
     * @param accts List of Accounts to delete
     * @example
     * List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
     * insert accounts in user mode;
     * DMLRecipes.deleteAccountViaDatabaseMethod(accounts, AccessLevel.USER_MODE);
     **/
    public static Void deleteAccountViaDatabaseMethod(
        List<Account> accts,
        System.AccessLevel accessLevel
    ) {
        try {
            Database.delete(accts, accessLevel);
            // In user mode a security exception is thrown
            // while in the system mode a DML Exception is thrown
        } catch (SecurityException ex) {
            throw new CustomDMLException('Failed');
        } catch (DmlException ex) {
            throw new CustomDMLException('Failed');
        }
    }

    /**
     * @description Undeletes a list of accounts via the undelete DML keyword
     * @param accts List of accounts to undelete in user mode
     * @return List<Account>
     * @example
     * List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
     * insert accounts;
     * delete accounts;
     * List<Account> results = DMLRecipes.undeleteAccountViaKeywordInSystemMode(accounts);
     * System.debug(results);
     **/
    public static List<Account> undeleteAccountViaKeywordInSystemMode(
        List<Account> accts
    ) {
        try {
            undelete accts;
        } catch (DmlException dmle) {
            System.debug(LoggingLevel.INFO, dmle.getMessage());
            throw new CustomDMLException('Failed');
        }
        return accts;
    }

    /**
     * @description Undeletes a list of accounts via the undelete DML keyword
     * @param accts List of accounts to undelete in user mode
     * @return List<Account>
     * @example
     * List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
     * insert accounts;
     * delete accounts;
     * List<Account> results = DMLRecipes.undeleteAccountViaKeywordInUserMode(accounts);
     * System.debug(results);
     **/
    public static List<Account> undeleteAccountViaKeywordInUserMode(
        List<Account> accts
    ) {
        try {
            undelete as user accts;
        } catch (SecurityException ex) {
            System.debug(LoggingLevel.INFO, ex.getMessage());
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
     * List<Account> results = DMLRecipes.undeleteAccountViaDatabaseMethod(accounts, AccessLevel.USER_MODE);
     * System.debug(results);
     **/
    public static List<Account> undeleteAccountViaDatabaseMethod(
        List<Account> accts,
        System.AccessLevel accessLevel
    ) {
        try {
            Database.undelete(accts, accessLevel);
            // In user mode a security exception is thrown
            // while in the system mode a DML Exception is thrown
        } catch (SecurityException ex) {
            throw new CustomDMLException('Failed');
        } catch (DmlException ex) {
            throw new CustomDMLException('Failed');
        }
        return accts;
    }
}
