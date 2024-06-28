# PlatformEventPublishCallback

Demonstrates how to write Platform Event publish success and failure callbacks


**Implemented types**

[EventBus.EventPublishFailureCallback](EventBus.EventPublishFailureCallback)
, 
[EventBus.EventPublishSuccessCallback](EventBus.EventPublishSuccessCallback)


**Group** Platform Event Recipes


**See** [PlatformEventRecipes](https://github.com/trailheadapps/apex-recipes/wiki/PlatformEventRecipes)

## Constructors
### `public PlatformEventPublishCallback(List<EventInfo> eventInfos)`
---
## Fields

### `private eventMap` → `Map<String,EventInfo>`


Map that correlates event UUIDs with event data

---
## Methods
### `public void onFailure(EventBus result)`

Callback for events that failed to publish Note: this method is always called by the Automation user

### `public void onSuccess(EventBus result)`

Callback for events that were successfully published Note: this method is always called by the Automation user

### `private void insertTask(List<String> eventUuids, Boolean isSuccess)`
---
## Classes
### EventInfo

Data object that holds the minimum amount of information to identify our event and potentially republish it.
We recommend that you don't store all event fields to avoid hitting callback handler internal limits.

#### Constructors
##### `public EventInfo(String eventUuid, Id accountId)`
---
#### Fields

##### `public eventUuid` → `String`


##### `public accountId` → `Id`


---

---
