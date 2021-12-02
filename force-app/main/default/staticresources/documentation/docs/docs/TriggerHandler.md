---
layout: default
---
# TriggerHandler class

An opinionated trigger handler framework. Originally by Kevin O&apos;Hara github.com/kevinohara80/sfdc-trigger-framework

## Related

AccountTriggerHandler, PlatformEventRecipesTriggerHandler

---
## Constructors
### `TriggerHandler()`

Constructs a trigger handler object and ensures the context is set
---
## Enums
### TriggerContext


possible trigger contexts

---
## Properties

### `bypassedHandlers` → `Set<String>`

### `context` → `TriggerContext`

### `isTriggerExecuting` → `Boolean`

### `loopCountMap` → `Map<String, LoopCount>`

---
## Methods
### `addToLoopCount()` → `void`

increment the loop count @exception   Throws loop count exception if the max loop count is reached

### `afterDelete()` → `void`

Virtual method for the implementing class to override

### `afterInsert()` → `void`

Virtual method for the implementing class to override

### `afterUndelete()` → `void`

Virtual method for the implementing class to override

### `afterUpdate()` → `void`

Virtual method for the implementing class to override

### `beforeDelete()` → `void`

Virtual method for the implementing class to override

### `beforeInsert()` → `void`

Virtual method for the implementing class to override

### `beforeUpdate()` → `void`

Virtual method for the implementing class to override

### `bypass(String handlerName)` → `void`

Allows developers to conditionally bypass (disable) other triggers that *also* implement this triggerHandler

#### Parameters

| Param | Description |
| ----- | ----------- |
|`handlerName` |  Class name (String) of the trigger handler to bypass |

#### Example
```java
TriggerHandler.bypass('AccountTriggerHandler');
```

### `clearAllBypasses()` → `void`

removes all classes from the bypass list

#### Example
```java
Triggerhandler.clearAllBypasses();
```

### `clearBypass(String handlerName)` → `void`

Removes a given trigger handler class name from the list of bypassed trigger handlers.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`handlerName` |  Handler class name to remove from the bypass list |

#### Example
```java
TriggerHandler.clearBypass('AccountTriggerHandler');
```

### `clearMaxLoopCount()` → `void`

Allows developers to turn off the max loop count

#### Example
```java
In the context of a TriggerHandler class,
this.clearMaxLoopCount();
```

### `getHandlerName()` → `String`

Returns the string version of the handler class being invoked

#### Return

**Type**

String

**Description**

`String` Name of the Handler

### `isBypassed(String handlerName)` → `Boolean`

Allows developers to check whether a given trigger handler class is currently bypassed.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`handlerName` |  The name of the trigger handler class to check for |

#### Return

**Type**

Boolean

**Description**

`Boolean`

#### Example
```java
TriggerHandler.isBypassed('AccountTriggerHandler');
```

### `run()` → `void`

This is main brokering method that is called by the trigger. It&apos;s responsible for determining the proper context, and calling the correct method

#### Example
```java
AccountTriggerHandler.run();
```

### `setMaxLoopCount(Integer max)` → `void`

Allows developers to prevent trigger loops, or allow a limited number of them by setting the maximum number of times this trigger is called.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`max` |    A valid number (generally 1) of times you&apos;d like |

#### Example
```java
In the context of a TriggerHandler class,
this.setMaxLoopCount(5);
```

### `setTriggerContext()` → `void`

internal method to forcibly set the trigger context

### `setTriggerContext(String ctx, Boolean testMode)` → `void`

Internal method for manually setting the trigger context

#### Parameters

| Param | Description |
| ----- | ----------- |
|`ctx` |       The current trigger Context |
|`testMode` |  Is the trigger running in a test context? |

### `validateRun()` → `Boolean`

make sure this trigger should continue to run

#### Return

**Type**

Boolean

**Description**

`Boolean`

---
## Inner Classes

### TriggerHandler.LoopCount class

inner class for managing the loop count per handler

---
#### Constructors
##### `LoopCount()`

Loop counter method with default of 5.
##### `LoopCount(Integer max)`

Sets loop count based on the param.
###### Parameters

| Param | Description |
| ----- | ----------- |
|`max` |    Maximum number of loops to allow. |

---
#### Properties

##### `count` → `Integer`

##### `max` → `Integer`

---
#### Methods
##### `exceeded()` → `Boolean`

Determines if this we&apos;re about to exceed the loop count.

###### Return

**Type**

Boolean

**Description**

`Boolean` true if less than 0 or more than max.

##### `getCount()` → `Integer`

Returns the current loop count.

###### Return

**Type**

Integer

**Description**

`Integer` current loop count.

##### `getMax()` → `Integer`

Returns the max loop count.

###### Return

**Type**

Integer

**Description**

`Integer` max loop count.

##### `increment()` → `Boolean`

Increment the internal counter returning the results of this.exceeded().

###### Return

**Type**

Boolean

**Description**

`Boolean` true if count will exceed max count or is less

##### `setMax(Integer max)` → `void`

Sets the max loop size

###### Parameters

| Param | Description |
| ----- | ----------- |
|`max` |    The integer to set max to. |

---
### TriggerHandler.TriggerHandlerException class

Internal TriggerHandler custom exception class

---
