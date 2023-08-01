---
layout: default
---
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
### `public allOrNothing()`
### `public throwIfRemovedFields()`
### `public doInsert(List<SObject> records)`
### `public doInsert(SObject record)`
### `public doUpdate(List<SObject> records)`
### `public doUpdate(SObject record)`
### `public doUpsert(List<SObject> records)`
### `public doUpsert(Sobject record)`
### `public doDelete(List<SObject> records)`
### `public doDelete(SObject record)`
### `public doQuery(String query)`
### `private doDML(System accessType, List<SObject> records)`
### `private guardAgainstRemovedFields(System accessType, List<SObject> records)`
---
## Classes
### RemovedFieldsException

**Inheritance**

RemovedFieldsException


---
