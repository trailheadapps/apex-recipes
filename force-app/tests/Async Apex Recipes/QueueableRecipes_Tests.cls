@isTest
private inherited sharing class QueueableRecipes_Tests {
    @TestSetup
    static void makeData() {
        TestFactory.createSObjectList(new Account(), 200, true);
    }

    @isTest
    static void testQueueableWithCalloutRecipesPositive() {
        Test.startTest();
        QueueableRecipes queueable = new QueueableRecipes();
        System.enqueueJob(queueable);
        Test.stopTest();

        List<Account> checkAccounts = [SELECT description FROM Account];
        System.Assert.areEqual(
            200,
            checkAccounts.size(),
            'Expected to find 200 accounts'
        );
        for (Account account : checkAccounts) {
            System.Assert.isTrue(
                account.Description.containsIgnoreCase(
                    'edited by queueable class'
                ),
                'Expected to find all accounts\'s to have been edited to include edited by queueable class'
            );
        }
    }
}
