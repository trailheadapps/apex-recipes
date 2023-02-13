@isTest
private class PlatformEventRecipesTriggerHandler_Tests {
    @isTest
    static void testPlatformEventRecipesTriggerHandlerPositive() {
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
        Database.SaveResult publishResult = EventBus.publish(event);
        Test.stopTest();

        System.Assert.isTrue(publishResult.isSuccess());
        Account checkAccount = [
            SELECT Website
            FROM Account
            WHERE Id = :acct.Id
            LIMIT 1
        ];
        System.Assert.areEqual('https://google.com', checkAccount.Website);
    }
}
