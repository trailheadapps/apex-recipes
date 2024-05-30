@isTest
private inherited sharing class PlatformEventRecipes_Tests {
    @isTest
    static void testEventPublishPositive() {
        Account acct = (Account) TestFactory.createSObject(
            new Account(Name = 'testEvent'),
            true
        );
        Event_Recipes_Demo__e event = new Event_Recipes_Demo__e(
            Url__c = 'https://google.com',
            Title__c = 'demo.jpg',
            AccountId__c = acct.Id
        );

        Test.startTest();
        Database.SaveResult publishResult = PlatformEventRecipes.publishEvent(
            event
        );
        Test.stopTest();

        System.Assert.isTrue(
            publishResult.isSuccess(),
            'Expected the publish event to succeed'
        );
    }

    @isTest
    static void testEventPublishNegativeInvalidFields() {
        Event_Recipes_Demo__e event = new Event_Recipes_Demo__e(
            Url__c = 'https://google.com',
            Title__c = 'demo.jpg'
        );

        Test.startTest();
        Database.SaveResult publishResult = PlatformEventRecipes.publishEvent(
            event
        );
        Test.stopTest();

        System.Assert.isFalse(
            publishResult.isSuccess(),
            'Expected the publish event to fail'
        );
    }

    @isTest
    static void testEventPublishNegativeMinAccessUser() {
        Event_Recipes_Demo__e event = new Event_Recipes_Demo__e(
            Url__c = 'https://google.com',
            Title__c = 'demo.jpg'
        );
        Boolean didCatchCorrectException = false;
        User testUser = TestFactory.createMinAccessUser(true);

        Test.startTest();
        System.runAs(testUser) {
            try {
                PlatformEventRecipes.publishEvent(event);
            } catch (PlatformEventRecipes.PlatformEventRecipesException pere) {
                if (
                    pere.getMessage()
                        .containsIgnoreCase(
                            'User has no permission to publish event'
                        )
                ) {
                    didCatchCorrectException = true;
                }
            }
        }
        Test.stopTest();

        System.Assert.isTrue(
            didCatchCorrectException,
            'Expected to have received a PlatformEventRecipesException when a min-access user tries to publish an event'
        );
    }

    @isTest
    static void testEventPublishCallbackFailsWhenNoEventUuid() {
        // Create event without an EventUuid
        Event_Recipes_Demo__e event = new Event_Recipes_Demo__e(
            Url__c = 'https://google.com',
            Title__c = 'demo.jpg',
            AccountId__c = null
        );

        Boolean didCatchCorrectException = false;
        Test.startTest();
        try {
            PlatformEventRecipes.publishEventWithCallbacks(event);
        } catch (PlatformEventRecipes.PlatformEventRecipesException pere) {
            if (pere.getMessage().containsIgnoreCase('EventUuid is required')) {
                didCatchCorrectException = true;
            }
        }
        Test.stopTest();

        System.Assert.isTrue(
            didCatchCorrectException,
            'Expected to have received a PlatformEventRecipesException stating EventUuid is required'
        );
    }

    @isTest
    static void testEventPublishCallbackSuccess() {
        Account acct = (Account) TestFactory.createSObject(
            new Account(Name = 'testEvent'),
            true
        );

        // Create the event via sObjectType.newSObject in order to obtain an EventUuid
        Event_Recipes_Demo__e event = (Event_Recipes_Demo__e) Event_Recipes_Demo__e.sObjectType.newSObject(
            null,
            true
        );
        event.AccountId__c = acct.Id;
        event.Title__c = 'Updated website';
        event.Url__c = 'https://developer.salesforce.com';

        Test.startTest();
        PlatformEventRecipes.publishEventWithCallbacks(event);
        Test.stopTest();

        // Check that the publish callback created the follow up task
        List<Task> tasks = [
            SELECT Subject
            FROM Task
            WHERE
                WhatId = :acct.Id
                AND Subject LIKE '%successful event publishing%'
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        System.Assert.areEqual(
            1,
            tasks.size(),
            'Expected success follow up task'
        );
    }

    @isTest
    static void testEventPublishCallbackFailure() {
        Account acct = (Account) TestFactory.createSObject(
            new Account(Name = 'testEvent'),
            true
        );

        // Create the event via sObjectType.newSObject in order to obtain an EventUuid
        Event_Recipes_Demo__e event = (Event_Recipes_Demo__e) Event_Recipes_Demo__e.sObjectType.newSObject(
            null,
            true
        );
        event.AccountId__c = acct.Id;
        event.Title__c = 'Updated website';
        event.Url__c = 'https://developer.salesforce.com';

        Test.startTest();
        PlatformEventRecipes.publishEventWithCallbacks(event);
        // Force the previous event publish call to fail
        Test.getEventBus().fail();
        Test.stopTest();

        // Check that the publish callback created the follow up task
        List<Task> tasks = [
            SELECT Subject
            FROM Task
            WHERE
                WhatId = :acct.Id
                AND Subject LIKE '%event publishing failure%'
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        System.Assert.areEqual(
            1,
            tasks.size(),
            'Expected failure follow up task'
        );
    }
}
