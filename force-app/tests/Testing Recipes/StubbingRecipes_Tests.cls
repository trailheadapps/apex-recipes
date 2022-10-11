@isTest
private class StubbingRecipes_Tests {
    @isTest
    static void stubShouldReturnTruePositive() {
        TestDouble stub = new TestDouble(StubExample.class);
        TestDouble.Method methodToTrack = new TestDouble.Method('getIsTrue')
            .returning(true);

        stub.track(methodToTrack);

        StubExampleConsumer consumer = new StubExampleConsumer(
            (StubExample) stub.generate()
        );

        System.Assert.isTrue(
            consumer.getIsTrue(),
            'Calling getIsTrue on our consumer object with a stub should return true'
        );
    }

    @isTest
    static void stubShouldReturnNonDefaultGreetingPositive() {
        TestDouble.Method methodToTrack = new TestDouble.Method(
                'getIsTestGreeting'
            )
            .returning(true);
        TestDouble.Method secondMethodToTrack = new TestDouble.Method(
                'getGreeting'
            )
            .returning('Hola');

        // this first 'methodToTrack' is superfluous to the test but
        // a good demonstration of the fluid api interface and how
        // you can chain multiple track commands together.
        TestDouble stub = new TestDouble(StubExample.class)
            .track(methodToTrack)
            .track(secondMethodtoTrack);

        StubExampleConsumer consumer = new StubExampleConsumer(
            (StubExample) stub.generate()
        );

        System.Assert.areEqual(
            'Hola',
            consumer.getGreeting(),
            'Calling getGreeting on our consumer with a stubbed object should return the stubs value'
        );

        System.Assert.areEqual(
            1,
            secondMethodToTrack.hasBeenCalledXTimes,
            'Expected the getGreeting method to have been called exactly once.'
        );
    }

    @isTest
    static void testStubbedMethodWithParametersPositive() {
        TestDouble.Method toTrack = new TestDouble.Method('setGreeting')
            .withParamTypes(new List<Type>{ String.class })
            .withParamNames(new List<String>{ 'greeting' })
            .withArgs(new List<Object>{ 'greeting' });

        TestDouble.Method secondTrackedMethod = new TestDouble.Method(
                'getGreeting'
            )
            .returning('greetings');

        TestDouble stub = new TestDouble(StubExample.class)
            .track(toTrack)
            .track(secondTrackedMethod);

        StubExampleConsumer consumer = new StubExampleConsumer(
            (StubExample) stub.generate()
        );

        Test.startTest();
        consumer.setGreeting('greeting');
        Test.stopTest();

        System.Assert.areEqual(
            1,
            toTrack.hasBeenCalledXTimes,
            'expected setGreeting to have been called once'
        );

        System.Assert.areEqual(
            'greetings',
            consumer.getGreeting(),
            'Calling getGreeting on our consumer with a stubbed object should return the stubs value'
        );
    }

    @isTest
    static void testStubbedOverloadedMethodsPositive() {
        TestDouble.Method toTrack = new TestDouble.Method('setGreeting')
            .withParamTypes(new List<Type>{ String.class })
            .withParamNames(new List<String>{ 'greeting' })
            .withArgs(new List<Object>{ 'greeting' });

        TestDouble.Method secondTrackedMethod = new TestDouble.Method(
                'setGreeting'
            )
            .withParamTypes(new List<Type>{ Integer.class })
            .withParamNames(new List<String>{ 'greeting' })
            .withArgs(new List<Object>{ 3 });

        TestDouble stub = new TestDouble(StubExample.class)
            .track(toTrack)
            .track(secondTrackedMethod);

        StubExampleConsumer consumer = new StubExampleConsumer(
            (StubExample) stub.generate()
        );

        Test.startTest();
        consumer.setGreeting('greeting');
        consumer.setGreeting(3);
        Test.stopTest();

        System.Assert.areEqual(
            1,
            toTrack.hasBeenCalledXTimes,
            'expected setGreeting(string) to have been called once'
        );

        System.Assert.areEqual(
            1,
            secondTrackedMethod.hasBeenCalledXTimes,
            'expected setGreeting(int) to have been called once'
        );
    }

    @isTest
    static void testThrowingPositive() {
        TestDouble.Method methodToTrack = new TestDouble.Method('getGreeting')
            .throwing('Expected Error');

        TestDouble stub = new TestDouble(StubExample.class)
            .track(methodToTrack);

        StubExampleConsumer consumer = new StubExampleConsumer(
            (StubExample) stub.generate()
        );

        Boolean didCatchTheRightException = false;

        try {
            consumer.getGreeting();
        } catch (TestDouble.TestDoubleException testDoubleException) {
            if (
                testDoubleException.getMessage()
                    .equalsIgnoreCase('Expected Error')
            ) {
                didCatchTheRightException = true;
            }
        }

        System.Assert.isTrue(
            didCatchTheRightException,
            'expected to have caught a TestDoubleException'
        );
    }
}
