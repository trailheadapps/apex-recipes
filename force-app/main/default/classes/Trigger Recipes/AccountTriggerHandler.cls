/**
 * @description Demonstrates how to construct a TriggerHandler using the
 * trigger handler framework found in Shared Code/TriggerHandler.cls
 * @group Trigger Recipes
 * @see TriggerHandler
 * @see AccountServiceLayer
 */
public with sharing class AccountTriggerHandler extends TriggerHandler {
    private List<Account> triggerNew;
    private List<Account> triggerOld;
    private Map<Id, Account> triggerMapNew;
    private Map<Id, Account> triggerMapOld;

    @TestVisible
    private static Exception circuitBreaker;

    /**
     * @description Custom exception class
     */
    public class AccountTriggerHandlerException extends Exception {
    }

    /**
     * @description Constructor that sets class variables based on Trigger
     * context vars
     */
    public AccountTriggerHandler() {
        this.triggerOld = (List<Account>) Trigger.old;
        this.triggerNew = (List<Account>) Trigger.new;
        this.triggerMapNew = (Map<Id, Account>) Trigger.newMap;
        this.triggerMapOld = (Map<Id, Account>) Trigger.oldMap;
    }

    // Insert Contexts

    /**
     * @description Before Insert context method. Called automatically by the
     * trigger framework this class extends.
     * @example
     * ```
     * Account[] accounts = new Account[]();
     * accounts.add(new Account(name='example 1'));
     * accounts.add(new Account(name='example 2'));
     * insert accounts;
     * ```
     */
    public override void beforeInsert() {
        // Note: You don't need to put your logic directly in this method.
        // If, for instance, you have a service layer, you can call methods on
        // those classes here, just like this:
        AccountServiceLayer.incrementCounterInDescription(
            this.triggerNew,
            false
        );
        /**
         * Using this context method as a 'broker' to call other
         * classes/methods allows you to keep your trigger logic in individual
         * classes, keeping to the single responbility principle. It also allows
         * you to enforce the order in which your various bits of trigger logic
         * execute something that's not possible when you have mulitple triggers
         * on the same object.
         */
    }

    /**
     * @description after insert context method. Called automatically by the
     * trigger framework this class extends
     * @example
     * ```
     * Account[] accounts = new Account[]();
     * accounts.add(new Account(name='example 1'));
     * accounts.add(new Account(name='example 2'));
     * insert accounts;
     * ```
     */
    public override void afterInsert() {
        AccountServiceLayer.changeShippingStreet(
            this.triggerNew,
            System.AccessLevel.SYSTEM_MODE
        );
    }

    // Update Contexts

    /**
     * @description before update context method. Called automatically by the
     * trigger framework this class extends
     * @example
     * ```
     * Account[] accounts = new Account[]();
     * accounts.add(new Account(name='example 1'));
     * accounts.add(new Account(name='example 2'));
     * insert accounts;
     * accounts[0].name += ' Updated';
     * update accounts;
     * ```
     */
    public override void beforeUpdate() {
        // While it's often best to utilize these context methods to call other
        // classes and methods it's entirely possible to place your trigger
        // logic directly in this method. Especially if that logic is short.
        for (Account acct : this.triggerNew) {
            // You can call addError('msg') on records that fail validation.
            // Doing so prevents them from being saved.
            if (acct.ShippingState?.length() > 2) {
                acct.addError('Shipping State Length exceeds maximum allowed');
            }
            acct.ShippingStreet += ' before update trigger';
        }
        // Remember, because this is a before context trigger, we don't need to
        // DML these records.
    }

    /**
     * @description after update context method. Called automatically by the
     * trigger framework this class extends
     *
     * Note: this method contains a PMD false-positive report about CRUD
     * checking before insert. However, trigger code is run in system mode,
     * regardless of users, so it doesn't make sense to check for Account and
     * Task permissions. This code is therefore only safe to execute in the
     * context of a trigger.
     * @example
     * ```
     * Account[] accounts = new Account[]();
     * accounts.add(new Account(name='example 1'));
     * accounts.add(new Account(name='example 2'));
     * insert accounts;
     * accounts[0].name += ' Updated';
     * update accounts;
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public override void afterUpdate() {
        List<Task> newTasks = new List<Task>();
        for (Account acct : this.triggerNew) {
            Task tsk = new Task(
                WhatId = acct.Id,
                Subject = 'Account was updated, please verify'
            );
            newTasks.add(tsk);
        }

        try {
            if (
                Test.isRunningTest() &&
                AccountTriggerHandler.circuitBreaker != null
            ) {
                throw AccountTriggerHandler.circuitBreaker;
            }
            insert newTasks;
        } catch (DmlException dmle) {
            System.debug(
                LoggingLevel.INFO,
                'Inserting Tasks for newly updated accounts failed with a DML exception. Details: ' +
                dmle.getMessage()
            );
            throw new AccountTriggerHandlerException('Failed to insert tasks');
        }
    }

    // Delete Contexts

    /**
     * @description before delete context method. Called automatically by the
     * trigger framework this class extends
     *
     * Note: this method contains a PMD false-positive report about CRUD
     * checking before insert. However, trigger code is run in system mode,
     * regardless of users, so it doesn't make sense to check for Account and
     * Task permissions. This code is therefore only safe to execute in the
     * context of a trigger.
     *
     * @example
     * ```
     * Account[] accounts = new Account[]();
     * accounts.add(new Account(name='example 1'));
     * insert accounts;
     * delete accounts;
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public override void beforeDelete() {
        System.debug(LoggingLevel.INFO, 'Deleting an account');
        List<Account> clonedAccounts = new List<Account>();
        for (Account acct : this.triggerOld) {
            clonedAccounts.add(acct.clone());
        }

        try {
            insert clonedAccounts;
        } catch (DmlException dmle) {
            System.debug(
                LoggingLevel.INFO,
                'Inserting cloned accounts failed with DML exception. Details: ' +
                dmle.getMessage()
            );
        }
    }

    /**
     * @description after delete context method. Called automatically by the
     * trigger framework this class extends
     *
     * Note: this method contains a PMD false-positive report about CRUD
     * checking before insert. However, trigger code is run in system mode,
     * regardless of users, so it doesn't make sense to check for Account and
     * Task permissions. This code is therefore only safe to execute in the
     * context of a trigger.
     *
     * @example
     * ```
     * Account[] accounts = new Account[]();
     * accounts.add(new Account(name='example 1'));
     * insert accounts;
     * delete accounts;
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public override void afterDelete() {
        System.debug(LoggingLevel.INFO, 'After Delete Action');
        List<Task> newTasks = new List<Task>();
        for (Account acct : this.triggerOld) {
            Task tsk = new Task(Subject = 'Account was deleted, please verify');
            newTasks.add(tsk);
        }

        try {
            insert newTasks;
        } catch (DmlException dmle) {
            System.debug(
                LoggingLevel.INFO,
                'Inserting Tasks for deleted accounts failed with a DML exception. Details: ' +
                dmle.getMessage()
            );
            throw new AccountTriggerHandlerException(
                'Failed to insert Tasks: ' + dmle.getMessage()
            );
        }
    }

    // Undelete Contexts

    /**
     * @description after undelete context method. Called automatically by the
     * trigger framework this class extends
     *
     * Note: this method contains a PMD false-positive report about CRUD
     * checking before insert. However, trigger code is run in system mode,
     * regardless of users, so it doesn't make sense to check for Account and
     * Task permissions. This code is therefore only safe to execute in the
     * context of a trigger.
     *
     * @example
     * ```
     * Account[] accounts = new Account[]();
     * accounts.add(new Account(name='example 1'));
     * insert accounts;
     * delete accounts;
     * undelete accounts;
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public override void afterUndelete() {
        System.debug(LoggingLevel.INFO, 'After undelete context method called');
        List<Task> newTasks = new List<Task>();
        for (Account acct : this.triggerNew) {
            Task tsk = new Task(
                WhatId = acct.Id,
                Subject = 'Previously deleted account restored. Please verify'
            );
            newTasks.add(tsk);
        }

        try {
            insert newTasks;
        } catch (DmlException dmle) {
            System.debug(
                LoggingLevel.INFO,
                'Inserting Tasks for restored accounts failed with a DML exception. Details: ' +
                dmle.getMessage()
            );
        }
    }
}
