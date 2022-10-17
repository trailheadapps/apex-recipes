@isTest
private inherited sharing class QueueableWithCalloutRecipes_Tests {
    @TestSetup
    static void makeData() {
        TestFactory.createSObjectList(new Account(), 200, true);
    }

    @isTest
    static void testQueueableWithCalloutRecipesPositive() {
        HttpCalloutMockFactory httpMock = new HttpCalloutMockFactory(
            200,
            'OK',
            'Success',
            new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, httpMock);
        Test.startTest();
        QueueableWithCalloutRecipes queueable = new QueueableWithCalloutRecipes();
        System.enqueueJob(queueable);
        Test.stopTest();

        List<Account> checkAccounts = [SELECT Description FROM Account];
        System.Assert.areEqual(
            200,
            checkAccounts.size(),
            'Expected to find 200 accounts'
        );
        for (Account account : checkAccounts) {
            System.Assert.isTrue(
                account.Description.containsIgnoreCase('200'),
                'Expected to find all accounts\'s to have been edited to include edited by queueable class'
            );
        }
    }

    @isTest
    static void testQueuableWithCalloutNegativeDMLError() {
        HttpCalloutMockFactory httpMock = new HttpCalloutMockFactory(
            200,
            'OK',
            'Success',
            new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, httpMock);
        QueueableWithCalloutRecipes.throwError = true;
        Id enqueuedJobId;
        QueueableWithCalloutRecipes queueable = new QueueableWithCalloutRecipes();

        Test.startTest();
        enqueuedJobId = System.enqueueJob(queueable);
        Test.stopTest();

        System.Assert.isTrue(
            QueueableWithCalloutRecipes.circuitBreakerThrown,
            'Expected the test code to have tripped the circuit breaker'
        );
    }
}
