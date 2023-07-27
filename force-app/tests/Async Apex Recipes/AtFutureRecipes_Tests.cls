@isTest
private inherited sharing class AtFutureRecipes_Tests {
    @isTest
    static void callBasicAtFutureMethodTestPositive() {
        /**
         * Calling Test.startTest() and Test.stopTest() are critical for asynchronous apex tests
         * when you call asynchronous code within Test.startTest() and Test.stopTest() the test
         * runner forces the asynchronous code to run synchronously.
         */
        Test.startTest();
        AtFutureRecipes.atFutureMethodWithoutCalloutPrivileges('Hello World');
        Test.stopTest();
        system.Assert.isTrue(
            AtFutureRecipes.testCircuitBreaker,
            'Expected the code to have set the testCircuitBreaker to true.'
        );
    }

    /**
     * @description A test that executes a positive test on the AtFuture Callout method.
     * Uses a HttpCalloutMock instance
     */
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    @isTest
    static void callAtFutureCalloutPositive() {
        HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
            200,
            'OK',
            'Hello World',
            new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, mock);

        /**
         * Calling Test.startTest() and Test.stopTest() are critical for asynchronous apex tests
         * when you call asynchronous code within Test.startTest() and Test.stopTest() the test
         * runner forces the asynchronous code to run synchronously.
         */
        Test.startTest();
        AtFutureRecipes.atFutureMethodWithCalloutPrivileges(
            'https://developer.salesforce.com'
        );
        Test.stopTest();

        /**
         * This is where you should have a system.assert* call. However,This test features a 'silent assertion'.
         * It's not a pattern I'm a fan of, but this test does have a purpose without a dedicated system.assert()
         * call. Namely, that our Mock was utilized. If the mock isn't utilized the test will fail when attempting
         * to make a callout. Logically, we can deduce from this, and from the circuit breaker the method throws
         * on a non 200 response that the method suceeded as intended.
         *
         * Normally, I'd re-write the actual method to return a value, but since this is an @Future method
         * we can't do that. So this is officially the one use case I can think of for using a 'silent assertion'
         *
         * Note the test below, as I do think we should test throwing the exception.
         */
    }

    /**
     * @description Exercises the `@future` method with a circuit breaker set
     * to ensure a failure state. Tests that we get the proper failure state,
     * and get full coverage.
     */
    @isTest
    static void callAtFutureMethodWithCalloutNegative() {
        HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
            400,
            'OK',
            'Hello World',
            new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, mock);

        /**
         * @description Calling Test.startTest() and Test.stopTest() are critical for asynchronous apex tests
         * when you call asynchronous code within Test.startTest() and Test.stopTest() the test
         * runner forces the asynchronous code to run synchronously.
         */
        Test.startTest();
        AtFutureRecipes.atFutureMethodWithCalloutPrivileges(
            'https://developer.salesforce.com'
        );
        Test.stopTest();
        system.Assert.isTrue(
            AtFutureRecipes.testCircuitBreaker,
            'Expected to have triggered the testCircuitBreaker'
        );
    }
}
