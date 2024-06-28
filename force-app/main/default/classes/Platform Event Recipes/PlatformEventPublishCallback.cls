/**
 * @description Demonstrates how to write Platform Event publish success and failure callbacks
 * @group Platform Event Recipes
 * @see PlatformEventRecipes
 */
public with sharing class PlatformEventPublishCallback implements EventBus.EventPublishFailureCallback, EventBus.EventPublishSuccessCallback {
    /**
     * Map that correlates event UUIDs with event data
     */
    private Map<String, EventInfo> eventMap;

    public PlatformEventPublishCallback(List<EventInfo> eventInfos) {
        this.eventMap = new Map<String, EventInfo>();
        for (EventInfo eventInfo : eventInfos) {
            this.eventMap.put(eventInfo.EventUuid, eventInfo);
        }
    }

    /**
     * Callback for events that failed to publish
     * Note: this method is always called by the Automation user
     */
    public void onFailure(EventBus.FailureResult result) {
        // Get event UUIDs from the result
        List<String> eventUuids = result.getEventUuids();

        // Sample use case: create a follow-up task for failed events
        insertTask(eventUuids, false);
    }

    /**
     * Callback for events that were successfully published
     * Note: this method is always called by the Automation user
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
            EventInfo eventInfo = this.eventMap.get(eventUuid);
            relatedAccountIds.add(eventInfo.accountId);
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
            EventInfo eventInfo = this.eventMap.get(eventUuid);

            // Create a task on the related account
            Task t = new Task();
            t.WhatId = eventInfo.accountId;
            t.ActivityDate = Date.today().addDays(1);
            if (isSuccess == true) {
                t.Subject = 'Follow up on successful event publishing.';
                t.Description =
                    'Events published successfully. Event UUID: ' + eventUuid;
            } else {
                t.Subject = 'Follow up on event publishing failure.';
                t.Description =
                    'Events failed to publish. Event UUID: ' + eventUuid;
            }
            t.OwnerId = relatedAccounts.get(eventInfo.accountId).OwnerId;
            tasks.add(t);
        }
        insert as system tasks;
    }

    /**
     * Data object that holds the minimum amount of information to identify our event and potentially republish it.
     * We recommend that you don't store all event fields to avoid hitting callback handler internal limits.
     */
    public class EventInfo {
        public String eventUuid;
        public Id accountId;

        public EventInfo(String eventUuid, Id accountId) {
            this.eventUuid = eventUuid;
            this.accountId = accountId;
        }
    }
}
