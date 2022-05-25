---
layout: default
---
# BatchApexRecipes class

Demonstrates the use of the Database.Batchable interface. The methods in this class are called by the system as the batch executes. To execute this batch use `Database.executeBatch(new BatchApexRecipes());` More on the Batchable interface: https://sfdc.co/batch_interface

---
## Properties

### `failures` → `List<Id>`

### `queryString` → `String`

### `result` → `String`

### `successes` → `List<Id>`

### `throwError` → `Boolean`

---
## Methods
### `execute(Database.BatchableContext context,List<Account> scope)` → `void`

This method is where the actual work occurs. It&apos;s run once per batch.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`context` |  dependency injected by the system in this batch. It&apos;s this |
|`scope` |  a list of up to 200 SObject records to be processed |

#### Example
```java
Database.executeBatch(new BatchApexRecipes());
```

### `finish(Database.BatchableContext context)` → `void`

This method is called by the system when all the individual batches have completed. Intrepid developers may send emails, or otherwise notify others of the job&apos;s completion here.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`context` |  dependency injected by the system |

#### Example
```java
Database.executeBatch(new BatchApexRecipes());
```

### `start(Database.BatchableContext context)` → `Database.QueryLocator`

This method is required by the Batchable interface. It&apos;s responsible for identifying the records that will be affected Your start method can either return a QueryLocator or an Iterable (List) The records identified here will be made available to the execute method below, in batches of up to 200 records at a time.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`context` |  dependency injected by the system |

#### Return

**Type**

Database.QueryLocator

**Description**

Database.QueryLocator QueryLocator object used for context

#### Example
```java
Database.executeBatch(new BatchApexRecipes());
```

---
