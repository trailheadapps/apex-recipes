/**
 * @description Demonstrates how to write Platform Event publish success and failure callbacks
 * @group Platform Event Recipes
 * @see PlatformEventRecipes
 */
public with sharing class PlatformEventPublishCallback implements EventBus.EventPublishFailureCallback, EventBus.EventPublishSuccessCallback {
    /**
     * Map that correlates event UUIDs with events
     */
    private Map<String, Event_Recipes_Demo__e> eventMap;

    public PlatformEventPublishCallback(List<Event_Recipes_Demo__e> events) {
        this.eventMap = new Map<String, Event_Recipes_Demo__e>();
        for (Event_Recipes_Demo__e event : events) {
            this.eventMap.put(event.EventUuid, event);
        }
    }

    /**
     * Callback for events that failed to publish
     * Note: this method is always called by the automation user
     */
    public void onFailure(EventBus.FailureResult result) {
        // Get event UUIDs from the result
        List<String> eventUuids = result.getEventUuids();

        // Sample use case: create a follow-up task for failed events
        insertTask(eventUuids, false);
    }

    /**
     * Callback for events that were successfully published
     * Note: this method is always called by the automation user
     */
    public void onSuccess(EventBus.SuccessResult result) {
        // Get event UUIDs from the result
        List<String> eventUuids = result.getEventUuids();

        // Sample use case: create a follow-up task for success events
        insertTask(eventUuids, true);
    }

    private void insertTask(List<String> eventUuids, Boolean isSuccess) {
        // Load accounts related to events
        Set<Id> relatedAccountIds = new Set<Id>();
        for (String eventUuid : eventUuids) {
            Event_Recipes_Demo__e originalEvent = this.eventMap.get(eventUuid);
            relatedAccountIds.add(originalEvent.AccountId__c);
        }
        Map<Id, Account> relatedAccounts = new Map<Id, Account>(
            [
                SELECT OwnerId
                FROM Account
                WHERE Id = :relatedAccountIds
                WITH SYSTEM_MODE
            ]
        );

        // Prepare and insert tasks
        List<Task> tasks = new List<Task>();
        for (String eventUuid : eventUuids) {
            // Retrieve event data
            Event_Recipes_Demo__e originalEvent = this.eventMap.get(eventUuid);

            // Create a task on the related account
            Task t = new Task();
            t.WhatId = originalEvent.AccountId__c;
            t.ActivityDate = Date.today().addDays(1);
            if (isSuccess == true) {
                t.Subject = 'Follow up on successful event publishing.';
                t.Description =
                    'Events published successfully. Event UUID: ' +
                    eventUuid +
                    ' User: ' +
                    UserInfo.getName();
            } else {
                t.Subject = 'Follow up on event publishing failure.';
                t.Description =
                    'Events failed to publish. Event UUID: ' + eventUuid;
            }
            t.OwnerId = relatedAccounts.get(originalEvent.AccountId__c).OwnerId;
            tasks.add(t);
        }
        insert as system tasks;
    }
}
