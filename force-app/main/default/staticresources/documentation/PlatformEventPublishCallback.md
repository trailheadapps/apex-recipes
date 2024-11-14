# PlatformEventPublishCallback Class

Demonstrates how to write Platform Event publish success and failure callbacks

**Group** Platform Event Recipes

**See** [PlatformEventRecipes](PlatformEventRecipes.md)

**Implements**

EventBus.EventPublishFailureCallback, 
EventBus.EventPublishSuccessCallback

## Fields
### `eventMap`

Map that correlates event UUIDs with event data

#### Signature
```apex
private eventMap
```

#### Type
Map&lt;String,EventInfo&gt;

## Constructors
### `PlatformEventPublishCallback(eventInfos)`

#### Signature
```apex
public PlatformEventPublishCallback(List<EventInfo> eventInfos)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| eventInfos | List&lt;EventInfo&gt; |  |

## Methods
### `onFailure(result)`

Callback for events that failed to publish 
Note: this method is always called by the Automation user

#### Signature
```apex
public void onFailure(EventBus.FailureResult result)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| result | EventBus.FailureResult |  |

#### Return Type
**void**

---

### `onSuccess(result)`

Callback for events that were successfully published 
Note: this method is always called by the Automation user

#### Signature
```apex
public void onSuccess(EventBus.SuccessResult result)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| result | EventBus.SuccessResult |  |

#### Return Type
**void**

---

### `insertTask(eventUuids, isSuccess)`

#### Signature
```apex
private void insertTask(List<String> eventUuids, Boolean isSuccess)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| eventUuids | List&lt;String&gt; |  |
| isSuccess | Boolean |  |

#### Return Type
**void**

## Classes
### EventInfo Class

Data object that holds the minimum amount of information to identify our event and potentially republish it. 
We recommend that you don&#x27;t store all event fields to avoid hitting callback handler internal limits.

#### Fields
##### `eventUuid`

###### Signature
```apex
public eventUuid
```

###### Type
String

---

##### `accountId`

###### Signature
```apex
public accountId
```

###### Type
Id

#### Constructors
##### `EventInfo(eventUuid, accountId)`

###### Signature
```apex
public EventInfo(String eventUuid, Id accountId)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| eventUuid | String |  |
| accountId | Id |  |