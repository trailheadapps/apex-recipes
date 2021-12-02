---
layout: default
---
# PlatformEventRecipes class

Demonstrates how to publish events on the event bus

## Related

PlatformEventTriggerHandler, TriggerHandler

---
## Methods
### `publishEvent(Event_Recipes_Demo__e event)` → `Database.SaveResult`

publishes a platform event

#### Parameters

| Param | Description |
| ----- | ----------- |
|`event` |  an Event_Recipes_Demo__e object |

#### Return

**Type**

Database.SaveResult

**Description**

Database.SaveResult

#### Example
```java
Account acct = new Account(name = 'Awesome Events Ltd.');
insert acct;
Event_Recipes_Demo__e evt = new Event_Recipes_Demo__e(accountId__c = acct.id, title__c='Updated website', url__c = 'https://developer.salesforce.com');
Database.saveResults result = PlatformEventsRecipes.publishEvent(evt);
System.debug(result);
```

---
## Inner Classes

### PlatformEventRecipes.PlatformEventRecipesException class

Internal custom exception class

---
