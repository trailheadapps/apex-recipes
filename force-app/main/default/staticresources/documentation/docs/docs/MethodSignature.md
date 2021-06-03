---
layout: default
---
# MethodSignature class

Class models a callable apex method's 'signature' or combination of Name, Parameter types and Parameter values. This is separate from a MockedMethod, because it can be constructed at runtime for comparison against established MockedMethods.

---
## Constructors
### `MethodSignature(String methodName, List<Type> paramTypes)`

Constructor requiring a method name and list of parameters. This method cannot be constructed without these.
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |
|`` | s |

---
## Properties

### `methodName` → `String`

### `methodParameterTypes` → `List<Type>`

---
## Methods
### `buildMockedMethod()` → `List<MockedMethod>`

Creates the MockedMethod matching this method signature.

#### Return

**Type**

List<MockedMethod>

**Description**

`List<MockedMethod>`

### `finalizeSignature()` → `Stub.Builder`

Called at the end of building a method signature.

#### Return

**Type**

Stub.Builder

**Description**

`Stub.Builder`

### `getMethodName()` → `String`
### `verifyMethodNamesMatch(String originalMethodName,String comparitorMethodName)` → `Boolean`

Returns true if the current MethodSignature's methodName is a case insensitive match to the comparison's methodName

#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |
|`` | e |

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `verifySignatureMatch(MethodSignature otherSignature)` → `Boolean`

This is used to compare the signature of a MockedMethod, against another instance. Used at runtime to compare an actually requested method call against pre-defined mocks.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `withParameterTypes(List<System.Type> parameters)` → `MockedMethod.Builder`

Omnibus variant that handles a list(N) of parameters.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

#### Return

**Type**

MockedMethod.Builder

**Description**

`MockedMethod.Builder`

### `withParameterTypes(System.Type paramater)` → `MockedMethod.Builder`

This variant handles a single parameter, brokers to omnibus method.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

#### Return

**Type**

MockedMethod.Builder

**Description**

`MockedMethod.Builder`

### `withParameterTypes(System.Type parameter,System.Type parameter2)` → `MockedMethod.Builder`

Two parameter variant. Brokers to omnibus method.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |
|`` | 2 |

#### Return

**Type**

MockedMethod.Builder

**Description**

`MockedMethod.Builder`

### `withParameterTypes(System.Type parameter,System.Type parameter2,System.Type parameter3)` → `MockedMethod.Builder`

Three parameter variant. Brokers to omnibus method.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |
|`` | 2 |
|`` | 3 |

#### Return

**Type**

MockedMethod.Builder

**Description**

`MockedMethod.Builder`

### `withParameterTypes(System.Type parameter,System.Type parameter2,System.Type parameter3,System.Type parameter4)` → `MockedMethod.Builder`

Four parameter variant. Brokers to omnibus method.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |
|`` | 2 |
|`` | 3 |
|`` | 4 |

#### Return

**Type**

MockedMethod.Builder

**Description**

`MockedMethod.Builder`

---
## Inner Classes

### MethodSignature.Builder class

While a MethodSignature object can be created directly the more common usecase is to use this Builder class to construct the MethodSignature object in a Fluent api style.

---
#### Constructors
##### `Builder(Stub.Builder builder,String methodName,List<System.Type> paramTypes)`

Constructor.
###### Parameters
|Param|Description|
|-----|-----------|
|`builder` |     A Stub.Builder object |
|`methodName` |  String referencing the name of the method minus |
|`paramTypes` |  A list of System.Types that define the order and |

---
#### Properties

##### `methodName` → `String`

##### `parameterTypes` → `List<Type>`

##### `stubBuilder` → `Stub.Builder`

---
