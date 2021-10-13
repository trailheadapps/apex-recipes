---
layout: default
---
# PlatformEventRecipesTriggerHandler class

Demonstrates how to construct a trigger handler for platform events

## Related

[TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler.md)

---
## Constructors
### `PlatformEventRecipesTriggerHandler()`

Constructor responsible for transfering Trigger.new into a class variable
---
## Properties

### `triggerNew` → `List<Event_Recipes_Demo__e>`

---
## Methods
### `afterInsert()` → `void`

This is an admittedly contrived example. The key to Platform Event&apos;s utility is their interoperabilty. This recipe demonstrate what happens when a Platform Event is committed. Platform Event Triggers fire regardless of how the event was created: - You can create these events either through Apex, low code tools - and external system integrations

#### Example
```java
Account acct = new Account(name = 'Awesome Events Ltd.');
insert acct;
Event_Recipes_Demo__e evt = new Event_Recipes_Demo__e(accountId__c = acct.id, title__c='Updated website', url__c = 'https://developer.salesforce.com');
Database.saveResults result = PlatformEventsRecipes.publishEvent(evt);
System.debug(result + [SELECT Name, Website FROM Account WHERE id = :acct.id]);
```

---
