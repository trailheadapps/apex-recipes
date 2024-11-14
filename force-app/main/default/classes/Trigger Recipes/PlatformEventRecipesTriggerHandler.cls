/**
 * @description Demonstrates how to construct a trigger handler for
 * platform events
 * @group Trigger Recipes
 * @see TriggerHandler
 */
public with sharing class PlatformEventRecipesTriggerHandler extends TriggerHandler {
    private List<Event_Recipes_Demo__e> triggerNew;

    /**
     * @description Constructor responsible for transfering Trigger.new into a
     * class variable
     */
    public PlatformEventRecipesTriggerHandler() {
        this.triggerNew = (List<Event_Recipes_Demo__e>) Trigger.new;
    }

    /**
     * @description This is an admittedly contrived example.
     * The key to Platform Event's utility is their interoperabilty.
     * This recipe demonstrate what happens when a Platform Event is committed.
     * Platform Event Triggers fire regardless of how the event was created:
     *  - You can create these events either through Apex, low code tools
     *  - and external system integrations
     *
     * @example
     * ```
     * Account acct = new Account(Name = 'Awesome Events Ltd.');
     * insert acct;
     * Event_Recipes_Demo__e evt = new Event_Recipes_Demo__e(AccountId__c = acct.id, Title__c='Updated website', Url__c = 'https://developer.salesforce.com');
     * Database.saveResults result = PlatformEventsRecipes.publishEvent(evt);
     * System.debug(result + [SELECT Name, Website FROM Account WHERE Id = :acct.id]);
     * ```
     */
    public override void afterInsert() {
        Set<Id> accountIds = new Set<Id>();
        for (Event_Recipes_Demo__e evt : this.triggerNew) {
            accountIds.add(evt.AccountId__c);
        }

        Map<Id, Account> accounts = new Map<Id, Account>(
            [SELECT Name FROM Account WHERE Id IN :accountIds]
        );

        for (Event_Recipes_Demo__e evt : this.triggerNew) {
            accounts.get(evt.AccountId__c).Website = evt.Url__c;
        }

        update accounts.values();
    }
}
