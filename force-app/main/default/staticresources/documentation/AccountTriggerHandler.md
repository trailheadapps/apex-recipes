# AccountTriggerHandler Class

Demonstrates how to construct a TriggerHandler using the 
trigger handler framework found in Shared Code/TriggerHandler.cls

**Group** Trigger Recipes

**See** [TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)

**See** [AccountServiceLayer](https://github.com/trailheadapps/apex-recipes/wiki/AccountServiceLayer)

**Inheritance**

[TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)

## Fields
### `triggerNew`

#### Signature
```apex
private triggerNew
```

#### Type
List&lt;Account&gt;

---

### `triggerOld`

#### Signature
```apex
private triggerOld
```

#### Type
List&lt;Account&gt;

---

### `triggerMapNew`

#### Signature
```apex
private triggerMapNew
```

#### Type
Map&lt;Id,Account&gt;

---

### `triggerMapOld`

#### Signature
```apex
private triggerMapOld
```

#### Type
Map&lt;Id,Account&gt;

---

### `circuitBreaker`

`TESTVISIBLE`

#### Signature
```apex
private static circuitBreaker
```

#### Type
Exception

---

### `context`

*Inherited*

`TESTVISIBLE`

#### Signature
```apex
protected context
```

#### Type
TriggerContext

## Constructors
### `AccountTriggerHandler()`

Constructor that sets class variables based on Trigger 
context vars

#### Signature
```apex
public AccountTriggerHandler()
```

## Methods
### `beforeInsert()`

Before Insert context method. Called automatically by the 
trigger framework this class extends.

#### Signature
```apex
public override void beforeInsert()
```

#### Return Type
**void**

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
accounts.add(new Account(name='example 2'));
insert accounts;
```

---

### `afterInsert()`

after insert context method. Called automatically by the 
trigger framework this class extends

#### Signature
```apex
public override void afterInsert()
```

#### Return Type
**void**

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
accounts.add(new Account(name='example 2'));
insert accounts;
```

---

### `beforeUpdate()`

before update context method. Called automatically by the 
trigger framework this class extends

#### Signature
```apex
public override void beforeUpdate()
```

#### Return Type
**void**

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
accounts.add(new Account(name='example 2'));
insert accounts;
accounts[0].name += ' Updated';
update accounts;
```

---

### `afterUpdate()`

`SUPPRESSWARNINGS`

after update context method. Called automatically by the 
trigger framework this class extends 
 
Note: this method contains a PMD false-positive report about CRUD 
checking before insert. However, trigger code is run in system mode, 
regardless of users, so it doesn&#x27;t make sense to check for Account and 
Task permissions. This code is therefore only safe to execute in the 
context of a trigger.

#### Signature
```apex
public override void afterUpdate()
```

#### Return Type
**void**

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
accounts.add(new Account(name='example 2'));
insert accounts;
accounts[0].name += ' Updated';
update accounts;
```

---

### `beforeDelete()`

`SUPPRESSWARNINGS`

before delete context method. Called automatically by the 
trigger framework this class extends 
 
Note: this method contains a PMD false-positive report about CRUD 
checking before insert. However, trigger code is run in system mode, 
regardless of users, so it doesn&#x27;t make sense to check for Account and 
Task permissions. This code is therefore only safe to execute in the 
context of a trigger.

#### Signature
```apex
public override void beforeDelete()
```

#### Return Type
**void**

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
insert accounts;
delete accounts;
```

---

### `afterDelete()`

`SUPPRESSWARNINGS`

after delete context method. Called automatically by the 
trigger framework this class extends 
 
Note: this method contains a PMD false-positive report about CRUD 
checking before insert. However, trigger code is run in system mode, 
regardless of users, so it doesn&#x27;t make sense to check for Account and 
Task permissions. This code is therefore only safe to execute in the 
context of a trigger.

#### Signature
```apex
public override void afterDelete()
```

#### Return Type
**void**

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
insert accounts;
delete accounts;
```

---

### `afterUndelete()`

`SUPPRESSWARNINGS`

after undelete context method. Called automatically by the 
trigger framework this class extends 
 
Note: this method contains a PMD false-positive report about CRUD 
checking before insert. However, trigger code is run in system mode, 
regardless of users, so it doesn&#x27;t make sense to check for Account and 
Task permissions. This code is therefore only safe to execute in the 
context of a trigger.

#### Signature
```apex
public override void afterUndelete()
```

#### Return Type
**void**

#### Example
```apex
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
insert accounts;
delete accounts;
undelete accounts;
```

---

### `run()`

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

### `addToLoopCount()`

*Inherited*

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

*Inherited*

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

## Classes
### AccountTriggerHandlerException Class

Custom exception class