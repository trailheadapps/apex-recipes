# SOSLRecipes Class

Demonstrates how to use SOSL. 
SOSL is used for full text, and fuzzier text searching. 
 
More on the difference between SOQL and SOSL: 
https://sfdc.co/soql-sosl

**Group** Data Recipes

## Methods
### `basicSOSLSearch()`

Demonstrates the syntax for a SOSL search. 
Note: SOSL Cannot be unit tested directly - you must use 
 `Test.setFixedSearchResults()` 
See SOSLRecipes_Tests.cls for more information

#### Signature
```apex
public static List<List<SObject>> basicSOSLSearch()
```

#### Return Type
**List&lt;List&lt;SObject&gt;&gt;**

#### Example
```apex
System.debug(SOSLRecipes.basicSOSLSearch());
```

---

### `nameFieldSearch()`

Demonstrates how to write a SOSL query that searches only 
name fields

#### Signature
```apex
public static List<List<SObject>> nameFieldSearch()
```

#### Return Type
**List&lt;List&lt;SObject&gt;&gt;**

#### Example
```apex
System.debug(SOSLRecipes.nameFieldSearch());
```