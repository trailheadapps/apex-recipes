# BatchApexRecipes Class

Demonstrates the use of the Database.Batchable interface. The 
methods in this class are called by the system as the batch executes. 
To execute this batch use `Database.executeBatch(new BatchApexRecipes());` 
 
More on the Batchable interface: 
https://sfdc.co/batch_interface

**Group** Async Apex Recipes

**Implements**

Database.Batchable&lt;SObject&gt;, 
Database.Stateful

## Fields
### `successes`

#### Signature
```apex
private successes
```

#### Type
List&lt;Id&gt;

---

### `failures`

#### Signature
```apex
private failures
```

#### Type
List&lt;Id&gt;

---

### `queryString`

#### Signature
```apex
private final queryString
```

#### Type
String

---

### `result`

`TESTVISIBLE`

#### Signature
```apex
private static result
```

#### Type
String

---

### `throwError`

`TESTVISIBLE`

#### Signature
```apex
private throwError
```

#### Type
Boolean

## Methods
### `start(context)`

This method is required by the Batchable interface. 
It&#x27;s responsible for identifying the records that will be affected 
Your start method can either return a QueryLocator or an Iterable 
(List) The records identified here will be made available to the 
execute method below, in batches of up to 200 records at a time.

#### Signature
```apex
public Database.QueryLocator start(Database.BatchableContext context)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| context | Database.BatchableContext | dependency injected by the system |

#### Return Type
**Database.QueryLocator**

QueryLocator object used for context

#### Example
```apex
Database.executeBatch(new BatchApexRecipes());
```

---

### `execute(context, scope)`

This method is where the actual work occurs. It&#x27;s run once 
per batch.

#### Signature
```apex
public void execute(Database.BatchableContext context, List<Account> scope)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| context | Database.BatchableContext | dependency injected by the system in this batch. It&#x27;s this 
mechanism of breaking a large number of records into smaller batches 
called scope (in this example) that make this easier. |
| scope | List&lt;Account&gt; | a list of up to 200 SObject records to be processed |

#### Return Type
**void**

#### Example
```apex
Database.executeBatch(new BatchApexRecipes());
```

---

### `finish(context)`

This method is called by the system when all the individual 
batches have completed. Intrepid developers may send emails, or otherwise 
notify others of the job&#x27;s completion here.

#### Signature
```apex
public void finish(Database.BatchableContext context)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| context | Database.BatchableContext | dependency injected by the system |

#### Return Type
**void**

#### Example
```apex
Database.executeBatch(new BatchApexRecipes());
```