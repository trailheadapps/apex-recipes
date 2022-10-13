@isTest
private inherited sharing class PlatformEventRecipes_Tests {
    @isTest
    static void testEventPublishPositive() {
        Account acct = (Account) TestFactory.createSObject(
            new Account(name = 'testEvent'),
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
}
