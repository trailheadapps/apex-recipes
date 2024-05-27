# LogMessage

A class for automatically attaching metadata to log messages
like Quiddity and RequestID


**Group** Shared Code

## Constructors
### `public LogMessage(String message)`

Constructor accepting a message to log. Severity is auto set to info

#### Parameters

|Param|Description|
|---|---|
|`message`||

### `public LogMessage(Exception ex)`

Constructor accepting an exception object.

#### Parameters

|Param|Description|
|---|---|
|`ex`||

---
## Fields

### `private EXCEPTION_STRING_FORMAT` → `String`


---
## Properties

### `public message` → `String`


Public message property.

### `public quiddity` → `Quiddity`


Public read only property for quiddity. Privately set.

### `public requestId` → `String`


public read only property for the request ID. Privately set.

### `public severity` → `LogSeverity`


Public severity property.

---
## Methods
### `public Log__e toEvent()`

converts this object to an event for publishing

#### Returns

|Type|Description|
|---|---|
|`Log__e`|`SObject`|

---
