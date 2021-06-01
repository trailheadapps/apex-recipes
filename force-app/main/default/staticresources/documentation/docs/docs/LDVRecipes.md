---
layout: default
---
# LDVRecipes class

A demonstration recipe for how to process a large amount of records in serial chunks using Queueables.

---
## Constructors
### `LDVRecipes()`
### `LDVRecipes(Id offsetId)`
---
## Properties

### `chunkSize` → `Integer`

### `objectsToProcess` → `List<ContentDocumentLink>`

### `offsetId` → `Id`

---
## Methods
### `execute(System.QueueableContext queueableContext)` → `void`
### `getRecordsToProcess(Id offsetId)` → `List<ContentDocumentLink>`
---
