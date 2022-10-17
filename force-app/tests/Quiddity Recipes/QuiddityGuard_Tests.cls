@isTest
private class QuiddityGuard_Tests {
    @isTest
    static void testQuiddityGuardFindsTestQuiddityPositive() {
        Test.startTest();
        System.Assert.isTrue(
            QuiddityGuard.isAcceptableQuiddity(QuiddityGuard.trustedQuiddities),
            'Expected a testQuiddity to be in the Trusted Quiddities list'
        );
        Test.stopTest();
    }

    @isTest
    static void testQuiddityOverrideReturnsFalsePositive() {
        QuiddityGuard.testQuiddityOverride = Quiddity.FUTURE;
        Test.startTest();
        System.Assert.isFalse(
            QuiddityGuard.isAcceptableQuiddity(QuiddityGuard.trustedQuiddities),
            'Expected Future quiddity to not be in trusted quiddities list'
        );
        Test.stopTest();
    }
}
