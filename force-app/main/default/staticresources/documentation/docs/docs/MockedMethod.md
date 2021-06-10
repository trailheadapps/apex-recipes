---
layout: default
---
# MockedMethod class

Represents a method call that is mocked as part of a Stub object. This class is marked @isTest, as the object and it's methods are not useful outside of a Test context. This file contains not only the MockedMethod class, but an inner Builder class. It is expected most developers will utilize the Builder class to construct instances of MockedMethod.

---
## Constructors
### `MockedMethod(MethodSignature methodSignature)`

Constructor requiring a method signature. This is used to prevent constructing MockedMethods without a signature.
#### Parameters
|Param|Description|
|-----|-----------|
|`methodSignature` |  We need this to define the shape of the method |

---
## Properties

### `countOfMethodInvocations` → `Integer`

### `customException` → `Exception`

### `exceptionMessage` → `String`

### `expectedParameters` → `List<Object>`

### `methodSignature` → `MethodSignature`

Every MockedMethod has a methodSignature defining it's 'signature' or combination of name, parameter names and parameter types.

### `returnValue` → `Object`

### `sObjectIds` → `List<Id>`

### `throwException` → `Boolean`

---
## Methods
### `assertMockedMethodWasCalled()` → `void`

If this MockedMethod has not been called cause a failing assertion.

### `doMethodSignaturesAndParametersMatch(MethodSignature methodSignature,List<Object> runtimeParameters)` → `Boolean`

determines if the current method call matches on both a method signature level and against specified input parameters.

#### Parameters
|Param|Description|
|-----|-----------|
|`methodSignature` |  A method signature to match against. |
|`runtimeParameters` |  a List of objects representing the actual |

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `doRuntimeParametersMatch(List<Object> compareTo)` → `Boolean`

Determines if the method, as brokered by the stub object is being called with an expected set of parameters. Note: I thought I could replace this with `return this.methodParamsAtExecutionTime.equals(compareTo);` but this doesn't work, and to be honest, I'm still investigating why.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | o |

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `handleCall()` → `Object`

This method is invoked by it's parent stub object, and is responsible for returning the mocked value.

#### Return

**Type**

Object

**Description**

`Object`

### `returning(Object returnValue)` → `MockedMethod`

Sets this MockedMethod's return value. This is the value that will be returned by this mocked method when the stub calls a method that has an identical name, signature and input paramter list.

#### Parameters
|Param|Description|
|-----|-----------|
|`returnValue` |  This is the object you want returned. |

#### Return

**Type**

MockedMethod

**Description**

`MockedMethod`

### `returning(List<Id> incomingIds)` → `MockedMethod`

Use this variant of returning when you want the mocked method to return a list of sObjects (generic) with a specific set of IDs

#### Parameters
|Param|Description|
|-----|-----------|
|`incomingIds` |  A list of ID's. Note, they don't have to be ids of the |

#### Return

**Type**

MockedMethod

**Description**

`MockedMethod`

### `throwingException()` → `MockedMethod`

Use this method when you need the mocked method to throw an exception. Incredibly useful for testing exception handling! Note: This variant results in a generic StubException being thrown.

#### Return

**Type**

MockedMethod

**Description**

`MockedMethod`

### `throwingException(Exception customException)` → `MockedMethod`

Use this variant to have this mocked method return a developer-specified exception object. Useful for testing exception handling with specific exception types.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | n |

#### Return

**Type**

MockedMethod

**Description**

`MockedMethod`

### `withParameterValues(List<Object> args)` → `MockedMethod`

Allows developers to define expected input parameters at execution time. This enables developers to mock the same method call N number of times, with different input parameters.

#### Parameters
|Param|Description|
|-----|-----------|
|`args` |   A list of Objects that you want to this MockedMethod to |

#### Return

**Type**

MockedMethod

**Description**

`MockedMethod`

---
## Inner Classes

### MockedMethod.Builder class

class provides a 'builder' or fluent interface for constructing MockedMethod objects. While the end-developer can create MockedMethod objects directly, the point of this class is to provide an intuitive and easy-to-use/comprehend interface for building nuanced MockedMethod Objects.

---
#### Constructors
##### `Builder(MethodSignature.Builder methodSignatureBuilder,List<System.Type> args)`

Constructor requiring a methodSignatureBuilder object and a list of runtime arguments
###### Parameters
|Param|Description|
|-----|-----------|
|`` | r |
|`` | s |

---
#### Properties

##### `customException` → `Exception`

##### `methodSignatureBuilder` → `MethodSignature.Builder`

##### `returnSObjectIds` → `List<Id>`

##### `returnValue` → `Object`

##### `runtimeParameters` → `List<Object>`

##### `throwException` → `Boolean`

---
#### Methods
##### `createMockedMethod(MethodSignature signature)` → `MockedMethod`

Responsible for returning a fully formed MockedMethod instance.

###### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

###### Return

**Type**

MockedMethod

**Description**

`MockedMethod`

##### `returning(Object returnValue)` → `Stub.Builder`

This variant allows developers to specify the object that will be returned when this mocked method is executed by its parent stub.

###### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

###### Return

**Type**

Stub.Builder

**Description**

`Stub.Builder`

##### `returning()` → `Stub.Builder`

This variant allows developers to specify a void return.

###### Return

**Type**

Stub.Builder

**Description**

`Stub.Builder`

##### `returningObjectsWithIds(List<Id> ids)` → `Stub.Builder`

This variant allows developers to specify a list of IDs to be assigned to the returning sObject List

###### Parameters
|Param|Description|
|-----|-----------|
|`ids` |    The list of Ids to assign. |

###### Return

**Type**

Stub.Builder

**Description**

`MockedMethod.Builder`

##### `setParameterValues(List<Object> parameters)` → `MockedMethod.Builder`

internal method used to set the parameter values of this MockedMethod instance.

###### Parameters
|Param|Description|
|-----|-----------|
|`parameters` |  list of System.Type |

###### Return

**Type**

MockedMethod.Builder

**Description**

`MockedMethod`

##### `throwingException()` → `Stub.Builder`

This variant allows developers to throw an internally generated Stub.StubException object when the method is executed.

###### Return

**Type**

Stub.Builder

**Description**

`Stub.Builder`

##### `throwingException(Exception customException)` → `Stub.Builder`

Use this variant to have this mocked method return a developer-specified exception object. Useful for testing exception handling with specific exception types. Note: This only works for custom exceptions. Note: Developers construct your exception  like this: `<CustomExceptioType> customException = ` `new <CustomExceptionType>('message');`

###### Parameters
|Param|Description|
|-----|-----------|
|`` | n |

###### Return

**Type**

Stub.Builder

**Description**

`MockedMethod`

##### `withParameterValues(Object parameter)` → `MockedMethod.Builder`

convenience methodfor setting a single parameter type

###### Parameters
|Param|Description|
|-----|-----------|
|`parameter` |  System.Type |

###### Return

**Type**

MockedMethod.Builder

**Description**

this

##### `withParameterValues(Object parameter,Object parameter2)` → `MockedMethod.Builder`

convenience methodfor setting two params

###### Parameters
|Param|Description|
|-----|-----------|
|`parameter` |   System.Type |
|`parameter2` |  System.Type |

###### Return

**Type**

MockedMethod.Builder

**Description**

this

##### `withParameterValues(Object parameter,Object parameter2,Object parameter3)` → `MockedMethod.Builder`

convenience methodfor setting three params

###### Parameters
|Param|Description|
|-----|-----------|
|`parameter` |   System.Type |
|`parameter2` |  System.Type |
|`parameter3` |  System.Type |

###### Return

**Type**

MockedMethod.Builder

**Description**

return description

##### `withParameterValues(Object parameter,Object parameter2,Object parameter3,Object parameter4)` → `MockedMethod.Builder`

convenience methodfor setting four parameters

###### Parameters
|Param|Description|
|-----|-----------|
|`parameter` |   parameter description |
|`parameter2` |  parameter2 description |
|`parameter3` |  parameter3 description |
|`parameter4` |  parameter4 description |

###### Return

**Type**

MockedMethod.Builder

**Description**

this

---
