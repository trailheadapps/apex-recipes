# PlatformEventRecipes Class

Demonstrates how to publish events on the event bus

**Group** Platform Event Recipes

**See** [PlatformEventRecipesTriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/PlatformEventRecipesTriggerHandler)

**See** [PlatformEventPublishCallback](PlatformEventPublishCallback.md)

## Methods
### `publishEvent(event)`

publishes a platform event

#### Signature
```apex
public static Database.SaveResult publishEvent(Event_Recipes_Demo__e event)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| event | Event_Recipes_Demo__e | an `Event_Recipes_Demo__e` object |

#### Return Type
**Database.SaveResult**

#### Example
```apex
Account acct = new Account(Name = 'Awesome Events Ltd.');
insert acct;
Event_Recipes_Demo__e evt = new Event_Recipes_Demo__e(AccountId__c = acct.id, Title__c='Updated website', Url__c = 'https://developer.salesforce.com');
Database.saveResults result = PlatformEventsRecipes.publishEvent(evt);
System.debug(result);
```

---

### `publishEventWithCallbacks(event)`

publishes a platform event and handles success/failure with callbacks

#### Signature
```apex
public static Database.SaveResult publishEventWithCallbacks(Event_Recipes_Demo__e event)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| event | Event_Recipes_Demo__e | an `Event_Recipes_Demo__e` object |

#### Return Type
**Database.SaveResult**

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

## Classes
### PlatformEventRecipesException Class

Internal custom exception class