@isTest
public class BasicDataWeaveInApexRecipes_Tests {
    @isTest
    static void testStaticInvocation() {
        Test.startTest();
        String result = BasicDataWeaveInApexRecipes.staticInvocation();
        Test.stopTest();
        Assert.areEqual('"Hello World"', result);
    }

    @isTest
    static void testDynamicInvocation() {
        Test.startTest();
        String result = BasicDataWeaveInApexRecipes.dynamicInvocation(
            'helloWorld'
        );
        Test.stopTest();
        Assert.areEqual('"Hello World"', result);
    }

    @isTest
    static void testDynamicInvocationError() {
        Test.startTest();
        try {
            String result = BasicDataWeaveInApexRecipes.dynamicInvocation(
                'error'
            );
            Assert.fail('Exception expected');
        } catch (Exception ex) {
            Assert.isInstanceOfType(
                ex,
                DataWeaveScriptException.class,
                'Exception of type DataWeaveScriptException expected'
            );
            Assert.isTrue(ex.getMessage().startsWith('Division by zero'));
        }
        Test.stopTest();
    }
}
