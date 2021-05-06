/**
 * @description Demonstrates how to publish events on the event bus
 * @group Platform Event Recipes
 * @see PlatformEventTriggerHandler, TriggerHandler
 */
public with sharing class PlatformEventRecipes {
    /**
     * @description Internal custom exception class
     */
    public class PlatformEventRecipesException extends Exception {
    }
    /**
     * @description publishes a platform event
     * @param event an Event_Recipes_Demo__e object
     * @return Database.SaveResult
     * @example
     * Account acct = new Account(name = 'Awesome Events Ltd.');
     * insert acct;
     * Event_Recipes_Demo__e evt = new Event_Recipes_Demo__e(accountId__c = acct.id, title__c='Updated website', url__c = 'https://developer.salesforce.com');
     * Database.saveResults result = PlatformEventsRecipes.publishEvent(evt);
     * System.debug(result);
     **/
    public static Database.SaveResult publishEvent(
        Event_Recipes_Demo__e event
    ) {
        if (CanTheUser.create(event)) {
            return EventBus.publish(event);
        } else {
            throw new PlatformEventRecipesException(
                'User has no permission to publish event'
            );
        }
    }
}
