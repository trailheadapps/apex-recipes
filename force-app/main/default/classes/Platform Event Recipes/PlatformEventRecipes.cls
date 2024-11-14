/**
 * @description Demonstrates how to publish events on the event bus
 * @group Platform Event Recipes
 * @see PlatformEventRecipesTriggerHandler
 * @see PlatformEventPublishCallback
 */
public with sharing class PlatformEventRecipes {
    /**
     * @description Internal custom exception class
     */
    public class PlatformEventRecipesException extends Exception {
    }

    /**
     * @description publishes a platform event
     * @param event an `Event_Recipes_Demo__e` object
     * @example
     * ```
     * Account acct = new Account(Name = 'Awesome Events Ltd.');
     * insert acct;
     * Event_Recipes_Demo__e evt = new Event_Recipes_Demo__e(AccountId__c = acct.id, Title__c='Updated website', Url__c = 'https://developer.salesforce.com');
     * Database.saveResults result = PlatformEventsRecipes.publishEvent(evt);
     * System.debug(result);
     * ```
     */
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

    /**
     * @description publishes a platform event and handles success/failure with callbacks
     * @param event an `Event_Recipes_Demo__e` object
     * @example
     * ```
     * Account acct = new Account(Name = 'Awesome Events Ltd.');
     * insert acct;
     * // Creating the event via sObjectType.newSObject is required to obtain an EventUuid
     * Event_Recipes_Demo__e event = (Event_Recipes_Demo__e) Event_Recipes_Demo__e.sObjectType.newSObject(null, true);
     * event.AccountId__c = acct.Id;
     * event.Title__c = 'Updated website';
     * event.Url__c = 'https://developer.salesforce.com';
     * PlatformEventRecipes.publishEventWithCallbacks(event);
     * ```
     */
    public static Database.SaveResult publishEventWithCallbacks(
        Event_Recipes_Demo__e event
    ) {
        if (event.EventUuid == null) {
            throw new PlatformEventRecipesException(
                'EventUuid is required when using a publish callback with event correlation. Create the event via sObjectType.newSObject.'
            );
        }
        if (CanTheUser.create(event)) {
            PlatformEventPublishCallback.EventInfo eventInfo = new PlatformEventPublishCallback.EventInfo(
                event.EventUuid,
                event.AccountId__c
            );
            PlatformEventPublishCallback callback = new PlatformEventPublishCallback(
                new List<PlatformEventPublishCallback.EventInfo>{ eventInfo }
            );
            return EventBus.publish(event, callback);
        } else {
            throw new PlatformEventRecipesException(
                'User has no permission to publish event'
            );
        }
    }
}
