@isTest
private class QuiddityRecipes_Tests {
    @isTest
    static void testBasicFetchOfQuiddityPositive() {
        Test.startTest();
        Quiddity result = QuiddityRecipes.demonstrateGetQuiddity();
        Test.stopTest();
        System.Assert.isTrue(
            QuiddityGuard.trustedQuiddities.contains(result),
            'Expected the quiddity of a test run to be in the QuiddityGuard.trustedQuiddities list'
        );
    }
}
