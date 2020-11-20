---
layout: default
---
# Log class
---
## Constructors
### `Log()`
---
## Properties

### `buffer` → `List<LogMessage>`

### `currentInstance` → `Log`

---
## Methods
### `add(String messageToLog)` → `void`

 Add a message to the buffer without publishing it.

### `add(String messageToLog, LogSeverity severity)` → `void`
### `add(Exception exceptionToLog)` → `void`

 Add an formated exception message to the buffer without publishing it.

### `add(Exception exceptionToLog, LogSeverity severity)` → `void`
### `get()` → `Log`
### `publish()` → `void`

 Publish any messages currently in the buffer, without adding any new ones.

### `publish(Exception exceptionToLog)` → `void`

 Auto-format exception details, add it to the log buffer, and then publish the current buffer.

### `publish(String messageToLog)` → `void`

 Auto-format a custom log message string, add it to the log buffer, and then publish the current buffer. Use the equivelent add method if you intend to add multiple messages rapidly to minimize DML usage.

---
