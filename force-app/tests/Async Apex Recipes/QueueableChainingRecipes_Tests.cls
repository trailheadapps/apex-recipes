@isTest
private inherited sharing class QueueableChainingRecipes_Tests {
    @TestSetup
    static void makeData() {
        TestFactory.createSObjectList(new Account(), 20, true);
    }

    @isTest
    static void chainedQueueableTestPositive() {
        Test.startTest();
        // You cannot chain queueables together in a Test context. Your options are either to
        // use Test.isRunningTest() and modify your logic, or do what we do here: manually
        // call the execute method of the Queueable one step prior to the one your testing.
        // Note, you cannot construct a QueueableContext object, but you can pass in null
        //
        // This test is designed to illustrate the cumulative nature of Queueable Work,
        // and how to syntactically chain queueables together
        QueueableChainingRecipes.execute(null);
        Test.stopTest();
        List<Account> checkAccounts = [SELECT Description FROM Account];
        System.assert(
            checkAccounts.size() == 20,
            'Expected to find 20 accounts'
        );
        for (Account acct : checkAccounts) {
            System.assert(
                acct.Description.containsIgnoreCase('first chained Queuable'),
                'Expected to see evidence of first Queeuable job in account description'
            );
            System.assert(
                acct.Description.containsIgnoreCase(
                    'Edited by Queueable class'
                ),
                'Expected to see evidence of second Queeuable job in account description'
            );
        }
    }
}
