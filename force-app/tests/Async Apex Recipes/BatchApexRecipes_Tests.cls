@isTest
private inherited sharing class BatchApexRecipes_Tests {
    @TestSetup
    static void makeData() {
        TestFactory.createSObjectList(new Account(), 200, true);
    }

    @isTest
    static void batchApexRecipesTestPositive200Scope() {
        /**
         * Batch classes are another form of Asynchronous Apex. Therefore it's critical to
         * use Test.startTest() and Test.stopTest(). Not only does this force the batch
         * job to complete before assertions are made, it also helps ensure you don't try
         * to execute more than one batch which will result in an test exception.
         */
        Test.startTest();
        Database.executeBatch(new BatchApexRecipes());
        Test.stopTest();

        List<Account> checkAccounts = [SELECT Name FROM Account];
        System.Assert.areEqual(
            200,
            checkAccounts.size(),
            'Expected to find 200 accounts'
        );
        for (Account acct : checkAccounts) {
            System.Assert.isTrue(
                acct.Name.containsIgnoreCase(' Edited by Batch class'),
                'Accounts should have \'edited by batch class\' after batch job execution'
            );
        }
        System.Assert.isTrue(
            BatchApexRecipes.result.equalsIgnoreCase(
                'Successes: 200 Failures: 0'
            ),
            'Expected all successes'
        );
    }

    /**
     * @description negative test exercising a failure state demonstrating
     * that our batchClass does in fact keep cross-batch state on the
     * number of failures
     */
    @isTest
    static void batchApexRecipesTestNegative() {
        Test.startTest();
        BatchApexRecipes batchJob = new BatchApexRecipes();
        batchJob.throwError = true;
        Database.executeBatch(batchJob);
        Test.stopTest();
        System.Assert.isTrue(
            BatchApexRecipes.result.equalsIgnoreCase(
                'Successes: 0 Failures: 200'
            ),
            'Expected all failures'
        );
    }
}
