# LDVRecipes

A demonstration recipe for how to process a large amount of
records in serial chunks using Queueables. The idea behind this recipe
is that Queueables, in production, have no max-queue depth. Meaning that so
long as you only enqueue one new queueable, it can keep cycling through until
the entire data set is processed. This is useful for instance, when you want
to process hundreds of thousands of records.
Note: You're not able to re-enqueue within a test context, so the unit test
for this code is limited to the same number of records as chunkSize below.
Note: This should be refactored to be an abstract class that you can extend
named 'Ouroboros'. (Ouroboros = the snake eating it's own tail)


**Implemented types**

[Queueable](Queueable)


**Group** LDV Recipes

## Constructors
### `public LDVRecipes()`

No param constructor. Use for starting the chain.

### `public LDVRecipes(Id offsetId)`

Constructor accepting an ID to use as an offset. Use this version to *continue* the chain.

#### Parameters

|Param|Description|
|---|---|
|`offsetId`||

---
## Fields

### `private chunkSize` → `Integer`


### `private chunksExecuted` → `Integer`

`TESTVISIBLE` 

### `private objectsToProcess` → `List<ContentDocumentLink>`


### `private offsetId` → `Id`


---
## Methods
### `public void execute(System queueableContext)`

This method contains the 'what' happens to each chunk of records. Note, that this example doesn't actually do any processing. In a real-life use case you'd iterate over the records stored in this.objectsToProcess.

#### Parameters

|Param|Description|
|---|---|
|`queueableContext`||

### `private List<ContentDocumentLink> getRecordsToProcess(Id offsetId)`

Returns a 'cursor' - a set of records of size X from a given offset. Note: We originally intended to use OFFSET - the SOQL keyword, but discovered the max OFFSET size is 2000. This obviously won't work for large data volumes greater than 2000 so we switched to using the ID of the record. Since ID is an indexed field, this should also allow us to prevent full table scans even on the largest tables.

#### Parameters

|Param|Description|
|---|---|
|`offsetId`|The offset ID is used to demarcate already processed records.|

#### Returns

|Type|Description|
|---|---|
|`List<ContentDocumentLink>`|`List<ContentDocumentLink>`|

### `private Boolean safeToReenqueue()`
---
