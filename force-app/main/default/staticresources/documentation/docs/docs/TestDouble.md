---
layout: default
---
# TestDouble class

Implements an easy and re-usable StubProvider Utilizes a fluent interface for ease of use. This is merly an example of how you could build a reusable stub provider class. There are definitely edge cases or features not handled by this class. The general mechanism for use looks like this: ```apex TestDouble stub = new TestDouble(SomeClass.class); TestDouble.Method methodToTrack = new TestDouble.Method(&apos;methodName&apos;) .returning(someObject); stub.track(methodToTrack); ConsumingClass consumer = new ConsumingClass( (someClass) stub.generate() ); ```

---
## Constructors
### `TestDouble(Type objectType)`

Constructor requiring the Type parameter to ensure we always set the Type property.
#### Parameters

| Param | Description |
| ----- | ----------- |
|`objectType` |  Type name. ie: TestDouble.class |

---
## Methods
### `generate()` → `Object`

Generates the actual stub object for use in tests.

#### Return

**Type**

Object

**Description**

`Object` This object has to be casted back to the

### `handleCall()` → `Object`
### `handleMethodCall(Object stubbedObject,String stubbedMethodName,Type returnType,List<System.Type> listOfParamTypes,List<String> listOfParamNames,List<Object> listOfArgs)` → `Object`

Required method for the StubProvider interface This extensive parameter list is used to help disambiguate overloaded method names where needed. This method is used to delegate response to appropriate Method object - matched by name and params.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`stubbedObject` |       - This is the object being stubbed |
|`stubbedMethodName` |   - This is the name of the Method being stubbed |
|`returnType` |          - Return type |
|`listOfParamTypes` |    - List of parameter types |
|`listOfParamNames` |    - List of parameter names |
|`listOfArgs` |          - List of parameter values |

#### Return

**Type**

Object

**Description**

`Object` Object to be returned by the Method

### `returning(Object returnValue)` → `Method`
### `throwing(String exceptionMessage)` → `Method`
### `track(Method toTrack)` → `TestDouble`

This adds a given method object to the list of Methods that are actively overridden and stubbed by this TestDouble instance.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`toTrack` |  A TestDouble.Method object |

#### Return

**Type**

TestDouble

**Description**

`TestDouble`

### `withArgs(List<Object> args)` → `Method`
### `withParamNames(List<String> paramNames)` → `Method`
### `withParamTypes(List<Type> paramTypes)` → `Method`

Adds a matching ParamTypes list to this method definition. If added,

#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | s |

#### Return

**Type**

Method

**Description**

`Method`

---
## Inner Classes

### TestDouble.Method class

 I&apos;m not normally a fan of such complex if statements, but doing it this way allows us to disambiguate overloaded methods. /** This inner class describes a Method that is to be stubbed. Multiple Method objects will likely be created in the course of your unit tests, and these Method objects are added to the `methods` property of your TestDouble instance.

---
#### Constructors
##### `Method(String methodName)`

Minimalist constructor for this class.
###### Parameters

| Param | Description |
| ----- | ----------- |
|`methodName` |  the name of the method to be stubbed. |

---
#### Properties

##### `hasBeenCalledXTimes` → `Integer`

---
### TestDouble.TestDoubleException class

 Internal exception class.

---
