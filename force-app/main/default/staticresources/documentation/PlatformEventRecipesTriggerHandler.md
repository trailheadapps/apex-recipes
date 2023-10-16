# PlatformEventRecipesTriggerHandler

Demonstrates how to construct a trigger handler for
platform events


**Inheritance**

[TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)
 &gt; 
PlatformEventRecipesTriggerHandler


**Group** Trigger Recipes


**See** [TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)

## Constructors
### `public PlatformEventRecipesTriggerHandler()`

Constructor responsible for transfering Trigger.new into a class variable

---
## Fields

### `protected context` → `TriggerContext`

*Inherited*
`TESTVISIBLE` 

### `private triggerNew` → `List<Event_Recipes_Demo__e>`


---
## Methods
### `public override void afterInsert()`

This is an admittedly contrived example. The key to Platform Event's utility is their interoperabilty. This recipe demonstrate what happens when a Platform Event is committed. Platform Event Triggers fire regardless of how the event was created:  - You can create these events either through Apex, low code tools  - and external system integrations

#### Example
```apex
Account acct = new Account(name = 'Awesome Events Ltd.');
insert acct;
Event_Recipes_Demo__e evt = new Event_Recipes_Demo__e(accountId__c = acct.id, title__c='Updated website', url__c = 'https://developer.salesforce.com');
Database.saveResults result = PlatformEventsRecipes.publishEvent(evt);
System.debug(result + [SELECT Name, Website FROM Account WHERE Id = :acct.id]);
```


### `public void run()`

*Inherited*


This is main brokering method that is called by the trigger. It's responsible for determining the proper context, and calling the correct method

#### Example
```apex
AccountTriggerHandler.run();
```


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
