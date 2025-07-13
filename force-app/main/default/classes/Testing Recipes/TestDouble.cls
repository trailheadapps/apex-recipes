/**
 * @description Implements an easy and re-usable StubProvider
 * Utilizes a fluent interface for ease of use.
 * This is merely an example of how you could build a reusable stub provider
 * class. There are definitely edge cases or features not handled by this class.
 *
 * The general mechanism for use looks like this:
 * ```apex
 *  TestDouble stub = new TestDouble(SomeClass.class);
 *  TestDouble.Method methodToTrack = new TestDouble.Method('methodName')
 *      .returning(someObject);
 *
 *  stub.track(methodToTrack);
 *
 *  ConsumingClass consumer = new ConsumingClass(
 *     (someClass) stub.generate()
 *  );
 * ```
 */
@isTest
public class TestDouble implements System.StubProvider {
    /**
     * Internal exception class.
     */
    public class TestDoubleException extends Exception {
    }

    /**
     * Property holds a list of objects specifying method calls that
     * the developer has actively specified a TestDouble or stub for.
     */
    List<Method> methods = new List<Method>();

    /**
     * This is a required property! it specifies the Apex Type
     * that is being actively stubbed. Note, you cannot stub
     * system provided classes, sObjects and static methods.
     * see: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_stub_api.htm
     * for details on the limitations of the StubProvider interface
     */
    Type objectType;

    /**
     * @description      Constructor requiring the Type parameter to
     * ensure we always set the Type property.
     * @param objectType Type name. ie: TestDouble.class
     */
    public TestDouble(Type objectType) {
        this.objectType = objectType;
    }

    /**
     * @description   This adds a given method object to the list of Methods
     * that are actively overridden and stubbed by this `TestDouble` instance.
     * @param toTrack A `TestDouble.Method` object
     */
    public TestDouble track(Method toTrack) {
        this.methods.add(toTrack);

        return this;
    }

    /**
     * @description Generates the actual stub object for use in tests.
     * @return This object has to be casted back to the
     * class being stubbed at the point of calling. See `StubbingRecipes_Tests`
     * for an example of when, and how to cast this.
     */
    public Object generate() {
        return Test.createStub(this.objectType, this);
    }

    /**
     * @description             Required method for the StubProvider interface
     * This extensive parameter list is used to help disambiguate overloaded
     * method names where needed. This method is used to delegate response to
     * appropriate Method object - matched by name and params.
     * @param stubbedObject      - This is the object being stubbed
     * @param stubbedMethodName  - This is the name of the Method being stubbed
     * @param returnType         - Return type
     * @param listOfParamTypes   - List of parameter types
     * @param listOfParamNames   - List of parameter names
     * @param listOfArgs         - List of parameter values
     * @return Object to be returned by the Method object this method delegates to.
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public Object handleMethodCall(
        Object stubbedObject,
        String stubbedMethodName,
        Type returnType,
        List<System.Type> listOfParamTypes,
        List<String> listOfParamNames,
        List<Object> listOfArgs
    ) {
        for (Method method : methods) {
            /**
             * I'm not normally a fan of such complex if statements, but doing
             * it this way allows us to disambiguate overloaded methods.
             */
            if (method.name.toLowerCase() == stubbedMethodName.toLowerCase()) {
                // Since it's not possible to actually call a method with
                // real parameters that would result in a size difference
                // between the three list paramters - listOfParamTypes,
                // listOfParamNames, and listOfArgs - we'll only check for a
                // non zero list size on the first one.
                if (
                    method.listOfParamTypes.size() > 0 &&
                    (method.listOfParamTypes != listOfParamTypes ||
                    method.listOfParamNames != listOfParamNames ||
                    method.listOfArgs != listOfArgs)
                ) {
                    continue;
                } else {
                    return method.handleCall();
                }
            }
        }
        // Return null - which will break unit tests if no matching method has
        // been found. Ie: your unit tests will break, if you don't properly
        // stubb the methods you're calling. This is on purpose!
        return null;
    }

    /**
     * @description This inner class describes a Method that is to be stubbed.
     * Multiple Method objects will likely be created in the course of your unit
     * tests, and these Method objects are added to the `methods` property of
     * your TestDouble instance.
     */
    public class Method {
        // Name of the method being stubbed
        String name;
        // Object that will be returned by this stub
        Object returnValue;
        // A running count of the times this particular method has been called
        // useful for asserting a method has been called X times.
        public Integer hasBeenCalledXTimes = 0;
        // Specifies that this method stub should return an Exception. Note
        // if you set this to true, it will always be an instance of
        // TestDoubleException
        Boolean throwsException = false;
        // The exception string you want returned.
        String exceptionMessage = '';
        // List of types of the parameters this method must receive in order to
        // return the stub instance's returnValue. Used for disambiguation.
        List<Type> listOfParamTypes = new List<Type>();
        // List of parameter names that this method must receive in order to
        // return the stub instance's returnValue. Used for disambiguation.
        List<String> listOfParamNames = new List<String>();
        // List of parameter values that this method must receive in order to
        // return the stub instance's returnValue. Used for disambiguation.
        List<Object> listOfArgs = new List<Object>();

        /**
         * @description      Minimalist constructor for this class.
         * @param methodName the name of the method to be stubbed.
         */
        public Method(String methodName) {
            this.name = methodName;
        }

        /**
         * @description      Adds a matching ParamTypes list to this method
         * definition. If added,
         * @param paramTypes
         */
        public Method withParamTypes(List<Type> paramTypes) {
            this.listOfParamTypes = paramTypes;

            return this;
        }

        public Method withParamNames(List<String> paramNames) {
            this.listOfParamNames = paramNames;

            return this;
        }

        public Method withArgs(List<Object> args) {
            this.listOfArgs = args;

            return this;
        }

        public Method returning(Object returnValue) {
            this.returnValue = returnValue;

            return this;
        }

        public Method throwing(String exceptionMessage) {
            this.exceptionMessage = exceptionMessage;
            this.throwsException = true;
            return this;
        }

        public Object handleCall() {
            hasBeenCalledXTimes++;

            if (throwsException) {
                throw new TestDoubleException(exceptionMessage);
            }
            return returnValue;
        }
    }
}
