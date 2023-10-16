# PlatformEventRecipes

Demonstrates how to publish events on the event bus


**Group** Platform Event Recipes


**See** [PlatformEventTriggerHandler](PlatformEventTriggerHandler)


**See** [TriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/TriggerHandler)

## Methods
### `public static Database publishEvent(Event_Recipes_Demo__e event)`

publishes a platform event

#### Parameters

|Param|Description|
|---|---|
|`event`|an Event_Recipes_Demo__e object|

#### Returns

|Type|Description|
|---|---|
|`Database`|Database.SaveResult|

#### Example
```apex
Account acct = new Account(name = 'Awesome Events Ltd.');
insert acct;
Event_Recipes_Demo__e evt = new Event_Recipes_Demo__e(accountId__c = acct.id, title__c='Updated website', url__c = 'https://developer.salesforce.com');
Database.saveResults result = PlatformEventsRecipes.publishEvent(evt);
System.debug(result);
```


---
## Classes
### PlatformEventRecipesException

Internal custom exception class


**Inheritance**

PlatformEventRecipesException


---
