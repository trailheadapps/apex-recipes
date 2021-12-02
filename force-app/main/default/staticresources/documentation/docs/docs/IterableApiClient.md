---
layout: default
---
# IterableApiClient class

Demonstrates an interable REST API client that loads paginated records (strings) thanks to an iterator

---
## Constructors
### `IterableApiClient(String namedCredential)`

Constructor accepting a named credential.
#### Parameters

| Param | Description |
| ----- | ----------- |
|`namedCredential` |  name of the Named Credential to use |

---
## Properties

### `RESPONSE_PAGE_SIZE` → `Integer`

---
## Methods
### `getRecordPage(Integer pageIndex)` → `RecordPage`

Internal method that issues a REST request to read a record page

#### Return

**Type**

RecordPage

**Description**

RecordPage a page with a list of records

### `iterator()` → `Iterator<RecordPage>`

Returns an iterator on RecordPage (as required by the Iterable interface)

---
## Inner Classes

### IterableApiClient.IterableApiException class

Public custom exception class

---
### IterableApiClient.RecordPage class

Public class used for JSON deserialization of record page response

---
#### Properties

##### `records` → `List<String>`

##### `totalRecordCount` → `Integer`

---
#### Methods
##### `getRecords()` → `List<String>`
---
### IterableApiClient.RecordPageIterator class

Custom Iterator used to navigate IterableApiClient responses as RecordPage. The iterator keeps track on the iteration state with currentPageIndex and totalRecordCount. It uses IterableApiClient to perform REST requests to load the record pages.

---
#### Constructors
##### `RecordPageIterator(IterableApiClient client)`
---
#### Properties

##### `client` → `IterableApiClient`

##### `currentPageIndex` → `Integer`

##### `totalRecordCount` → `Integer`

---
#### Methods
##### `hasNext()` → `Boolean`
##### `next()` → `RecordPage`
---
