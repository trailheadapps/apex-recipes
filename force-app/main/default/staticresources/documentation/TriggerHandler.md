# TriggerHandler

An opinionated trigger handler framework.
Originally by Kevin O'Hara github.com/kevinohara80/sfdc-trigger-framework


**Group** Shared Code


**See** [AccountTriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/AccountTriggerHandler)


**See** [PlatformEventRecipesTriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/PlatformEventRecipesTriggerHandler)

## Constructors
### `public TriggerHandler()`

Constructs a trigger handler object and ensures the context is set

---
## Fields

### `private bypassedHandlers` → `Set<String>`


### `protected context` → `TriggerContext`

`TESTVISIBLE` 

### `private isTriggerExecuting` → `Boolean`

`TESTVISIBLE` 

### `private loopCountMap` → `Map<String,LoopCount>`


---
## Methods
### `public void run()`

This is main brokering method that is called by the trigger. It's responsible for determining the proper context, and calling the correct method

#### Example
```apex
AccountTriggerHandler.run();
```


### `public void setMaxLoopCount(Integer max)`

Allows developers to prevent trigger loops, or allow a limited number of them by setting the maximum number of times this trigger is called.

#### Parameters

|Param|Description|
|---|---|
|`max`|A valid number (generally 1) of times you'd like to allow the trigger to run.|

#### Example
```apex
In the context of a TriggerHandler class,
this.setMaxLoopCount(5);
```


### `public void clearMaxLoopCount()`

Allows developers to turn off the max loop count

#### Example
```apex
In the context of a TriggerHandler class,
this.clearMaxLoopCount();
```


### `public static void bypass(String handlerName)`

Allows developers to conditionally bypass (disable) other triggers that *also* implement this triggerHandler

#### Parameters

|Param|Description|
|---|---|
|`handlerName`|Class name (String) of the trigger handler to bypass|

#### Example
```apex
TriggerHandler.bypass('AccountTriggerHandler');
```


### `public static void clearBypass(String handlerName)`

Removes a given trigger handler class name from the list of bypassed trigger handlers.

#### Parameters

|Param|Description|
|---|---|
|`handlerName`|Handler class name to remove from the bypass list|

#### Example
```apex
TriggerHandler.clearBypass('AccountTriggerHandler');
```


### `public static Boolean isBypassed(String handlerName)`

Allows developers to check whether a given trigger handler class is currently bypassed.

#### Parameters

|Param|Description|
|---|---|
|`handlerName`|The name of the trigger handler class to check for|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|`Boolean`|

#### Example
```apex
TriggerHandler.isBypassed('AccountTriggerHandler');
```


### `public static void clearAllBypasses()`

removes all classes from the bypass list

#### Example
```apex
Triggerhandler.clearAllBypasses();
```


### `private void setTriggerContext()`

`TESTVISIBLE`

private instancemethods

### `private void setTriggerContext(String ctx, Boolean testMode)`

`TESTVISIBLE`

Internal method for manually setting the trigger context

#### Parameters

|Param|Description|
|---|---|
|`ctx`|The current trigger Context|
|`testMode`|Is the trigger running in a test context?|

### `protected void addToLoopCount()`

`TESTVISIBLE`

increment the loop count

#### Throws

|Exception|Description|
|---|---|
|`Throws`|loop count exception if the max loop count is reached|

### `protected Boolean validateRun()`

`TESTVISIBLE`

make sure this trigger should continue to run

#### Returns

|Type|Description|
|---|---|
|`Boolean`|`Boolean`|

#### Throws

|Exception|Description|
|---|---|
|`TriggerHandlerException`|thrown when executing outside of a trigger|

### `private String getHandlerName()`

`TESTVISIBLE`

Returns the string version of the handler class being invoked

#### Returns

|Type|Description|
|---|---|
|`String`|`String` Name of the Handler|

### `protected void beforeInsert()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

context methods

### `protected void beforeUpdate()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void beforeDelete()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterInsert()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterUpdate()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterDelete()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterUndelete()`

`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

---
## Enums
### TriggerContext

`TESTVISIBLE`

possible trigger contexts


---
## Classes
### LoopCount

`TESTVISIBLE`

inner classes

#### Constructors
##### `public LoopCount()`

Loop counter method with default of 5.

##### `public LoopCount(Integer max)`

Sets loop count based on the param.

###### Parameters

|Param|Description|
|---|---|
|`max`|Maximum number of loops to allow.|

---
#### Fields

##### `private count` → `Integer`


##### `private max` → `Integer`


---
#### Methods
##### `public Boolean increment()`

Increment the internal counter returning the results of this.exceeded().

###### Returns

|Type|Description|
|---|---|
|`Boolean`|`Boolean` true if count will exceed max count or is less than 0.|

##### `public Boolean exceeded()`

Determines if this we're about to exceed the loop count.

###### Returns

|Type|Description|
|---|---|
|`Boolean`|`Boolean` true if less than 0 or more than max.|

##### `public Integer getMax()`

Returns the max loop count.

###### Returns

|Type|Description|
|---|---|
|`Integer`|`Integer` max loop count.|

##### `public Integer getCount()`

Returns the current loop count.

###### Returns

|Type|Description|
|---|---|
|`Integer`|`Integer` current loop count.|

##### `public void setMax(Integer max)`

Sets the max loop size

###### Parameters

|Param|Description|
|---|---|
|`max`|The integer to set max to.|

---

### TriggerHandlerException

Internal TriggerHandler custom exception class


**Inheritance**

TriggerHandlerException


---
