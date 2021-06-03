---
layout: default
---
# Stub class

This class helps you construct and manage StubProvider conforming objects for use in Unit Tests. It, along with it's companion classes: MockedMethod MethodSignature and their builder-pattern inner classes are designed to work together with a fluent API style like this: ```apex StubObject fooStub = new StubObject.Builder('foo.class') .mockingMethodCall('someMethodName', List<Object> Params) .withParameterTypes() .returning() || .throwingException() || .throwingException(ExceptionObj) .mockingMethodCall('secondMethodName', ...) .withParameterTypes() .returning() || .throwingException() || .throwingException(ExceptionObj) .createStub() ```

---
## Constructors
### `Stub(Type objectType)`

required constructor finalizing the object type.
#### Parameters
|Param|Description|
|-----|-----------|
|`objectType` |  Type class: ie: Foo.class |

### `Stub(Type objectType, List<MockedMethod> mockedMethods)`

convenience construtor that accepts a pre-built list of MockedMethod objects.
#### Parameters
|Param|Description|
|-----|-----------|
|`objectType` |     type class: ie. Foo.class |
|`mockedMethods` |  List of MockedMethod objects |

---
## Properties

### `mockedMethods` → `List<MockedMethod>`

### `objectType` → `Type`

---
## Methods
### `assertAllMockedMethodsWereCalled()` → `void`

Useful for asserting the methods you mocked were, in fact, called. It does this by invoking the assertMockedMethodWasCalled on each individual mocked method.

### `createStub()` → `Object`

returns the this constructed class with it's mocked methods as a single stub object to be used in a unit test.

#### Return

**Type**

Object

**Description**

`Object` Needs to be cast back to the type of object used.

### `defineStub(Boolean generateInjectableStub)` → `Object`

Generates a Stub object from this builder object.

#### Parameters
|Param|Description|
|-----|-----------|
|`If` |  true, calls the stub objects' createStub method |

#### Return

**Type**

Object

**Description**

`Stub`

### `defineStub()` → `Stub`
### `handleMethodCall(Object obj,String methodName,Type returnType,List<Type> paramTypes,List<String> paramNames,List<Object> args)` → `Object`

method required by the StubProvider interface. Handles the mock execution of the given method call.

#### Parameters
|Param|Description|
|-----|-----------|
|`obj` |         dependency injected by Apex, object the mock method |
|`methodName` |  dependency injected by Apex, string representation |
|`returnType` |  dependency injected by Apex, not currently used. |
|`paramTypes` |  dependency injected by Apex, list of parameter types |
|`paramNames` |  dependency injected by Apex, not currently used. |
|`args` |        dependency injected by Apex, not currently used. |

#### Return

**Type**

Object

**Description**

`Object`

### `mockingMethodCall(String methodName,List<Type> paramTypes)` → `MethodSignature.Builder`

This method, and it's overloaded variants below, all work to add a new MockedMethod to the stub object. Semantically the idea is that you'll invoke one of these 'mockingMethodCall' methods for every method you want your stub to react to. Because this builder class is designed around method chaining, you can invoke a number of these in a row. See the example invocation at the top of this class.

#### Parameters
|Param|Description|
|-----|-----------|
|`methodName` |  Required, name of the method that will be mocked |
|`paramTypes` |  List of System.Types that the mocked method should |

#### Return

**Type**

MethodSignature.Builder

**Description**

`MethodSignature.Builder` - returns the builder

### `mockingMethodCall(String methodName)` → `MethodSignature.Builder`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

#### Parameters
|Param|Description|
|-----|-----------|
|`methodName` |  Method name to be mocked. |

#### Return

**Type**

MethodSignature.Builder

**Description**

`MethodSignature.Builder`

### `mockingMethodCall(String methodName,Type paramType)` → `MockedMethod.Builder`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

#### Parameters
|Param|Description|
|-----|-----------|
|`methodName` |  required. method name to be mocked. |
|`paramType` |   Type of single parameter. |

#### Return

**Type**

MockedMethod.Builder

**Description**

`MethodSignature.Builder`

### `mockingMethodCall(String methodName,Type paramType,Type paramType2)` → `MockedMethod.Builder`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

#### Parameters
|Param|Description|
|-----|-----------|
|`methodName` |  required. method name to be mocked. |
|`paramType` |   param type 1. |
|`paramType2` |  param type 2. |

#### Return

**Type**

MockedMethod.Builder

**Description**

`MethodSignature.Builder`

### `mockingMethodCall(String methodName,Type paramType,Type paramType2,Type paramType3)` → `MockedMethod.Builder`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

#### Parameters
|Param|Description|
|-----|-----------|
|`methodName` |  required. method name to be mocked. |
|`paramType` |   param type 1. |
|`paramType2` |  param type 2. |
|`paramType3` |  param type 3. |

#### Return

**Type**

MockedMethod.Builder

**Description**

`MethodSignature.Builder`

### `mockingMethodCall(String methodName,Type paramType,Type paramType2,Type paramType3,Type paramType4)` → `MockedMethod.Builder`

Overloaded variant of the main 'mockingMethodCall' method. See docs for the first instance of mockingMethodCall in this class.

#### Parameters
|Param|Description|
|-----|-----------|
|`methodName` |  required. method name to be mocked. |
|`paramType` |   param type 1. |
|`paramType2` |  param type 2. |
|`paramType3` |  param type 3. |
|`paramType4` |  param type 4. |

#### Return

**Type**

MockedMethod.Builder

**Description**

`MethodSignature.Builder`

---
## Inner Classes

### Stub.Builder class

Builder pattern for creating stubs with a fluent interface. Note, there are three 'Builder' classes, each an inner class of the object that the builder builds. In this case, this builder inner class is responsible for building Stub objects. While you can directly instantiate the Stub class, the idea is that you will actually use the Builder class/interface to create Stubs

---
#### Constructors
##### `Builder(Type objType)`

Constructor requiring the objectType. We do that to enforce that all Stub builders have an object type.
###### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

---
#### Properties

##### `objectType` → `Type`

holds the System.Type reference for the object that you're building a stub for.

---
### Stub.StubException class

Class is used by Stub, MethodSignature and MockedMethod classes for throwing when an exception occurs that is specifically related to building, using or asserting against the Super Stub framework

---
