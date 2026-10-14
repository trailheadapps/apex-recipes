# Log Class

Generic logging framework that persists across DML reversions 
by publishing a Platform Event

**Group** Shared Code

## Fields
### `currentInstance`

private instance of this log class that backs the 
singleton get() method.

#### Signature
```apex
private static currentInstance
```

#### Type
[Log](Log.md)

---

### `buffer`

private list of LogMessage objects to be published in the 
future

#### Signature
```apex
private buffer
```

#### Type
List&lt;LogMessage&gt;

## Constructors
### `Log()`

establishes the buffer, if one doesn&#x27;t yet exist 
private, to ensure we can&#x27;t directly construct this class. Use the 
Singleton, Luke.

#### Signature
```apex
private Log()
```

## Methods
### `get()`

Singleton pattern `get` method.

#### Signature
```apex
public static Log get()
```

#### Return Type
**[Log](Log.md)**

---

### `add(messageToLog)`

Add a message to the buffer without publishing it. 
Assumes a null severity

#### Signature
```apex
public void add(String messageToLog)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| messageToLog | String | The string message to add to the buffer. |

#### Return Type
**void**

---

### `add(messageToLog, severity)`

Add a message to the buffer without publishing it.

#### Signature
```apex
public void add(String messageToLog, LogSeverity severity)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| messageToLog | String | The string message to add to the buffer. |
| severity | [LogSeverity](LogSeverity.md) | LogSeverity enum |

#### Return Type
**void**

---

### `add(exceptionToLog)`

Add an formated exception message to the buffer without 
publishing it. Assumes a null Severity

#### Signature
```apex
public void add(Exception exceptionToLog)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| exceptionToLog | Exception | Exception to format and log |

#### Return Type
**void**

---

### `add(exceptionToLog, severity)`

Add an formated exception message to the buffer without 
publishing it.

#### Signature
```apex
public void add(Exception exceptionToLog, LogSeverity severity)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| exceptionToLog | Exception | Exception to format and log |
| severity | [LogSeverity](LogSeverity.md) | LogSeverity enum |

#### Return Type
**void**

---

### `publish()`

Publish any messages currently in the buffer, without adding 
any new ones.

#### Signature
```apex
public void publish()
```

#### Return Type
**void**

---

### `publish(exceptionToLog)`

Auto-format exception details, add it to the log buffer, 
and then publish the current buffer. Use the equivelent add 
method if you intend to add multiple messages rapidly to minimize DML 
usage.

#### Signature
```apex
public void publish(Exception exceptionToLog)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| exceptionToLog | Exception | exception to format and log |

#### Return Type
**void**

---

### `publish(messageToLog)`

Auto-format a custom log message string, add it to the log 
buffer, and then publish the current buffer. Use the equivelent add 
method if you intend to add multiple messages rapidly to minimize DML 
usage.

#### Signature
```apex
public void publish(String messageToLog)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| messageToLog | String | String to log |

#### Return Type
**void**