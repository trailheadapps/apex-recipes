# AccountTriggerHandler

Demonstrates how to construct a TriggerHandler using the
trigger handler framework found in Shared Code/TriggerHandler.cls


**Inheritance**

[TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)
 &gt; 
AccountTriggerHandler


**Group** Trigger Recipes


**See** [TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)


**See** [AccountServiceLayer](https://github.com/trailheadapps/apex-recipes/wiki/AccountServiceLayer)

## Constructors
### `public AccountTriggerHandler()`

Constructor that sets class variables based on Trigger context vars

---
## Fields

### `private circuitBreaker` → `Exception`

`TESTVISIBLE` 

### `protected context` → `TriggerContext`

*Inherited*
`TESTVISIBLE` 

### `private triggerMapNew` → `Map<Id,Account>`


### `private triggerMapOld` → `Map<Id,Account>`


### `private triggerNew` → `List<Account>`


### `private triggerOld` → `List<Account>`


---
## Methods
### `public override void beforeInsert()`

Before Insert context method. Called automatically by the trigger framework this class extends.

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
accounts.add(new Account(name='example 2'));
insert accounts;
```


### `public override void afterInsert()`

after insert context method. Called automatically by the trigger framework this class extends

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
accounts.add(new Account(name='example 2'));
insert accounts;
```


### `public override void beforeUpdate()`

before update context method. Called automatically by the trigger framework this class extends

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
accounts.add(new Account(name='example 2'));
insert accounts;
accounts[0].name += ' Updated';
update accounts;
```


### `public override void afterUpdate()`

`SUPPRESSWARNINGS`

after update context method. Called automatically by the trigger framework this class extends Note: this method contains a PMD false-positive report about CRUD checking before insert. However, trigger code is run in system mode, regardless of users, so it doesn't make sense to check for Account and Task permissions. This code is therefore only safe to execute in the context of a trigger.

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
accounts.add(new Account(name='example 2'));
insert accounts;
accounts[0].name += ' Updated';
update accounts;
```


### `public override void beforeDelete()`

`SUPPRESSWARNINGS`

before delete context method. Called automatically by the trigger framework this class extends Note: this method contains a PMD false-positive report about CRUD checking before insert. However, trigger code is run in system mode, regardless of users, so it doesn't make sense to check for Account and Task permissions. This code is therefore only safe to execute in the context of a trigger.

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
insert accounts;
delete accounts;
```


### `public override void afterDelete()`

`SUPPRESSWARNINGS`

after delete context method. Called automatically by the trigger framework this class extends Note: this method contains a PMD false-positive report about CRUD checking before insert. However, trigger code is run in system mode, regardless of users, so it doesn't make sense to check for Account and Task permissions. This code is therefore only safe to execute in the context of a trigger.

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
insert accounts;
delete accounts;
```


### `public override void afterUndelete()`

`SUPPRESSWARNINGS`

after undelete context method. Called automatically by the trigger framework this class extends Note: this method contains a PMD false-positive report about CRUD checking before insert. However, trigger code is run in system mode, regardless of users, so it doesn't make sense to check for Account and Task permissions. This code is therefore only safe to execute in the context of a trigger.

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
insert accounts;
delete accounts;
undelete accounts;
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

---
## Classes
### AccountTriggerHandlerException

Custom exception class


**Inheritance**

AccountTriggerHandlerException


---
