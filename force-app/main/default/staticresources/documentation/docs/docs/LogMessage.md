---
layout: default
---
# LogMessage class

A class for automatically attaching metadata to log messages like Quiddity and RequestID

---
## Constructors
### `LogMessage(String message)`

Constructor accepting a message to log. Severity is auto set to info
#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | e |

### `LogMessage(Exception ex)`

Constructor accepting an exception object.
#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | x |

---
## Properties

### `EXCEPTION_STRING_FORMAT` → `String`

### `message` → `String`

Public message property.

### `quiddity` → `Quiddity`

Public read only property for quiddity. Privately set.

### `requestId` → `String`

public read only property for the request ID. Privately set.

### `severity` → `LogSeverity`

Public severity property.

---
## Methods
### `toEvent()` → `Log__e`

converts this object to an event for publishing

#### Return

**Type**

Log__e

**Description**

`SObject`

---
