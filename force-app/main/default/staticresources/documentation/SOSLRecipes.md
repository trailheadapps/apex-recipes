# SOSLRecipes

Demonstrates how to use SOSL.
SOSL is used for full text, and fuzzier text searching.
More on the difference between SOQL and SOSL:
https://sfdc.co/soql-sosl


**Group** Data Recipes

## Methods
### `public static List<List<SObject>> basicSOSLSearch()`

Demonstrates the syntax for a SOSL search.  Note: SOSL Cannot be unit tested directly - you must use Test.setFixedSearchResults()  See SOSLRecipes_Tests.cls for more information

#### Returns

|Type|Description|
|---|---|
|`List<List<SObject>>`|List<List<SObject>>|

#### Example
```apex
System.debug(SOSLRecipes.basicSOSLSearch());
```


### `public static List<List<SObject>> nameFieldSearch()`

Demonstrates how to write a SOSL query that searches only name fields

#### Returns

|Type|Description|
|---|---|
|`List<List<SObject>>`|List<List<SObject>>|

#### Example
```apex
System.debug(SOSLRecipes.nameFieldSearch());
```


---
