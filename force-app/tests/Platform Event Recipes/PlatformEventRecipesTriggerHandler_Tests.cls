@isTest
private inherited sharing class PlatformEventRecipesTriggerHandler_Tests {
    @isTest
    static void testPlatformEventRecipesTriggerHandlerPositive() {
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
        EventBus.publish(event);
        Test.stopTest();

        Account checkAccount = [
            SELECT Website
            FROM Account
            WHERE Id = :acct.Id
            LIMIT 1
        ];
        System.assertEquals(
            'https://google.com',
            checkAccount.Website,
            'Expected the website to be set to google.com'
        );
    }
}
