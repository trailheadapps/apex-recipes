# TestDouble Class

`ISTEST`

Implements an easy and re-usable StubProvider 
Utilizes a fluent interface for ease of use. 
This is merely an example of how you could build a reusable stub provider 
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

**Implements**

System.StubProvider

## Fields
### `methods`

Property holds a list of objects specifying method calls that 
the developer has actively specified a TestDouble or stub for.

#### Signature
```apex
private methods
```

#### Type
List&lt;Method&gt;

---

### `objectType`

This is a required property! it specifies the Apex Type 
that is being actively stubbed. Note, you cannot stub 
system provided classes, sObjects and static methods. 
see: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_stub_api.htm 
for details on the limitations of the StubProvider interface

#### Signature
```apex
private objectType
```

#### Type
Type

## Constructors
### `TestDouble(objectType)`

Constructor requiring the Type parameter to 
ensure we always set the Type property.

#### Signature
```apex
public TestDouble(Type objectType)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objectType | Type | Type name. ie: TestDouble.class |

## Methods
### `track(toTrack)`

This adds a given method object to the list of Methods 
that are actively overridden and stubbed by this `TestDouble` instance.

#### Signature
```apex
public TestDouble track(Method toTrack)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| toTrack | Method | A `TestDouble.Method` object |

#### Return Type
**[TestDouble](TestDouble.md)**

---

### `generate()`

Generates the actual stub object for use in tests.

#### Signature
```apex
public Object generate()
```

#### Return Type
**Object**

This object has to be casted back to the,[object Object],class being stubbed at the point of calling. See ,[object Object],[object Object],for an example of when, and how to cast this.

---

### `handleMethodCall(stubbedObject, stubbedMethodName, returnType, listOfParamTypes, listOfParamNames, listOfArgs)`

`SUPPRESSWARNINGS`

Required method for the StubProvider interface 
This extensive parameter list is used to help disambiguate overloaded 
method names where needed. This method is used to delegate response to 
appropriate Method object - matched by name and params.

#### Signature
```apex
public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType, List<System.Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| stubbedObject | Object | - This is the object being stubbed |
| stubbedMethodName | String | - This is the name of the Method being stubbed |
| returnType | Type | - Return type |
| listOfParamTypes | List&lt;System.Type&gt; | - List of parameter types |
| listOfParamNames | List&lt;String&gt; | - List of parameter names |
| listOfArgs | List&lt;Object&gt; | - List of parameter values |

#### Return Type
**Object**

Object to be returned by the Method object this method delegates to.

## Classes
### TestDoubleException Class

Internal exception class.

### Method Class

This inner class describes a Method that is to be stubbed. 
Multiple Method objects will likely be created in the course of your unit 
tests, and these Method objects are added to the `methods` property of 
your TestDouble instance.

#### Fields
##### `name`

###### Signature
```apex
private name
```

###### Type
String

---

##### `returnValue`

###### Signature
```apex
private returnValue
```

###### Type
Object

---

##### `hasBeenCalledXTimes`

###### Signature
```apex
public hasBeenCalledXTimes
```

###### Type
Integer

---

##### `throwsException`

###### Signature
```apex
private throwsException
```

###### Type
Boolean

---

##### `exceptionMessage`

###### Signature
```apex
private exceptionMessage
```

###### Type
String

---

##### `listOfParamTypes`

###### Signature
```apex
private listOfParamTypes
```

###### Type
List&lt;Type&gt;

---

##### `listOfParamNames`

###### Signature
```apex
private listOfParamNames
```

###### Type
List&lt;String&gt;

---

##### `listOfArgs`

###### Signature
```apex
private listOfArgs
```

###### Type
List&lt;Object&gt;

#### Constructors
##### `Method(methodName)`

Minimalist constructor for this class.

###### Signature
```apex
public Method(String methodName)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| methodName | String | the name of the method to be stubbed. |

#### Methods
##### `withParamTypes(paramTypes)`

Adds a matching ParamTypes list to this method 
definition. If added,

###### Signature
```apex
public Method withParamTypes(List<Type> paramTypes)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| paramTypes | List&lt;Type&gt; |  |

###### Return Type
**Method**

---

##### `withParamNames(paramNames)`

###### Signature
```apex
public Method withParamNames(List<String> paramNames)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| paramNames | List&lt;String&gt; |  |

###### Return Type
**Method**

---

##### `withArgs(args)`

###### Signature
```apex
public Method withArgs(List<Object> args)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| args | List&lt;Object&gt; |  |

###### Return Type
**Method**

---

##### `returning(returnValue)`

###### Signature
```apex
public Method returning(Object returnValue)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| returnValue | Object |  |

###### Return Type
**Method**

---

##### `throwing(exceptionMessage)`

###### Signature
```apex
public Method throwing(String exceptionMessage)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| exceptionMessage | String |  |

###### Return Type
**Method**

---

##### `handleCall()`

###### Signature
```apex
public Object handleCall()
```

###### Return Type
**Object**