# Safely

Class wraps DML Calls in FLS / Crud checks. Library is baseed on
a fluent api system. All calls are constructed, then chained with options.
For instances. `new Safely().allOrNothing().doInsert(List&lt;sObject&gt;);`
Notable chainable methods include:
- allOrNothing() - this enforces the AllOrNothing DML flag. All DML is
     eventually executed via Database.* methods which accept an allOrNothing
     parameter requiring all of the records to succeed or fail.
- throwIfRemovedFields() - this method, if called, will result in an
    exception being thrown if any record being modified has fields removed
    by the security decision.

## Fields

### `private allOrNothing` → `Boolean`

`TESTVISIBLE` 

### `private throwIfRemovedFields` → `Boolean`

`TESTVISIBLE` 

---
## Methods
### `public Safely allOrNothing()`
### `public Safely throwIfRemovedFields()`
### `public List<Database.SaveResult> doInsert(List<SObject> records)`
### `public List<Database.SaveResult> doInsert(SObject record)`
### `public List<Database.SaveResult> doUpdate(List<SObject> records)`
### `public List<Database.SaveResult> doUpdate(SObject record)`
### `public List<Database.UpsertResult> doUpsert(List<SObject> records)`
### `public List<Database.UpsertResult> doUpsert(Sobject record)`
### `public List<Database.DeleteResult> doDelete(List<SObject> records)`
### `public List<Database.DeleteResult> doDelete(SObject record)`
### `public List<SObject> doQuery(String query)`
### `private List<Database.SaveResult> doDML(System accessType, List<SObject> records)`
### `private SObjectAccessDecision guardAgainstRemovedFields(System accessType, List<SObject> records)`
---
## Classes
### RemovedFieldsException

**Inheritance**

RemovedFieldsException


---
