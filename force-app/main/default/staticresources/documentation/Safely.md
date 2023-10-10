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
### `public List doInsert(List<SObject> records)`
### `public List doInsert(SObject record)`
### `public List doUpdate(List<SObject> records)`
### `public List doUpdate(SObject record)`
### `public List doUpsert(List<SObject> records)`
### `public List doUpsert(Sobject record)`
### `public List doDelete(List<SObject> records)`
### `public List doDelete(SObject record)`
### `public List doQuery(String query)`
### `private List doDML(System accessType, List<SObject> records)`
### `private SObjectAccessDecision guardAgainstRemovedFields(System accessType, List<SObject> records)`
---
## Classes
### RemovedFieldsException

**Inheritance**

RemovedFieldsException


---
