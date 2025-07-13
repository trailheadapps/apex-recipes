/**
 * @description Demonstrates what a Service Layer object might look like
 * for teh Account object. Demonstrates the placement of shared code that
 * is specific to the Account Object, and contains code that is called
 * by the AccountTriggerHandler
 * @group Shared Code
 * @see AccountTriggerHandler
 */
public with sharing class AccountServiceLayer {
    @testVisible
    private static String didExecuteMethod;

    /**
     * @description Internal custom exception class
     */
    public class ASLException extends Exception {
    }

    /**
     * @description Method exists to demonstrate what it might look like to
     *  call a service layer method from a trigger handler.
     * @param toLog String to Log.
     * @example
     * ```
     * AccountServiceLayer.justWriteALogStatement('Hello World');
     * ```
     */
    public static void justWriteALogStatement(String toLog) {
        AccountServiceLayer.didExecuteMethod = toLog;
        System.debug(
            LoggingLevel.INFO,
            'Account Id = and log statement = ' + toLog
        );
    }

    /**
     * @description Changes the account's Shipping Street field to a hardcoded
     * value. You should do this kind of work in a before trigger, but this is a
     * demo.
     *
     * Note: This method contains a false-positive PMD viloation around not
     * checking FLS/CRUD before doing DML. This is because PMD is unaware of
     * what the CanTheUser call right before it is doing - namely checking CRUD.
     *
     * @param accounts List of account objects to change the shipping street on
     * @example
     * ```
     * Account[] accounts = [SELECT Name FROM Account LIMIT 50];
     * AccountServiceLayer.changeShippingStreet(accounts);
     * System.debug([SELECT Name, ShippingStreet FROM Account WHERE Id in : accounts]);
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static void changeShippingStreet(
        List<Account> accounts,
        System.AccessLevel accessLevel
    ) {
        List<Account> updated = new List<Account>();
        for (Account account : accounts) {
            Account uAcct = account.clone(true);
            uAcct.ShippingStreet = '229b Baker st.';
            updated.add(uAcct);
        }
        Database.update(updated, accessLevel);
    }

    /**
     * @description Increments a counter stored in the Description field.
     *  Demonstration method of the kind of work a service layer may do.
     * @param incomingAccounts List of Account Objects.
     * @param save Boolean determining if DML update is requested.
     * @example
     * ```
     * Account[] accounts = [SELECT Description FROM Account LIMIT 50];
     * AccountServiceLayer.incrementCounterInDescription(accounts, true);
     * System.debug([SELECT Name, Description FROM Account WHERE Id in : accounts]);
     * ```
     */
    public static List<Account> incrementCounterInDescription(
        List<Account> incomingAccounts,
        Boolean save
    ) {
        for (Account ia : incomingAccounts) {
            Integer counter = 0;
            try {
                if (ia.Description != null) {
                    counter = Integer.valueOf(ia.Description);
                }
            } catch (System.TypeException te) {
                System.debug(
                    LoggingLevel.INFO,
                    'failed safely to 0 during init'
                );
            }
            counter++;
            ia.Description = String.valueOf(counter);
        }
        if (save) {
            safelySave(incomingAccounts);
        }
        return incomingAccounts;
    }

    /**
     * @description Updates a list of accounts if the user has access to update
     *  the Account Object. Demonstrates simple usage of
     *  `Security.stripInacessible()`, and DML with a try/catch block.
     * @param accounts
     * @example
     * ```
     * Account[] accounts = [SELECT Name FROM Account LIMIT 50];
     * for(Account acct: accounts){
     *      acct.description = 'safely save example';
     * }
     * AccountServiceLayer.safelySave(accounts);
     * System.debug([SELECT Name, Description FROM Account WHERE Id in : accounts]);
     * ```
     */
    @testVisible
    private static void safelySave(List<Account> accounts) {
        try {
            System.SObjectAccessDecision decision = Security.stripInaccessible(
                AccessType.UPDATABLE,
                accounts
            );
            update as user decision.getRecords();
        } catch (DmlException dmle) {
            System.debug(
                LoggingLevel.INFO,
                'Hey, a DML error occurred while updating.'
            );
            throw new ASLException(dmle.getMessage());
        } catch (System.SecurityException se) {
            throw new ASLException(se.getMessage());
        } catch (System.NoAccessException nae) {
            throw new ASLException(nae.getMessage());
        }
    }
}
