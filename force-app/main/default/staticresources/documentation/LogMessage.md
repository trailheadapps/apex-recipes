# LogMessage Class

A class for automatically attaching metadata to log messages 
like Quiddity and RequestID

**Group** Shared Code

## Fields
### `EXCEPTION_STRING_FORMAT`

#### Signature
```apex
private static final EXCEPTION_STRING_FORMAT
```

#### Type
String

## Properties
### `requestId`

public read only property for the request ID. Privately set.

#### Signature
```apex
public requestId
```

#### Type
String

---

### `quiddity`

Public read only property for quiddity. Privately set.

#### Signature
```apex
public quiddity
```

#### Type
Quiddity

---

### `message`

Public message property.

#### Signature
```apex
public message
```

#### Type
String

---

### `severity`

Public severity property.

#### Signature
```apex
public severity
```

#### Type
[LogSeverity](LogSeverity.md)

## Constructors
### `LogMessage(message)`

Constructor accepting a message to log. 
Severity is auto set to info

#### Signature
```apex
public LogMessage(String message)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| message | String |  |

---

### `LogMessage(ex)`

Constructor accepting an exception object.

#### Signature
```apex
public LogMessage(Exception ex)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| ex | Exception |  |

## Methods
### `toEvent()`

converts this object to an event for publishing

#### Signature
```apex
public Log__e toEvent()
```

#### Return Type
**Log__e**