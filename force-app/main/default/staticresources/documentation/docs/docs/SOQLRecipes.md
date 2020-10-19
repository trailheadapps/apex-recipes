---
layout: default
---
# SOQLRecipes class

Demonstrates how to make various types of SOQL calls including multi-object queries, and aggregate queries

## Related

[CanTheUser](https://github.com/trailheadapps/apex-recipes/wiki/CanTheUser.md)

---
## Methods
### `getAccountsInState(String state)` → `List<Account>`

Demonstrates how to use a bound variable in a WHERE clause

#### Parameters
|Param|Description|
|-----|-----------|
|`state` |  String representing a US State code (AK, KS, etc.) |

#### Example
```java
System.debug(SOQLRecipes.getAccountsInState('ks'));
```

### `getComplexFilteredList()` → `List<Account>`

Demonstrates how to use a complex WHERE clause in a SOQL query Note: This method has a false-positive PMD warning. Our query includes the keyword 'WITH SECURITY_ENFORCED' which prevents this query from accessing fields and objects that they don't have permission to access. This is a form of inline CRUD/FLS Check.

#### Example
```java
System.debug(SOQLRecipes.getComplexFilteredList());
```

### `getContactsAndAccounts()` → `List<Account>`

Demonstrates how to query an object, as well as it's related child objects Note: This method has a false-positive PMD warning. Our query includes the keyword 'WITH SECURITY_ENFORCED' which prevents this query from accessing fields and objects that they don't have permission to access. This is a form of inline CRUD/FLS Check.

#### Example
```java
System.debug(SOQLRecipes.getContactsAndAccounts());
```

### `getDetailsFromBothParents()` → `List<Junction__c>`

Demonstrates how to write a query that pulls information from two parent objects through a junction object Note: This method has a false-positive PMD warning. Our query includes the keyword 'WITH SECURITY_ENFORCED' which prevents this query from accessing fields and objects that they don't have permission to access. This is a form of inline CRUD/FLS Check.

#### Example
```java
System.debug(SOQLRecipes.getDetailsFromBothParents());
```

### `getFilteredList()` → `List<Account>`

Demonstrates how to use a WHERE clause in a SOQL query Note: This method has a false-positive PMD warning. Our query includes the keyword 'WITH SECURITY_ENFORCED' which prevents this query from accessing fields and objects that they don't have permission to access. This is a form of inline CRUD/FLS Check.

#### Example
```java
System.debug(SOQLRecipes.getFilteredList());
```

### `getFirstXResults(Integer wantedNumberOfRows)` → `List<Account>`

Demonstrates how to use a bound variable to define the LIMIT

#### Parameters
|Param|Description|
|-----|-----------|
|`wantedNumberOfRows` |  the number of rows desired |

#### Example
```java
System.debug(SOQLRecipes.getFirstXResults(5));
```

### `getParentDetailsForChild()` → `List<Contact>`

Demonstrates how to query fields from a parent object through the relationship field Note: This method has a false-positive PMD warning. Our query includes the keyword 'WITH SECURITY_ENFORCED' which prevents this query from accessing fields and objects that they don't have permission to access. This is a form of inline CRUD/FLS Check.

#### Example
```java
System.debug(SOQLRecipes.getParentDetailsForChild());
```

### `getSecond10Accounts()` → `List<Account>`

Demonstrates how to get a limited number of results with a given offset; Ie: get the second set of 10 records. Note: This method has a false-positive PMD warning. Our query includes the keyword 'WITH SECURITY_ENFORCED' which prevents this query from accessing fields and objects that they don't have permission to access. This is a form of inline CRUD/FLS Check.

#### Example
```java
System.debug('SOQLRecipes.getSecond10Accounts()');
```

### `getSpecificNumberOfResults()` → `List<Account>`

Demonstrates how to use the LIMIT clause in a SOQL statement Note: This method has a false-positive PMD warning. Our query includes the keyword 'WITH SECURITY_ENFORCED' which prevents this query from accessing fields and objects that they don't have permission to access. This is a form of inline CRUD/FLS Check.

#### Example
```java
System.debug(SOQLRecipes.getSpecificNumberOfResults());
```

### `getSumOfOpportunities(Id accountId)` → `Double`

demonstrates how to use aggregate methods, like Sum() or Count() in a SOQL query. This example generates the sum of opportunities associated with a specified Account Note: This method has a false-positive PMD warning. Our query includes the keyword 'WITH SECURITY_ENFORCED' which prevents this query from accessing fields and objects that they don't have permission to access. This is a form of inline CRUD/FLS Check.

#### Parameters
|Param|Description|
|-----|-----------|
|`accountId` |  an AccountId |

#### Example
```java
Id accountId = [SELECT id FROM Account LIMIT 1].Id;
System.debug(SOQLRecipes.getSumOfOpportunities(accountId));
```

### `queryMassiveNumberOfRecordsReturningCount()` → `integer`

Demonstrates how to loop over a SOQL query Note: This method has a false-positive PMD warning. Our query includes the keyword 'WITH SECURITY_ENFORCED' which prevents this query from accessing fields and objects that they don't have permission to access. This is a form of inline CRUD/FLS Check.

#### Example
```java
System.debug(SOQLRecipes.queryMassiveNumberOfRecordsReturningCount());
```

### `querySingleObject()` → `list<Account>`

Demonstrates the proper way to query accounts with SOQL keeping FLS and CRUD in account. Note: This method has a false-positive PMD warning. PMD isn't aware of what WITH SECURITY_ENFORCED does, so it falsely thinks this code doesn't respect FLS/CRUD.

#### Example
```java
List<Account> results = SOQLRecipes.querySingleObject();
System.debug(results);
```

---
