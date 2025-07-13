# PlatformEventRecipesTriggerHandler Class

Demonstrates how to construct a trigger handler for 
platform events

**Group** Trigger Recipes

**See** [TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)

**Inheritance**

[TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)

## Fields
### `triggerNew`

#### Signature
```apex
private triggerNew
```

#### Type
List&lt;Event_Recipes_Demo__e&gt;

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
### `PlatformEventRecipesTriggerHandler()`

Constructor responsible for transfering Trigger.new into a 
class variable

#### Signature
```apex
public PlatformEventRecipesTriggerHandler()
```

## Methods
### `afterInsert()`

This is an admittedly contrived example. 
The key to Platform Event&#x27;s utility is their interoperabilty. 
This recipe demonstrate what happens when a Platform Event is committed. 
Platform Event Triggers fire regardless of how the event was created: 
- You can create these events either through Apex, low code tools 
- and external system integrations

#### Signature
```apex
public override void afterInsert()
```

#### Return Type
**void**

#### Example
```apex
Account acct = new Account(Name = 'Awesome Events Ltd.');
insert acct;
Event_Recipes_Demo__e evt = new Event_Recipes_Demo__e(AccountId__c = acct.id, Title__c='Updated website', Url__c = 'https://developer.salesforce.com');
Database.saveResults result = PlatformEventsRecipes.publishEvent(evt);
System.debug(result + [SELECT Name, Website FROM Account WHERE Id = :acct.id]);
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

---

### `beforeInsert()`

*Inherited*

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

*Inherited*

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

*Inherited*

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

### `afterUpdate()`

*Inherited*

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

*Inherited*

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

*Inherited*

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Virtual method for the implementing class to override

#### Signature
```apex
protected virtual void afterUndelete()
```

#### Return Type
**void**