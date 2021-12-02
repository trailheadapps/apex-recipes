---
layout: default
---
# Log class

Generic logging framework that persists across DML reversions by publishing a Platform Event

---
## Constructors
### `Log()`

establishes the buffer, if one doesn&apos;t yet exist private, to ensure we can&apos;t directly construct this class. Use the Singleton, Luke.
---
## Properties

### `buffer` → `List<LogMessage>`

private list of LogMessage objects to be published in the future

### `currentInstance` → `Log`

private instance of this log class that backs the singleton get() method.

---
## Methods
### `add(String messageToLog)` → `void`

Add a message to the buffer without publishing it. Assumes a null severity

#### Parameters

| Param | Description |
| ----- | ----------- |
|`messageToLog` |   The string message to add to the buffer. |

### `add(String messageToLog, LogSeverity severity)` → `void`

Add a message to the buffer without publishing it.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`messageToLog` |  The string message to add to the buffer. |
|`severity` |      LogSeverity enum |

### `add(Exception exceptionToLog)` → `void`

Add an formated exception message to the buffer without publishing it. Assumes a null Severity

#### Parameters

| Param | Description |
| ----- | ----------- |
|`exceptionToLog` |  Exception to format and log |

### `add(Exception exceptionToLog, LogSeverity severity)` → `void`

Add an formated exception message to the buffer without publishing it.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`exceptionToLog` |  Exception to format and log |
|`severity` |        LogSeverity enum |

### `get()` → `Log`

Singleton pattern `get` method.

#### Return

**Type**

Log

**Description**

`Log`

### `publish()` → `void`

Publish any messages currently in the buffer, without adding any new ones.

### `publish(Exception exceptionToLog)` → `void`

Auto-format exception details, add it to the log buffer, and then publish the current buffer. Use the equivelent add method if you intend to add multiple messages rapidly to minimize DML usage.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`exceptionToLog` |  exception to format and log |

### `publish(String messageToLog)` → `void`

Auto-format a custom log message string, add it to the log buffer, and then publish the current buffer. Use the equivelent add method if you intend to add multiple messages rapidly to minimize DML usage.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`messageToLog` |  String to log |

---
