---
layout: default
---
# Safely class

Class wraps DML Calls in FLS / Crud checks. Library is baseed on a fluent api system. All calls are constructed, then chained with options. For instances. `new Safely().allOrNothing().doInsert(List&lt;sObject&gt;);` Notable chainable methods include: - allOrNothing() - this enforces the AllOrNothing DML flag. All DML is eventually executed via Database.* methods which accept an allOrNothing parameter requiring all of the records to succeed or fail. - throwIfRemovedFields() - this method, if called, will result in an exception being thrown if any record being modified has fields removed by the security decision.

---
## Properties

### `allOrNothing` → `Boolean`

### `throwIfRemovedFields` → `Boolean`

---
## Methods
### `allOrNothing()` → `Safely`
### `doDML(System.AccessType accessType,List<SObject> records)` → `List<Database.SaveResult>`
### `doDelete(List<SObject> records)` → `List<Database.DeleteResult>`
### `doDelete(SObject record)` → `List<Database.DeleteResult>`
### `doInsert(List<SObject> records)` → `List<Database.SaveResult>`
### `doInsert(SObject record)` → `List<Database.SaveResult>`
### `doQuery(String query)` → `List<SObject>`
### `doUpdate(List<SObject> records)` → `List<Database.SaveResult>`
### `doUpdate(SObject record)` → `List<Database.SaveResult>`
### `doUpsert(List<SObject> records)` → `List<Database.UpsertResult>`
### `doUpsert(Sobject record)` → `List<Database.UpsertResult>`
### `guardAgainstRemovedFields(System.AccessType accessType,List<SObject> records)` → `SObjectAccessDecision`
### `throwIfRemovedFields()` → `Safely`
---
## Inner Classes

### Safely.RemovedFieldsException class
---
