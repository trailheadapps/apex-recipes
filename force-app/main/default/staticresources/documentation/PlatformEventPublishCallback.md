# PlatformEventPublishCallback

Demonstrates how to write Platform Event publish success and failure callbacks


**Implemented types**

[EventBus.EventPublishFailureCallback](EventBus.EventPublishFailureCallback)
, 
[EventBus.EventPublishSuccessCallback](EventBus.EventPublishSuccessCallback)


**Group** Platform Event Recipes


**See** [PlatformEventRecipes](https://github.com/trailheadapps/apex-recipes/wiki/PlatformEventRecipes)

## Constructors
### `public PlatformEventPublishCallback(List<Event_Recipes_Demo__e> events)`
---
## Fields

### `private eventMap` → `Map<String,Event_Recipes_Demo__e>`


Map that correlates event UUIDs with events

---
## Methods
### `public void onFailure(EventBus result)`

Callback for events that failed to publish Note: this method is always called by the automation user

### `public void onSuccess(EventBus result)`

Callback for events that were successfully published Note: this method is always called by the automation user

### `private void insertTask(List<String> eventUuids, Boolean isSuccess)`
---
