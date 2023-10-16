# MetadataTriggerHandler

This class exists as a unified, trigger handler class. It
uses Custom Metadata, and introspection of the Trigger.new variable to
determine what trigger handler classes should be called, and in what order.
Metadata_Driven_Trigger__mdt has three fields:
 * Object__c - is a metadata entity look up to an sObject ie: Account
 * Execution_Order__c - is an integer and determines the order the trigger
 *   handlers are executed
 * Class__c - is a String holding the name of the Trigger Handler to execute
Note: This Trigger framework works like this:
An .trigger for a sObject invokes this class via:
new MetadataTriggerHandler().run();
This trigger handler class extends TriggerHandler - all the trigger handler
classes _must_ extend trigger handler. Most classes will only overwrite the
context methods like afterUpdate(). This class, however, overrides the run
method. This class is responsible for determining which other trigger
handler classes to instantiate and run.
Concrete example:
AccountTrigger.trigger (in this org) - invokes this class.
This class queries the custom metadata and will find (at least) one metadata
record tied to Account and the metadata record's Class__c specifies
AccountTriggerHandler. This class then loops over the returned metadata
records, instantiating the classes specified. It then calls the appropriate
context methods on those classes.
Note: The TriggerHandler framework below does *not* give you the ability to
order, or re-arrange the trigger work of managed packages. It also does not
allow you to declare the *order of methods* within the triggerHandler classes
themselves. When using the MetadataTriggerHandler, it's better to have a
high number of singularly focused trigger handler classes than a few classes
with multiple methods.


**Inheritance**

[TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)
 &gt; 
MetadataTriggerHandler


**Group** Trigger Recipes


**See** [TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)

## Constructors
### `public MetadataTriggerHandler()`

Constructor used by live triggers.

### `public MetadataTriggerHandler(MetadataTriggerService mts)`
---
## Fields

### `private activeHandler` → `TriggerHandler`

`TESTVISIBLE` 

### `protected context` → `TriggerContext`

*Inherited*
`TESTVISIBLE` 

### `private mts` → `MetadataTriggerService`

`TESTVISIBLE` 

### `private tryggers` → `List<Metadata_Driven_Trigger__mdt>`

`TESTVISIBLE` 

---
## Methods
### `public override void run()`

`SUPPRESSWARNINGS`

Overrides the standard Run() method, which allows this metadata based trigger handler can be an incremental update / sit beside other trigger handlers classes that are directly invoked by a trigger

### `public void setMaxLoopCount(Integer max)`

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


### `public void clearMaxLoopCount()`

*Inherited*


Allows developers to turn off the max loop count

#### Example
```apex
In the context of a TriggerHandler class,
this.clearMaxLoopCount();
```


### `public static void bypass(String handlerName)`

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


### `public static void clearBypass(String handlerName)`

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


### `public static Boolean isBypassed(String handlerName)`

*Inherited*


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

*Inherited*


removes all classes from the bypass list

#### Example
```apex
Triggerhandler.clearAllBypasses();
```


### `protected void addToLoopCount()`

*Inherited*


`TESTVISIBLE`

increment the loop count

#### Throws

|Exception|Description|
|---|---|
|`Throws`|loop count exception if the max loop count is reached|

### `protected Boolean validateRun()`

*Inherited*


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

### `protected void beforeInsert()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

context methods

### `protected void beforeUpdate()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void beforeDelete()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterInsert()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterUpdate()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterDelete()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

### `protected void afterUndelete()`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

---
