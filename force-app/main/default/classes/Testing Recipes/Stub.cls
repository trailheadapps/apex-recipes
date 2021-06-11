@isTest
/**
 * @description This class helps you construct and manage StubProvider 
 * conforming objects for use in Unit Tests. It, along with it's companion
 * classes: 
 *   * MockedMethod 
 *   * MethodSignature
 * and their builder-pattern inner classes are designed to work together
 * with a fluent API style like this:
 * 
 * ```apex
 * StubObject fooStub = new StubObject.Builder('foo.class')
    .mockingMethodCall('someMethodName', List<Object> Params)
    .withParameterTypes()
    .returning() || .throwingException() || .throwingException(ExceptionObj)
    .mockingMethodCall('secondMethodName', ...)
    .withParameterTypes()
    .returning() || .throwingException() || .throwingException(ExceptionObj)
    .createStub()

 * ```
 */
public with sharing class Stub implements System.StubProvider {
    /**
     * @description Class is used by Stub, MethodSignature and MockedMethod
     * classes for throwing when an exception occurs that is specifically
     * related to building, using or asserting against the Super Stub framework
     */
    public class StubException extends Exception {
    }

    // marked final, because we don't ever want to be in a situation where we're
    // changing the Stub object type.
    private final Type objectType;
    // marked private, because only this class should be able to directly
    // interact with this list of MockedMethod
    @testVisible
    private List<MockedMethod> mockedMethods = new List<MockedMethod>();

    /**
     * @description      required constructor finalizing the object type.
     * @param objectType Type class: ie: Foo.class
     */
    public Stub(Type objectType) {
        this.objectType = objectType;
    }

    /**
     * @description         convenience construtor that accepts a pre-built
     * list of MockedMethod objects.
     * @param objectType    type class: ie. Foo.class
     * @param mockedMethods List of MockedMethod objects
     */
    public Stub(Type objectType, List<MockedMethod> mockedMethods) {
        this(objectType);
        this.mockedMethods = mockedMethods;
    }

    /**
     * @description      method required by the StubProvider interface. Handles
     * the mock execution of the given method call.
     * @param obj        dependency injected by Apex, object the mock method
     *                      was call upon
     * @param methodName dependency injected by Apex, string representation
     *                      of the name of the method used to construct a
     *                      MethodSignature object for comparison.
     * @param returnType dependency injected by Apex, not currently used.
     * @param paramTypes dependency injected by Apex, list of parameter types
     *                      used to construct a MethodSignature object for
     *                      comparison.
     * @param paramNames dependency injected by Apex, not currently used.
     * @param args       dependency injected by Apex, not currently used.
     * @return           `Object`
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public Object handleMethodCall(
        Object obj,
        String methodName,
        Type returnType,
        List<Type> paramTypes,
        List<String> paramNames,
        List<Object> args
    ) {
        // Creates a method signature object from dependency injected variables
        // used for comparing the current method call being handled against the
        // list of MockedMethod objects
        MethodSignature methodSignature = new MethodSignature(
            methodName,
            paramTypes
        );

        // Iterates over the known list of MockedMethod objects. When it finds
        // a match to the currently handled method call, it delegates the return
        // value to the MockedMethod.handleCall() method.
        for (MockedMethod mockedMethod : mockedMethods) {
            if (
                mockedMethod.doMethodSignaturesAndParametersMatch(
                    methodSignature,
                    args
                )
            ) {
                return mockedMethod.handleCall();
            }
        }

        // If no matching MockedMethod is found, this exception is thrown.
        throw new Stub.StubException(
            methodName +
            ' was called on a Stubbed version of ' +
            this.objectType.toString() +
            ' but no mocked method matched it\'s signature and parameter' +
            ' values.' +
            ' Known mocks include:  ' +
            this.mockedMethods +
            ' However the parameter types of this call are: ' +
            paramTypes +
            ' and the parameter values of this call are: ' +
            args
        );
    }

    /**
     * @description Useful for asserting the methods you mocked were, in fact,
     * called. It does this by invoking the assertMockedMethodWasCalled on each
     * individual mocked method.
     */
    public void assertAllMockedMethodsWereCalled() {
        for (MockedMethod mockedMethod : mockedMethods) {
            mockedMethod.assertMockedMethodWasCalled();
        }
    }

    /**
     * @description returns the this constructed class with it's mocked methods
     * as a single stub object to be used in a unit test.
     * @return      `Object` Needs to be cast back to the type of object used.
     */
    public Object createStub() {
        return Test.createStub(objectType, this);
    }

    /**
     * @description Builder pattern for creating stubs with a fluent interface.
     * Note, there are three 'Builder' classes, each an inner class of the
     * object that the builder builds. In this case, this builder inner class
     * is responsible for building Stub objects.
     *
     * While you can directly instantiate the Stub class, the idea is that you
     * will actually use the Builder class/interface to create Stubs
     */
    public class Builder {
        /**
         * @description holds the System.Type reference for the object that
         * you're building a stub for.
         */
        private Type objectType;

        /**
         * @description Internally, we need to maintain a list of signature
         * builder objects so that we can roll-up the creation of objects.
         */
        List<MethodSignature.Builder> signatureBuilders = new List<MethodSignature.Builder>();

        /**
         * @description   Constructor requiring the objectType. We do that to
         * enforce that all Stub builders have an object type.
         * @param objType
         */
        public Builder(Type objType) {
            this.objectType = objType;
        }

        /**
         * @description      This method, and it's overloaded variants below,
         * all work to add a new MockedMethod to the stub object. Semantically
         * the idea is that you'll invoke one of these 'mockingMethodCall'
         * methods for every method you want your stub to react to. Because this
         * builder class is designed around method chaining, you can invoke a
         * number of these in a row. See the example invocation at the top of
         * this class.
         * @param methodName Required, name of the method that will be mocked
         * @param paramTypes List of System.Types that the mocked method should
         * respond to.
         * @return           `MethodSignature.Builder` - returns the builder
         * object for chaining.
         */
        public MethodSignature.Builder mockingMethodCall(
            String methodName,
            List<Type> paramTypes
        ) {
            MethodSignature.Builder sb = new MethodSignature.Builder(
                this,
                methodName,
                paramTypes
            );
            signatureBuilders.add(sb);
            return sb;
        }

        /**
         * @description      Overloaded variant of the main 'mockingMethodCall'
         * method. See docs for the first instance of mockingMethodCall in this
         * class.
         * @param methodName Method name to be mocked.
         * @return           `MethodSignature.Builder`
         */
        public MethodSignature.Builder mockingMethodCall(String methodName) {
            return mockingMethodCall(methodName, new List<Type>());
        }

        /**
         * @description      Overloaded variant of the main 'mockingMethodCall'
         * method. See docs for the first instance of mockingMethodCall in this
         * class.
         * @param methodName required. method name to be mocked.
         * @param paramType  Type of single parameter.
         * @return           `MethodSignature.Builder`
         */
        public MockedMethod.Builder mockingMethodCall(
            String methodName,
            Type paramType
        ) {
            return mockingMethodCall(methodName, new List<Type>{ paramType })
                .withParameterTypes();
        }

        /**
         * @description      Overloaded variant of the main 'mockingMethodCall'
         * method. See docs for the first instance of mockingMethodCall in this
         * class.
         * @param methodName required. method name to be mocked.
         * @param paramType  param type 1.
         * @param paramType2 param type 2.
         * @return           `MethodSignature.Builder`
         */
        public MockedMethod.Builder mockingMethodCall(
            String methodName,
            Type paramType,
            Type paramType2
        ) {
            return mockingMethodCall(
                    methodName,
                    new List<Type>{ paramType, paramType2 }
                )
                .withParameterTypes();
        }

        /**
         * @description      Overloaded variant of the main 'mockingMethodCall'
         * method. See docs for the first instance of mockingMethodCall in this
         * class.
         * @param methodName required. method name to be mocked.
         * @param paramType  param type 1.
         * @param paramType2 param type 2.
         * @param paramType3 param type 3.
         * @return           `MethodSignature.Builder`
         */
        @SuppressWarnings('PMD.ExcessiveParameterList')
        public MockedMethod.Builder mockingMethodCall(
            String methodName,
            Type paramType,
            Type paramType2,
            Type paramType3
        ) {
            return mockingMethodCall(
                    methodName,
                    new List<Type>{ paramType, paramType2, paramType3 }
                )
                .withParameterTypes();
        }

        /**
         * @description      Overloaded variant of the main 'mockingMethodCall'
         * method. See docs for the first instance of mockingMethodCall in this
         * class.
         * @param methodName required. method name to be mocked.
         * @param paramType  param type 1.
         * @param paramType2 param type 2.
         * @param paramType3 param type 3.
         * @param paramType4 param type 4.
         * @return           `MethodSignature.Builder`
         */
        @SuppressWarnings('PMD.ExcessiveParameterList')
        public MockedMethod.Builder mockingMethodCall(
            String methodName,
            Type paramType,
            Type paramType2,
            Type paramType3,
            Type paramType4
        ) {
            return mockingMethodCall(
                    methodName,
                    new List<Type>{
                        paramType,
                        paramType2,
                        paramType3,
                        paramType4
                    }
                )
                .withParameterTypes();
        }

        /**
         * @description    Generates a Stub object from this builder object.
         * @param If true, calls the stub objects' createStub method
         * automatically
         * @return                       `Stub`
         */
        public Object defineStub(Boolean generateInjectableStub) {
            return this.defineStub().createStub();
        }

        public Stub defineStub() {
            List<MockedMethod> mockedMethods = new List<MockedMethod>();
            for (MethodSignature.Builder sb : signatureBuilders) {
                mockedMethods.addAll(sb.buildMockedMethod());
            }
            return new Stub(objectType, mockedMethods);
        }
    }
}
