# SOQLRecipes Class

Demonstrates how to make various types of SOQL calls 
including multi-object queries, and aggregate queries

**Group** Data Recipes

## Methods
### `getRecords()`

Demonstrates the proper way to query accounts with SOQL 
keeping FLS and CRUD in account.

#### Signature
```apex
public static List<Account> getRecords()
```

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
List<Account> results = SOQLRecipes.querySingleObject();
System.debug(results);
```

---

### `getLargeNumberOfRecords()`

Demonstrates how to loop over a SOQL query

#### Signature
```apex
public static Integer getLargeNumberOfRecords()
```

#### Return Type
**Integer**

#### Example
```apex
System.debug(SOQLRecipes.getLargeNumberOfRecords());
```

---

### `getChunksOfLargeNumbersOfRecords()`

One of the little known features of SOQL for loops is that 
you can iterate not only over each record returned by the query, but also 
over each *chunk of records*. As the code below demonstrates, specifying 
the iteration variable as a list/array will return 200 record chunks 
from the query, rather than individual records. 
 
Note: Normally, if you&#x27;re only dealing with counts of records, you&#x27;d 
utilize the Count() soql method, but in this case we&#x27;re demonstrating 
that this form of a soql for loop gives you access both to a list of 
records, and to the records themselves.

#### Signature
```apex
public static Integer getChunksOfLargeNumbersOfRecords()
```

#### Return Type
**Integer**

---

### `getRecordsByFieldValue()`

Demonstrates how to use a WHERE clause in a SOQL query

#### Signature
```apex
public static List<Account> getRecordsByFieldValue()
```

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
System.debug(SOQLRecipes.getRecordsByFieldValue());
```

---

### `getRecordsByMultipleFieldValues()`

Demonstrates how to use a complex WHERE clause in a SOQL 
query

#### Signature
```apex
public static List<Account> getRecordsByMultipleFieldValues()
```

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
System.debug(SOQLRecipes.getRecordsByMultipleFieldValues());
```

---

### `getSpecificNumberOfRecords()`

Demonstrates how to use the LIMIT clause in a SOQL statement

#### Signature
```apex
public static List<Account> getSpecificNumberOfRecords()
```

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
System.debug(SOQLRecipes.getSpecificNumberOfRecords());
```

---

### `getFirstXRecords(wantedNumberOfRows)`

Demonstrates how to use a bound variable to define the LIMIT

#### Signature
```apex
public static List<Account> getFirstXRecords(Integer wantedNumberOfRows)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| wantedNumberOfRows | Integer | the number of rows desired |

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
System.debug(SOQLRecipes.getFirstXRecords(5));
```

---

### `getAccountRecordsInState(state)`

Demonstrates how to use a bound variable in a WHERE clause

#### Signature
```apex
public static List<Account> getAccountRecordsInState(String state)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| state | String | String representing a US State code (AK, KS, etc.) |

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
System.debug(SOQLRecipes.getAccountRecordsInState('ks'));
```

---

### `getSecond10AccountRecords()`

Demonstrates how to get a limited number of results with a 
given offset; Ie: get the second set of 10 records.

#### Signature
```apex
public static List<Account> getSecond10AccountRecords()
```

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
System.debug(SOQLRecipes.getSecond10AccountRecords());
```

---

### `getRecordsWithRelatedRecords()`

Demonstrates how to query an object, as well as it&#x27;s related 
child objects

#### Signature
```apex
public static List<Account> getRecordsWithRelatedRecords()
```

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
System.debug(SOQLRecipes.getRecordsWithRelatedRecords());
```

---

### `getParentRecordDetailsFromChildRecord()`

Demonstrates how to query fields from a parent object 
through the relationship field

#### Signature
```apex
public static List<Contact> getParentRecordDetailsFromChildRecord()
```

#### Return Type
**List&lt;Contact&gt;**

#### Example
```apex
System.debug(SOQLRecipes.getParentRecordDetailsFromChildRecord());
```

---

### `getDetailsFromBothParentRecords()`

Demonstrates how to write a query that pulls information 
from two parent objects through a junction object

#### Signature
```apex
public static List<Junction__c> getDetailsFromBothParentRecords()
```

#### Return Type
**List&lt;Junction__c&gt;**

#### Example
```apex
System.debug(SOQLRecipes.getDetailsFromBothParentRecords());
```

---

### `getSumOfOpportunityRecords(accountId)`

demonstrates how to use aggregate methods, like Sum() or 
Count() in a SOQL query. This example generates the sum of opportunities 
associated with a specified Account

#### Signature
```apex
public static Double getSumOfOpportunityRecords(Id accountId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accountId | Id | an AccountId |

#### Return Type
**Double**

#### Example
```apex
Id accountId = [SELECT Id FROM Account LIMIT 1].Id;
System.debug(SOQLRecipes.getSumOfOpportunityRecords(accountId));
```