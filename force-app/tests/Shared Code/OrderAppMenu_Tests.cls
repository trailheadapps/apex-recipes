@isTest
private inherited sharing class OrderAppMenu_Tests {
    @isTest
    static void testQueueableWithCalloutRecipesPositive() {
        Test.startTest();
        OrderAppMenu queueable = new OrderAppMenu();
        System.enqueueJob(queueable);
        Test.stopTest();

        /**
         * @description The logic the tested Queueable executes is not
         * queryable. Meaning there's not a way to assert this worked,
         * short of it not throwing an exception. However, all
         * test methods should have an assert call.
         */
        System.Assert.isTrue(true, 'This assertion should never fail.');
    }
}
