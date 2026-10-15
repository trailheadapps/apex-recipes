@IsTest
private class StubExample_Tests {
    @IsTest
    static void testGetIsTruePositive() {
        StubExample example = new StubExample();
        Test.startTest();
        Boolean results = example.getIsTrue();
        Test.stopTest();

        System.Assert.isFalse(
            results,
            'Expected to get false back from unmodified newly constructed instance'
        );
    }

    @IsTest
    static void testGetGreetingPositive() {
        StubExample example = new StubExample();
        Test.startTest();
        String results = example.getGreeting();
        Test.stopTest();
        System.Assert.areEqual(
            'hello',
            results,
            'Expected to get hello as the default greeting'
        );
    }

    @IsTest
    static void testSetGreetingStringPositive() {
        StubExample example = new StubExample();
        Test.startTest();
        example.setGreeting('testing 123');
        String results = example.getGreeting();
        Test.stopTest();
        System.Assert.areEqual(
            'testing 123',
            results,
            'Expected to get testing 123 after calling setGreeting with String'
        );
    }

    @IsTest
    static void testSetGreetingIntegerPositive() {
        StubExample example = new StubExample();
        Test.startTest();
        example.setGreeting(1);
        String results = example.getGreeting();
        Test.stopTest();
        System.Assert.areEqual(
            '1',
            results,
            'Expected to get 1 after calling setGreeting with Integer'
        );
    }
}
