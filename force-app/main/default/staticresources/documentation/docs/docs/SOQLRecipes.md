---
layout: default
---
# SOQLRecipes class

Demonstrates how to make various types of SOQL calls including multi-object queries, and aggregate queries

## Related

[CanTheUser](https://github.com/trailheadapps/apex-recipes/wiki/CanTheUser.md)

---
## Methods
### `getAccountRecordsInState(String state)` → `List<Account>`

Demonstrates how to use a bound variable in a WHERE clause

#### Parameters
|Param|Description|
|-----|-----------|
|`state` |  String representing a US State code (AK, KS, etc.) |

#### Example
```java
System.debug(SOQLRecipes.getAccountRecordsInState('ks'));
```

### `getDetailsFromBothParentRecords()` → `List<Junction__c>`

Demonstrates how to write a query that pulls information from two parent objects through a junction object

#### Example
```java
System.debug(SOQLRecipes.getDetailsFromBothParentRecords());
```

### `getFirstXRecords(Integer wantedNumberOfRows)` → `List<Account>`

Demonstrates how to use a bound variable to define the LIMIT

#### Parameters
|Param|Description|
|-----|-----------|
|`wantedNumberOfRows` |  the number of rows desired |

#### Example
```java
System.debug(SOQLRecipes.getFirstXRecords(5));
```

### `getLargeNumberOfRecords()` → `Integer`

Demonstrates how to loop over a SOQL query

#### Example
```java
System.debug(SOQLRecipes.getLargeNumberOfRecords());
```

### `getParentRecordDetailsFromChildRecord()` → `List<Contact>`

Demonstrates how to query fields from a parent object through the relationship field

#### Example
```java
System.debug(SOQLRecipes.getParentRecordDetailsFromChildRecord());
```

### `getRecords()` → `List<Account>`

Demonstrates the proper way to query accounts with SOQL keeping FLS and CRUD in account.

#### Example
```java
List<Account> results = SOQLRecipes.querySingleObject();
System.debug(results);
```

### `getRecordsByFieldValue()` → `List<Account>`

Demonstrates how to use a WHERE clause in a SOQL query

#### Example
```java
System.debug(SOQLRecipes.getRecordsByFieldValue());
```

### `getRecordsByMultipleFieldValues()` → `List<Account>`

Demonstrates how to use a complex WHERE clause in a SOQL query

#### Example
```java
System.debug(SOQLRecipes.getRecordsByMultipleFieldValues());
```

### `getRecordsWithRelatedRecords()` → `List<Account>`

Demonstrates how to query an object, as well as it's related child objects

#### Example
```java
System.debug(SOQLRecipes.getRecordsWithRelatedRecords());
```

### `getSecond10AccountRecords()` → `List<Account>`

Demonstrates how to get a limited number of results with a given offset; Ie: get the second set of 10 records.

#### Example
```java
System.debug('SOQLRecipes.getSecond10AccountRecords()');
```

### `getSpecificNumberOfRecords()` → `List<Account>`

Demonstrates how to use the LIMIT clause in a SOQL statement

#### Example
```java
System.debug(SOQLRecipes.getSpecificNumberOfRecords());
```

### `getSumOfOpportunityRecords(Id accountId)` → `Double`

demonstrates how to use aggregate methods, like Sum() or Count() in a SOQL query. This example generates the sum of opportunities associated with a specified Account

#### Parameters
|Param|Description|
|-----|-----------|
|`accountId` |  an AccountId |

#### Example
```java
Id accountId = [SELECT id FROM Account LIMIT 1].Id;
System.debug(SOQLRecipes.getSumOfOpportunityRecords(accountId));
```

---
