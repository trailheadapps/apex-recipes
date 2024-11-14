# LDVRecipes Class

A demonstration recipe for how to process a large amount of 
records in serial chunks using Queueables. The idea behind this recipe 
is that Queueables, in production, have no max-queue depth. Meaning that so 
long as you only enqueue one new queueable, it can keep cycling through until 
the entire data set is processed. This is useful for instance, when you want 
to process hundreds of thousands of records. 
 
Note: You&#x27;re not able to re-enqueue within a test context, so the unit test 
for this code is limited to the same number of records as chunkSize below. 
 
Note: This should be refactored to be an abstract class that you can extend 
named &#x27;Ouroboros&#x27;. (Ouroboros &#x3D; the snake eating it&#x27;s own tail)

**Group** LDV Recipes

**Implements**

Queueable

## Fields
### `chunkSize`

#### Signature
```apex
private final chunkSize
```

#### Type
Integer

---

### `offsetId`

#### Signature
```apex
private offsetId
```

#### Type
Id

---

### `objectsToProcess`

#### Signature
```apex
private objectsToProcess
```

#### Type
List&lt;ContentDocumentLink&gt;

---

### `chunksExecuted`

`TESTVISIBLE`

#### Signature
```apex
private static chunksExecuted
```

#### Type
Integer

## Constructors
### `LDVRecipes()`

No param constructor. Use for starting the chain.

#### Signature
```apex
public LDVRecipes()
```

---

### `LDVRecipes(offsetId)`

Constructor accepting an ID to use as an offset. Use 
this version to *continue* the chain.

#### Signature
```apex
public LDVRecipes(Id offsetId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| offsetId | Id |  |

## Methods
### `execute(queueableContext)`

This method contains the &#x27;what&#x27; happens to each 
chunk of records. Note, that this example doesn&#x27;t actually do any 
processing. In a real-life use case you&#x27;d iterate over the records stored 
in this.objectsToProcess.

#### Signature
```apex
public void execute(System.QueueableContext queueableContext)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| queueableContext | System.QueueableContext |  |

#### Return Type
**void**

---

### `getRecordsToProcess(offsetId)`

Returns a &#x27;cursor&#x27; - a set of records of size X from a 
given offset. Note: We originally intended to use OFFSET - the SOQL 
keyword, but discovered the max OFFSET size is 2000. This obviously won&#x27;t 
work for large data volumes greater than 2000 so we switched to using the 
ID of the record. Since ID is an indexed field, this should also allow 
us to prevent full table scans even on the largest tables.

#### Signature
```apex
private List<ContentDocumentLink> getRecordsToProcess(Id offsetId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| offsetId | Id | The offset ID is used to demarcate already processed 
records. |

#### Return Type
**List&lt;ContentDocumentLink&gt;**

---

### `safeToReenqueue()`

#### Signature
```apex
private Boolean safeToReenqueue()
```

#### Return Type
**Boolean**