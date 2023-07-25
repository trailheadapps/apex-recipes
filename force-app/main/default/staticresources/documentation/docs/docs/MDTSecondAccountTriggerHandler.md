---
layout: default
---
# MDTSecondAccountTriggerHandler

This is a simple trigger handler class for Account that is used
to demonstrate the custom metadata trigger handler approach to multiple
trigger handler classes ordered by and controlled by custom metadata.


**Inheritance**

[TriggerHandler](../Shared-Code/TriggerHandler.md)
 &gt; 
MDTSecondAccountTriggerHandler


**See** [MetadataTriggerHandler](../Trigger-Recipes/MetadataTriggerHandler.md)

## Fields

### `protected context` → `TriggerContext`

*Inherited*
`TESTVISIBLE` 

---
## Methods
### `public override beforeUpdate()`
### `public run()`

*Inherited*


This is main brokering method that is called by the trigger. It's responsible for determining the proper context, and calling the correct method

#### Example
```apex
AccountTriggerHandler.run();
```


### `public setMaxLoopCount(Integer max)`

*Inherited*


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


### `public clearMaxLoopCount()`

*Inherited*


Allows developers to turn off the max loop count

#### Example
```apex
In the context of a TriggerHandler class,
this.clearMaxLoopCount();
```


### `public static bypass(String handlerName)`

*Inherited*


Allows developers to conditionally bypass (disable) other triggers that *also* implement this triggerHandler

#### Parameters

|Param|Description|
|---|---|
|`handlerName`|Class name (String) of the trigger handler to bypass|

#### Example
```apex
TriggerHandler.bypass('AccountTriggerHandler');
```


### `public static clearBypass(String handlerName)`

*Inherited*


Removes a given trigger handler class name from the list of bypassed trigger handlers.

#### Parameters

|Param|Description|
|---|---|
|`handlerName`|Handler class name to remove from the bypass list|

#### Example
```apex
TriggerHandler.clearBypass('AccountTriggerHandler');
```


### `public static isBypassed(String handlerName)`

*Inherited*


Allows developers to check whether a given trigger handler class is currently bypassed.

#### Parameters

|Param|Description|
|---|---|
|`handlerName`|The name of the trigger handler class to check for|

#### Returns

|Type|Description|
|---|---|
|Boolean|`Boolean`|

#### Example
```apex
TriggerHandler.isBypassed('AccountTriggerHandler');
```


### `public static clearAllBypasses()`

*Inherited*


removes all classes from the bypass list

#### Example
```apex
Triggerhandler.clearAllBypasses();
```


### `protected addToLoopCount()`

*Inherited*


`TESTVISIBLE`

increment the loop count

#### Throws

|Exception|Description|
|---|---|
|`Throws`|loop count exception if the max loop count is reached|

### `protected validateRun()`

*Inherited*


`TESTVISIBLE`

make sure this trigger should continue to run

#### Returns

|Type|Description|
|---|---|
|Boolean|`Boolean`|

#### Throws

|Exception|Description|
|---|---|
|`TriggerHandlerException`|thrown when executing outside of a trigger|

### `protected beforeInsert()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

context methods

### `protected beforeDelete()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected afterInsert()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected afterUpdate()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected afterDelete()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected afterUndelete()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

---
