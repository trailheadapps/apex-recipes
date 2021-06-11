@isTest
/**
 * @description Represents a method call that is mocked as part of a Stub
 * object. This class is marked @isTest, as the object and it's methods are
 * not useful outside of a Test context.
 *
 * This file contains not only the MockedMethod class, but an inner Builder
 * class. It is expected most developers will utilize the Builder class to
 * construct instances of MockedMethod.
 */
public with sharing class MockedMethod {
    /**
     * @description Every MockedMethod has a methodSignature defining it's
     * 'signature' or combination of name, parameter names and parameter types.
     */
    @testVisible
    private MethodSignature methodSignature;
    private List<Object> expectedParameters;
    private Object returnValue;
    private Boolean throwException = false;
    private List<Id> sObjectIds;
    private Exception customException;
    private Integer countOfMethodInvocations = 0;
    @testVisible
    private static String exceptionMessage = 'Exception thrown by SuperStub.';

    /**
     * @description          Constructor requiring a method signature. This is
     * used to prevent constructing MockedMethods without a signature.
     * @param methodSignature We need this to define the shape of the method
     * being mocked.
     */
    public MockedMethod(MethodSignature methodSignature) {
        this.MethodSignature = methodSignature;
    }

    /**
     * @description This method is invoked by it's parent stub object, and is
     * responsible for returning the mocked value.
     * @return      `Object`
     */
    public Object handleCall() {
        // counts the number of times this method is called.
        countOfMethodInvocations++;

        // if the developer has set a list of ID's, set them as the id's of the
        // returning sObjects
        if (sObjectIds != null) {
            List<SObject> sObjects = (List<SObject>) expectedParameters[0];
            for (Integer i = 0; i < sObjects.size(); i++) {
                sObjects[i].Id = sObjectIds[i];
            }
            this.returnValue = sObjects;
        }

        // Throw a pre-specified exception, if one is set.
        if (throwException) {
            if (this.customException != null) {
                throw this.customException;
            }
            // or throw a new custom exeption if it's just supposed to throw an
            // exception
            throw new Stub.StubException(exceptionMessage);
        }

        return returnValue;
    }

    /**
     * @description If this MockedMethod has not been called cause a failing
     * assertion.
     */
    @SuppressWarnings('pmd.ApexUnitTestMethodShouldHaveIsTestAnnotation')
    public void assertMockedMethodWasCalled() {
        if (countOfMethodInvocations < 1) {
            throw new Stub.StubException(
                'This bound method (' +
                this.methodSignature.getMethodName() +
                ') was not called as expected: ' +
                this.toString()
            );
        }
    }

    /**
     * @description Allows developers to define expected input parameters at
     * execution time. This enables developers to mock the same method call N
     * number of times, with different input parameters.
     * @param args  A list of Objects that you want to this MockedMethod to
     * to respond to. These objects must exactly match what your code invokes
     * in order for your stub to return the specified mock output.
     * @return      `MockedMethod`
     */
    public MockedMethod withParameterValues(List<Object> args) {
        this.expectedParameters = args;
        return this;
    }

    /**
     * @description       Sets this MockedMethod's return value. This is the
     * value that will be returned by this mocked method when the stub calls
     * a method that has an identical name, signature and input paramter list.
     * @param returnValue This is the object you want returned.
     * @return            `MockedMethod`
     */
    public MockedMethod returning(Object returnValue) {
        this.returnValue = returnValue;
        return this;
    }

    /**
     * @description       Use this variant of returning when you want the
     * mocked method to return a list of sObjects (generic) with a specific set
     * of IDs
     * @param incomingIds A list of ID's. Note, they don't have to be ids of the
     * same sObject type. Order is preserved.
     * @return            `MockedMethod`
     */
    public MockedMethod returning(List<Id> incomingIds) {
        this.sObjectIds = incomingIds;
        return this;
    }

    /**
     * @description Use this method when you need the mocked method to throw an
     * exception. Incredibly useful for testing exception handling!
     *
     * Note: This variant results in a generic StubException being thrown.
     * @return      `MockedMethod`
     */
    public MockedMethod throwingException() {
        this.throwException = true;
        return this;
    }

    /**
     * @description           Use this variant to have this mocked method return
     * a developer-specified exception object. Useful for testing exception
     * handling with specific exception types.
     * @param customException
     * @return                `MockedMethod`
     */
    public MockedMethod throwingException(Exception customException) {
        this.throwException = true;
        this.customException = customException;
        return this;
    }

    /**
     * @description           determines if the current method call matches
     * on both a method signature level and against specified input parameters.
     * @param methodSignature A method signature to match against.
     * @param runtimeParameters a List of objects representing the actual
     * values - at runtime - of the method call.
     * @return                `Boolean`
     */
    public Boolean doMethodSignaturesAndParametersMatch(
        MethodSignature methodSignature,
        List<Object> runtimeParameters
    ) {
        return this.methodSignature.verifySignatureMatch(methodSignature) &&
            doRuntimeParametersMatch(runtimeParameters);
    }

    /**
     * @description     Determines if the method, as brokered by the stub object
     * is being called with an expected set of parameters.
     *
     * Note: I thought I could replace this with
     * `return this.methodParamsAtExecutionTime.equals(compareTo);`
     * but this doesn't work, and to be honest, I'm still investigating why.
     * @param compareTo
     * @return          `Boolean`
     */
    private Boolean doRuntimeParametersMatch(List<Object> compareTo) {
        Boolean matchesSoFar =
            this.expectedParameters.size() == compareTo.size();
        for (Integer i = 0; i < compareTo.size(); i++) {
            if (!matchesSoFar) {
                break;
            }
            matchesSoFar &=
                String.valueOf(this.expectedParameters[i]) ==
                String.valueOf(compareTo[i]);
        }
        return matchesSoFar;
    }

    /**
     * @Description class provides a 'builder' or fluent interface for
     * constructing MockedMethod objects. While the end-developer can create
     * MockedMethod objects directly, the point of this class is to provide an
     * intuitive and easy-to-use/comprehend interface for building nuanced
     * MockedMethod Objects.
     */
    public class Builder {
        private MethodSignature.Builder methodSignatureBuilder;
        private List<Object> runtimeParameters;
        private List<Id> returnSObjectIds;
        private Exception customException;
        private Boolean throwException = false;
        private Object returnValue;

        /**
         * @description    Constructor requiring a methodSignatureBuilder object
         * and a list of runtime arguments
         * @param methodSignatureBuilder
         * @param args
         */
        public Builder(
            MethodSignature.Builder methodSignatureBuilder,
            List<System.Type> args
        ) {
            this.runtimeParameters = args;
            this.methodSignatureBuilder = methodSignatureBuilder;
        }

        /**
         * @description internal method used to set the parameter values of this
         * MockedMethod instance.
         * @param parameters list of System.Type
         * @return      `MockedMethod`
         */
        private MockedMethod.Builder setParameterValues(
            List<Object> parameters
        ) {
            this.runtimeParameters = parameters;
            return this;
        }

        /**
         * @description convenience methodfor setting a single parameter type
         * @param  parameter System.Type
         * @return      this
         */
        public MockedMethod.Builder withParameterValues(Object parameter) {
            return this.setParameterValues(new List<Object>{ parameter });
        }

        /**
         * @description convenience methodfor setting two params
         * @param  parameter  System.Type
         * @param  parameter2 System.Type
         * @return            this
         */
        public MockedMethod.Builder withParameterValues(
            Object parameter,
            Object parameter2
        ) {
            return this.setParameterValues(
                new List<Object>{ parameter, parameter2 }
            );
        }

        /**
         * @description convenience methodfor setting three params
         * @param  parameter  System.Type
         * @param  parameter2 System.Type
         * @param  parameter3 System.Type
         * @return            return description
         */
        public MockedMethod.Builder withParameterValues(
            Object parameter,
            Object parameter2,
            Object parameter3
        ) {
            return this.setParameterValues(
                new List<Object>{ parameter, parameter2, parameter3 }
            );
        }

        /**
         * @description convenience methodfor setting four parameters
         * @param  parameter  parameter description
         * @param  parameter2 parameter2 description
         * @param  parameter3 parameter3 description
         * @param  parameter4 parameter4 description
         * @return            this
         */
        @SuppressWarnings('PMD.ExcessiveParameterList')
        public MockedMethod.Builder withParameterValues(
            Object parameter,
            Object parameter2,
            Object parameter3,
            Object parameter4
        ) {
            return this.setParameterValues(
                new List<Object>{
                    parameter,
                    parameter2,
                    parameter3,
                    parameter4
                }
            );
        }

        /**
         * @description This variant allows developers to specify a list of
         * IDs to be assigned to the returning sObject List
         * @param ids   The list of Ids to assign.
         * @return      `MockedMethod.Builder`
         */
        public Stub.Builder returningObjectsWithIds(List<Id> ids) {
            this.returnSObjectIds = ids;
            return methodSignatureBuilder.finalizeSignature();
        }

        /**
         * @description       This variant allows developers to specify the
         * object that will be returned when this mocked method is executed by
         * its parent stub.
         * @param returnValue
         * @return            `Stub.Builder`
         */
        public Stub.Builder returning(Object returnValue) {
            this.returnValue = returnValue;
            return methodSignatureBuilder.finalizeSignature();
        }

        /**
         * @description This variant allows developers to specify a void return.
         * @return      `Stub.Builder`
         */
        public Stub.Builder returning() {
            return methodSignatureBuilder.finalizeSignature();
        }

        /**
         * @description This variant allows developers to throw an internally
         * generated Stub.StubException object when the method is executed.
         * @return      `Stub.Builder`
         */
        public Stub.Builder throwingException() {
            throwException = true;
            return methodSignatureBuilder.finalizeSignature();
        }

        /**
         * @description           Use this variant to have this mocked method
         * return a developer-specified exception object. Useful for testing
         * exception handling with specific exception types.
         *
         * Note: This only works for custom exceptions.
         * Note: Developers construct your exception  like this:
         * `<CustomExceptioType> customException = `
         * `new <CustomExceptionType>('message');`
         *
         * @param customException
         * @return                `MockedMethod`
         */
        public Stub.Builder throwingException(Exception customException) {
            this.throwException = true;
            this.customException = customException;
            return methodSignatureBuilder.finalizeSignature();
        }

        /**
         * @description     Responsible for returning a fully formed
         * MockedMethod instance.
         * @param signature
         * @return          `MockedMethod`
         */
        public MockedMethod createMockedMethod(MethodSignature signature) {
            MockedMethod mockedMethod = new MockedMethod(signature)
                .withParameterValues(runtimeParameters);
            if (returnSObjectIds != null) {
                mockedMethod.returning(returnSObjectIds);
            }
            if (throwException) {
                if (this.customException != null) {
                    mockedMethod.throwingException(customException);
                } else {
                    mockedMethod.throwingException();
                }
            } else {
                mockedMethod.returning(returnValue);
            }

            return mockedMethod;
        }
    }
}
