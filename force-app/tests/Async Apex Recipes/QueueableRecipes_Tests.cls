@isTest
private inherited sharing class QueueableRecipes_Tests {
    @TestSetup
    static void makeData() {
        List<Account> accounts = (List<Account>) TestFactory.createSObjectList(
            new Account(),
            200,
            true
        );
    }

    @isTest
    static void testQueueableWithCalloutRecipesPositive() {
        Test.startTest();
        QueueableRecipes queueable = new QueueableRecipes();
        System.enqueueJob(queueable);
        Test.stopTest();

        List<Account> checkAccounts = [SELECT description FROM Account];
        System.assert(
            checkAccounts.size() == 200,
            'Expected to find 200 accounts'
        );
        for (Account account : checkAccounts) {
            System.assert(
                account.Description.containsIgnoreCase(
                    'edited by queueable class'
                ),
                'Expected to find all accounts\'s to have been edited to include edited by queueable class'
            );
        }
    }
}
