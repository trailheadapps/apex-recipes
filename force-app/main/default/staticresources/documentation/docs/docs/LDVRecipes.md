---
layout: default
---
# LDVRecipes class

A demonstration recipe for how to process a large amount of records in serial chunks using Queueables. The idea behind this recipe is that Queueables, in production, have no max-queue depth. Meaning that so long as you only enqueue one new queueable, it can keep cycling through until the entire data set is processed. This is useful for instance, when you want to process hundreds of thousands of records. Note: You&apos;re not able to re-enqueue within a test context, so the unit test for this code is limited to the same number of records as chunkSize below. Note: This should be refactored to be an abstract class that you can extend named &apos;Ouroboros&apos;. (Ouroboros = the snake eating it&apos;s own tail)

---
## Constructors
### `LDVRecipes()`

No param constructor. Use for starting the chain.
### `LDVRecipes(Id offsetId)`

Constructor accepting an ID to use as an offset. Use this version to *continue* the chain.
#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | d |

---
## Properties

### `chunkSize` → `Integer`

### `chunksExecuted` → `Integer`

### `objectsToProcess` → `List<ContentDocumentLink>`

### `offsetId` → `Id`

---
## Methods
### `execute(System.QueueableContext queueableContext)` → `void`

This method contains the &apos;what&apos; happens to each chunk of records. Note, that this example doesn&apos;t actually do any processing. In a real-life use case you&apos;d iterate over the records stored in this.objectsToProcess.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | t |

### `getRecordsToProcess(Id offsetId)` → `List<ContentDocumentLink>`

Returns a &apos;cursor&apos; - a set of records of size X from a given offset. Note: We originally intended to use OFFSET - the SOQL keyword, but discovered the max OFFSET size is 2000. This obviously won&apos;t work for large data volumes greater than 2000 so we switched to using the ID of the record. Since ID is an indexed field, this should also allow us to prevent full table scans even on the largest tables.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`offsetId` |  The offset id is used to demarcate already processed |

#### Return

**Type**

List&lt;ContentDocumentLink&gt;

**Description**

`List&lt;ContentDocumentLink&gt;`

### `safeToReenqueue()` → `Boolean`
---
