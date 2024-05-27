# TestDouble

`ISTEST`

Implements an easy and re-usable StubProvider
Utilizes a fluent interface for ease of use.
This is merly an example of how you could build a reusable stub provider
class. There are definitely edge cases or features not handled by this class.
The general mechanism for use looks like this:
```apex
 TestDouble stub = new TestDouble(SomeClass.class);
 TestDouble.Method methodToTrack = new TestDouble.Method('methodName')
     .returning(someObject);
 stub.track(methodToTrack);
 ConsumingClass consumer = new ConsumingClass(
    (someClass) stub.generate()
 );
```


**Implemented types**

[System.StubProvider](System.StubProvider)

## Constructors
### `public TestDouble(Type objectType)`

Constructor requiring the Type parameter to ensure we always set the Type property.

#### Parameters

|Param|Description|
|---|---|
|`objectType`|Type name. ie: TestDouble.class|

---
## Fields

### `private methods` → `List<Method>`


Property holds a list of objects specifying method calls that the developer has actively specified a TestDouble or stub for.

### `private objectType` → `Type`


This is a required property! it specifies the Apex Type that is being actively stubbed. Note, you cannot stub system provided classes, sObjects and static methods. see: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_stub_api.htm for details on the limitations of the StubProvider interface

---
## Methods
### `public TestDouble track(Method toTrack)`

This adds a given method object to the list of Methods that are actively overridden and stubbed by this TestDouble instance.

#### Parameters

|Param|Description|
|---|---|
|`toTrack`|A TestDouble.Method object|

#### Returns

|Type|Description|
|---|---|
|`TestDouble`|`TestDouble`|

### `public Object generate()`

Generates the actual stub object for use in tests.

#### Returns

|Type|Description|
|---|---|
|`Object`|`Object` This object has to be casted back to the class being stubbed at the point of calling. See StubbingRecipes_Tests for an example of when, and how to cast this.|

### `public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType, List<System.Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs)`

`SUPPRESSWARNINGS`

Required method for the StubProvider interface This extensive parameter list is used to help disambiguate overloaded method names where needed. This method is used to delegate response to appropriate Method object - matched by name and params.

#### Parameters

|Param|Description|
|---|---|
|`stubbedObject`|- This is the object being stubbed|
|`stubbedMethodName`|- This is the name of the Method being stubbed|
|`returnType`|- Return type|
|`listOfParamTypes`|- List of parameter types|
|`listOfParamNames`|- List of parameter names|
|`listOfArgs`|- List of parameter values|

#### Returns

|Type|Description|
|---|---|
|`Object`|`Object` Object to be returned by the Method object this method delegates to.|

---
## Classes
### Method

This inner class describes a Method that is to be stubbed.
Multiple Method objects will likely be created in the course of your unit
tests, and these Method objects are added to the `methods` property of
your TestDouble instance.

#### Constructors
##### `public Method(String methodName)`

Minimalist constructor for this class.

###### Parameters

|Param|Description|
|---|---|
|`methodName`|the name of the method to be stubbed.|

---
#### Fields

##### `private exceptionMessage` → `String`


##### `public hasBeenCalledXTimes` → `Integer`


##### `private listOfArgs` → `List&lt;Object&gt;`


##### `private listOfParamNames` → `List&lt;String&gt;`


##### `private listOfParamTypes` → `List&lt;Type&gt;`


##### `private name` → `String`


##### `private returnValue` → `Object`


##### `private throwsException` → `Boolean`


---
#### Methods
##### `public Method withParamTypes(List&lt;Type&gt; paramTypes)`

Adds a matching ParamTypes list to this method definition. If added,

###### Parameters

|Param|Description|
|---|---|
|`paramTypes`||

###### Returns

|Type|Description|
|---|---|
|`Method`|`Method`|

##### `public Method withParamNames(List&lt;String&gt; paramNames)`
##### `public Method withArgs(List&lt;Object&gt; args)`
##### `public Method returning(Object returnValue)`
##### `public Method throwing(String exceptionMessage)`
##### `public Object handleCall()`
---

### TestDoubleException

Internal exception class.


**Inheritance**

TestDoubleException


---
