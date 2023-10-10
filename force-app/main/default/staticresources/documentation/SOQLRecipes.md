# SOQLRecipes

Demonstrates how to make various types of SOQL calls
including multi-object queries, and aggregate queries


**Group** Data Recipes

## Methods
### `public static List<Account> getRecords()`

Demonstrates the proper way to query accounts with SOQL   keeping FLS and CRUD in account.

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|list<Account>|

#### Example
```apex
List<Account> results = SOQLRecipes.querySingleObject();
System.debug(results);
```


### `public static Integer getLargeNumberOfRecords()`

Demonstrates how to loop over a SOQL query

#### Returns

|Type|Description|
|---|---|
|`Integer`|integer|

#### Example
```apex
System.debug(SOQLRecipes.getLargeNumberOfRecords());
```


### `public static Integer getChunksOfLargeNumbersOfRecords()`

One of the little known features of SOQL for loops is that you can iterate not only over each record returned by the query, but also over each *chunk of records*. As the code below demonstrates, specifying the iteration variable as a list/array will return 200 record chunks from the query, rather than individual records. Note: Normally, if you're only dealing with counts of records, you'd utilize the Count() soql method, but in this case we're demonstrating that this form of a soql for loop gives you access both to a list of records, and to the records themselves.

#### Returns

|Type|Description|
|---|---|
|`Integer`|`Integer`|

### `public static List<Account> getRecordsByFieldValue()`

Demonstrates how to use a WHERE clause in a SOQL query

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List<Account>|

#### Example
```apex
System.debug(SOQLRecipes.getRecordsByFieldValue());
```


### `public static List<Account> getRecordsByMultipleFieldValues()`

Demonstrates how to use a complex WHERE clause in a SOQL query

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List<Account>|

#### Example
```apex
System.debug(SOQLRecipes.getRecordsByMultipleFieldValues());
```


### `public static List<Account> getSpecificNumberOfRecords()`

Demonstrates how to use the LIMIT clause in a SOQL statement

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List<Account>|

#### Example
```apex
System.debug(SOQLRecipes.getSpecificNumberOfRecords());
```


### `public static List<Account> getFirstXRecords(Integer wantedNumberOfRows)`

Demonstrates how to use a bound variable to define the LIMIT

#### Parameters

|Param|Description|
|---|---|
|`wantedNumberOfRows`|the number of rows desired|

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List<Account>|

#### Example
```apex
System.debug(SOQLRecipes.getFirstXRecords(5));
```


### `public static List<Account> getAccountRecordsInState(String state)`

Demonstrates how to use a bound variable in a WHERE clause

#### Parameters

|Param|Description|
|---|---|
|`state`|String representing a US State code (AK, KS, etc.)|

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List<Account>|

#### Example
```apex
System.debug(SOQLRecipes.getAccountRecordsInState('ks'));
```


### `public static List<Account> getSecond10AccountRecords()`

Demonstrates how to get a limited number of results with a given offset; Ie: get the second set of 10 records.

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List<Account>|

#### Example
```apex
System.debug('SOQLRecipes.getSecond10AccountRecords()');
```


### `public static List<Account> getRecordsWithRelatedRecords()`

Demonstrates how to query an object, as well as it's related child objects

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List<Account>|

#### Example
```apex
System.debug(SOQLRecipes.getRecordsWithRelatedRecords());
```


### `public static List<Contact> getParentRecordDetailsFromChildRecord()`

Demonstrates how to query fields from a parent object through the relationship field

#### Returns

|Type|Description|
|---|---|
|`List<Contact>`|List<Contact>|

#### Example
```apex
System.debug(SOQLRecipes.getParentRecordDetailsFromChildRecord());
```


### `public static List<Junction__c> getDetailsFromBothParentRecords()`

Demonstrates how to write a query that pulls information from two parent objects through a junction object

#### Returns

|Type|Description|
|---|---|
|`List<Junction__c>`|List<Junction__c>|

#### Example
```apex
System.debug(SOQLRecipes.getDetailsFromBothParentRecords());
```


### `public static Double getSumOfOpportunityRecords(Id accountId)`

demonstrates how to use aggregate methods, like Sum() or Count() in a SOQL query. This example generates the sum of opportunities associated with a specified Account

#### Parameters

|Param|Description|
|---|---|
|`accountId`|an AccountId|

#### Returns

|Type|Description|
|---|---|
|`Double`|Double|

#### Example
```apex
Id accountId = [SELECT Id FROM Account LIMIT 1].Id;
System.debug(SOQLRecipes.getSumOfOpportunityRecords(accountId));
```


---
