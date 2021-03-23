@isTest
private class StubExample_Tests {
    @isTest
    static void testGetIsTruePositive() {
        StubExample example = new StubExample();
        Test.startTest();
        Boolean results = example.getIsTrue();
        Test.stopTest();

        System.assert(
            results == false,
            'Expected to get false back from unmodified newly constructed instance'
        );
    }
}
