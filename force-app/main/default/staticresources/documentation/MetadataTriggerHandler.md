# MetadataTriggerHandler Class

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
record tied to Account and the metadata record&#x27;s Class__c specifies 
AccountTriggerHandler. This class then loops over the returned metadata 
records, instantiating the classes specified. It then calls the appropriate 
context methods on those classes. 
 
Note: The TriggerHandler framework below does *not* give you the ability to 
order, or re-arrange the trigger work of managed packages. It also does not 
allow you to declare the *order of methods* within the triggerHandler classes 
themselves. When using the MetadataTriggerHandler, it&#x27;s better to have a 
high number of singularly focused trigger handler classes than a few classes 
with multiple methods.

**Group** Trigger Recipes

**See** [TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)

**Inheritance**

[TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)

## Fields
### `mts`

`TESTVISIBLE`

#### Signature
```apex
private mts
```

#### Type
[MetadataTriggerService](https://github.com/trailheadapps/apex-recipes/wiki/MetadataTriggerService)

---

### `tryggers`

`TESTVISIBLE`

#### Signature
```apex
private tryggers
```

#### Type
List&lt;Metadata_Driven_Trigger__mdt&gt;

---

### `activeHandler`

`TESTVISIBLE`

#### Signature
```apex
private activeHandler
```

#### Type
[TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)

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
### `MetadataTriggerHandler()`

Constructor used by live triggers.

#### Signature
```apex
public MetadataTriggerHandler()
```

---

### `MetadataTriggerHandler(mts)`

#### Signature
```apex
public MetadataTriggerHandler(MetadataTriggerService mts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| mts | [MetadataTriggerService](https://github.com/trailheadapps/apex-recipes/wiki/MetadataTriggerService) |  |

## Methods
### `run()`

`SUPPRESSWARNINGS`

Overrides the standard Run() method, which allows this 
metadata based trigger handler can be an incremental update / sit beside 
other trigger handlers classes that are directly invoked by a trigger

#### Signature
```apex
public override void run()
```

#### Return Type
**void**

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

### `afterInsert()`

*Inherited*

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