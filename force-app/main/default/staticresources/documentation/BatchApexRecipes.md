# BatchApexRecipes

Demonstrates the use of the Database.Batchable interface. The
methods in this class are called by the system as the batch executes.
To execute this batch use `Database.executeBatch(new BatchApexRecipes());`
More on the Batchable interface:
https://sfdc.co/batch_interface


**Implemented types**

[Database.Batchable&lt;SObject&gt;](Database.Batchable&lt;SObject&gt;)
, 
[Database.Stateful](Database.Stateful)


**Group** Async Apex Recipes

## Fields

### `private failures` → `List<Id>`


### `private queryString` → `String`


### `private result` → `String`

`TESTVISIBLE` 

### `private successes` → `List<Id>`


### `private throwError` → `Boolean`

`TESTVISIBLE` 

---
## Methods
### `public Database start(Database context)`

This method is required by the Batchable interface. It's responsible for identifying the records that will be affected Your start method can either return a QueryLocator or an Iterable (List) The records identified here will be made available to the execute method below, in batches of up to 200 records at a time.

#### Parameters

|Param|Description|
|---|---|
|`context`|dependency injected by the system|

#### Returns

|Type|Description|
|---|---|
|`Database`|Database.QueryLocator QueryLocator object used for context|

#### Example
```apex
Database.executeBatch(new BatchApexRecipes());
```


### `public void execute(Database context, List<Account> scope)`

This method is where the actual work occurs. It's run once per batch.

#### Parameters

|Param|Description|
|---|---|
|`context`|dependency injected by the system in this batch. It's this mechanism of breaking a large number of records into smaller batches called scope (in this example) that make this easier.|
|`scope`|a list of up to 200 SObject records to be processed|

#### Example
```apex
Database.executeBatch(new BatchApexRecipes());
```


### `public void finish(Database context)`

This method is called by the system when all the individual batches have completed. Intrepid developers may send emails, or otherwise notify others of the job's completion here.

#### Parameters

|Param|Description|
|---|---|
|`context`|dependency injected by the system|

#### Example
```apex
Database.executeBatch(new BatchApexRecipes());
```


---
