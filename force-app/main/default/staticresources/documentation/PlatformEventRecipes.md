# PlatformEventRecipes

Demonstrates how to publish events on the event bus


**Group** Platform Event Recipes


**See** [PlatformEventRecipesTriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/PlatformEventRecipesTriggerHandler)


**See** [PlatformEventPublishCallback](https://github.com/trailheadapps/apex-recipes/wiki/PlatformEventPublishCallback)

## Methods
### `public static Database.SaveResult publishEvent(Event_Recipes_Demo__e event)`

publishes a platform event

#### Parameters

|Param|Description|
|---|---|
|`event`|an `Event_Recipes_Demo__e` object|

#### Returns

|Type|Description|
|---|---|
|`Database.SaveResult`|Database.SaveResult|

#### Example
```apex
Account acct = new Account(Name = 'Awesome Events Ltd.');
insert acct;
Event_Recipes_Demo__e evt = new Event_Recipes_Demo__e(AccountId__c = acct.id, Title__c='Updated website', Url__c = 'https://developer.salesforce.com');
Database.saveResults result = PlatformEventsRecipes.publishEvent(evt);
System.debug(result);
```


### `public static Database.SaveResult publishEventWithCallbacks(Event_Recipes_Demo__e event)`

publishes a platform event and handles success/failure with callbacks

#### Parameters

|Param|Description|
|---|---|
|`event`|an `Event_Recipes_Demo__e` object|

#### Returns

|Type|Description|
|---|---|
|`Database.SaveResult`|Database.SaveResult|

#### Example
```apex
Account acct = new Account(Name = 'Awesome Events Ltd.');
insert acct;
// Creating the event via sObjectType.newSObject is required to obtain an EventUuid
Event_Recipes_Demo__e event = (Event_Recipes_Demo__e) Event_Recipes_Demo__e.sObjectType.newSObject(null, true);
event.AccountId__c = acct.Id;
event.Title__c = 'Updated website';
event.Url__c = 'https://developer.salesforce.com';
PlatformEventRecipes.publishEventWithCallbacks(event);
```


---
## Classes
### PlatformEventRecipesException

Internal custom exception class


**Inheritance**

PlatformEventRecipesException


---
