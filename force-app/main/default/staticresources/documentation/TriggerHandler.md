# TriggerHandler Class
`virtual`

An opinionated trigger handler framework. 
Originally by Kevin O&#x27;Hara github.com/kevinohara80/sfdc-trigger-framework

**Group** Shared Code

**See** [AccountTriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/AccountTriggerHandler)

**See** [PlatformEventRecipesTriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/PlatformEventRecipesTriggerHandler)

## Fields
### `loopCountMap`

#### Signature
```apex
private static loopCountMap
```

#### Type
Map&lt;String,LoopCount&gt;

---

### `bypassedHandlers`

#### Signature
```apex
private static bypassedHandlers
```

#### Type
Set&lt;String&gt;

---

### `context`

`TESTVISIBLE`

#### Signature
```apex
protected context
```

#### Type
TriggerContext

---

### `isTriggerExecuting`

`TESTVISIBLE`

#### Signature
```apex
private isTriggerExecuting
```

#### Type
Boolean

## Constructors
### `TriggerHandler()`

Constructs a trigger handler object and ensures the context 
is set

#### Signature
```apex
public TriggerHandler()
```

## Methods
### `run()`

This is main brokering method that is called by the trigger. 
It&#x27;s responsible for determining the proper context, and calling the 
correct method

#### Signature
```apex
public virtual void run()
```

#### Return Type
**void**

#### Example
```apex
AccountTriggerHandler.run();
```

---

### `setMaxLoopCount(max)`

Allows developers to prevent trigger loops, or allow 
a limited number of them by setting the maximum number of times 
this trigger is called.

#### Signature
```apex
public void setMaxLoopCount(Integer max)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| max | Integer | A valid number (generally 1) of times you&#x27;d like 
to allow the trigger to run. |

#### Return Type
**void**

#### Example
In the context of a `TriggerHandler` class: 
```apex
this.setMaxLoopCount(5);
```

---

### `clearMaxLoopCount()`

Allows developers to turn off the max loop count

#### Signature
```apex
public void clearMaxLoopCount()
```

#### Return Type
**void**

#### Example
In the context of a `TriggerHandler` class: 
```apex
this.clearMaxLoopCount();
```

---

### `bypass(handlerName)`

Allows developers to conditionally bypass (disable) 
other triggers that *also* implement this triggerHandler

#### Signature
```apex
public static void bypass(String handlerName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| handlerName | String | Class name (String) of the trigger handler to bypass |

#### Return Type
**void**

#### Example
```apex
TriggerHandler.bypass('AccountTriggerHandler');
```

---

### `clearBypass(handlerName)`

Removes a given trigger handler class name from 
the list of bypassed trigger handlers.

#### Signature
```apex
public static void clearBypass(String handlerName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| handlerName | String | Handler class name to remove from the bypass list |

#### Return Type
**void**

#### Example
```apex
TriggerHandler.clearBypass('AccountTriggerHandler');
```

---

### `isBypassed(handlerName)`

Allows developers to check whether a given trigger 
handler class is currently bypassed.

#### Signature
```apex
public static Boolean isBypassed(String handlerName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| handlerName | String | The name of the trigger handler class to check for |

#### Return Type
**Boolean**

#### Example
```apex
TriggerHandler.isBypassed('AccountTriggerHandler');
```

---

### `clearAllBypasses()`

removes all classes from the bypass list

#### Signature
```apex
public static void clearAllBypasses()
```

#### Return Type
**void**

#### Example
```apex
Triggerhandler.clearAllBypasses();
```

---

### `setTriggerContext()`

`TESTVISIBLE`

private instancemethods

#### Signature
```apex
private void setTriggerContext()
```

#### Return Type
**void**

---

### `setTriggerContext(ctx, testMode)`

`TESTVISIBLE`

Internal method for manually setting the trigger context

#### Signature
```apex
private void setTriggerContext(String ctx, Boolean testMode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| ctx | String | The current trigger Context |
| testMode | Boolean | Is the trigger running in a test context? |

#### Return Type
**void**

---

### `addToLoopCount()`

`TESTVISIBLE`

increment the loop count

#### Signature
```apex
protected void addToLoopCount()
```

#### Return Type
**void**

#### Throws
Throws: loop count exception if the max loop count is reached

---

### `validateRun()`

`TESTVISIBLE`

make sure this trigger should continue to run

#### Signature
```apex
protected Boolean validateRun()
```

#### Return Type
**Boolean**

#### Throws
TriggerHandlerException: thrown when executing outside of a,[object Object],trigger

---

### `getHandlerName()`

`TESTVISIBLE`

Returns the string version of the handler class being 
invoked

#### Signature
```apex
private String getHandlerName()
```

#### Return Type
**String**

Name of the Handler

---

### `beforeInsert()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

context methods

#### Signature
```apex
protected virtual void beforeInsert()
```

#### Return Type
**void**

---

### `beforeUpdate()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature
```apex
protected virtual void beforeUpdate()
```

#### Return Type
**void**

---

### `beforeDelete()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature
```apex
protected virtual void beforeDelete()
```

#### Return Type
**void**

---

### `afterInsert()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature
```apex
protected virtual void afterInsert()
```

#### Return Type
**void**

---

### `afterUpdate()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature
```apex
protected virtual void afterUpdate()
```

#### Return Type
**void**

---

### `afterDelete()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature
```apex
protected virtual void afterDelete()
```

#### Return Type
**void**

---

### `afterUndelete()`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature
```apex
protected virtual void afterUndelete()
```

#### Return Type
**void**

## Classes
### TriggerHandlerException Class

Internal TriggerHandler custom exception class

### LoopCount Class

`TESTVISIBLE`

inner classes

#### Fields
##### `max`

###### Signature
```apex
private max
```

###### Type
Integer

---

##### `count`

###### Signature
```apex
private count
```

###### Type
Integer

#### Constructors
##### `LoopCount()`

Loop counter method with default of 5.

###### Signature
```apex
public LoopCount()
```

---

##### `LoopCount(max)`

Sets loop count based on the param.

###### Signature
```apex
public LoopCount(Integer max)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| max | Integer | Maximum number of loops to allow. |

#### Methods
##### `increment()`

Increment the internal counter returning the results of 
this.exceeded().

###### Signature
```apex
public Boolean increment()
```

###### Return Type
**Boolean**

true if count will exceed max count or is less,[object Object],than 0.

---

##### `exceeded()`

Determines if this we&#x27;re about to exceed the loop count.

###### Signature
```apex
public Boolean exceeded()
```

###### Return Type
**Boolean**

true if less than 0 or more than max.

---

##### `getMax()`

Returns the max loop count.

###### Signature
```apex
public Integer getMax()
```

###### Return Type
**Integer**

max loop count.

---

##### `getCount()`

Returns the current loop count.

###### Signature
```apex
public Integer getCount()
```

###### Return Type
**Integer**

current loop count.

---

##### `setMax(max)`

Sets the max loop size

###### Signature
```apex
public void setMax(Integer max)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| max | Integer | The integer to set max to. |

###### Return Type
**void**

## Enums
### TriggerContext Enum

`TESTVISIBLE`

possible trigger contexts

#### Values
| Value | Description |
|-------|-------------|
| BEFORE_INSERT |  |
| BEFORE_UPDATE |  |
| BEFORE_DELETE |  |
| AFTER_INSERT |  |
| AFTER_UPDATE |  |
| AFTER_DELETE |  |
| AFTER_UNDELETE |  |