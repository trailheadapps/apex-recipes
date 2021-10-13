---
layout: default
---
# SOSLRecipes class

Demonstrates how to use SOSL. SOSL is used for full text, and fuzzier text searching. More on the difference between SOQL and SOSL: https://sfdc.co/soql-sosl

---
## Methods
### `basicSOSLSearch()` → `List<List<SObject>>`

Demonstrates the syntax for a SOSL search. Note: SOSL Cannot be unit tested directly - you must use Test.setFixedSearchResults() See SOSLRecipes_Tests.cls for more information

#### Return

**Type**

List&lt;List&lt;SObject&gt;&gt;

**Description**

List&lt;List&lt;SObject&gt;&gt;

#### Example
```java
System.debug(SOSLRecipes.basicSOSLSearch());
```

### `nameFieldSearch()` → `List<List<SObject>>`

Demonstrates how to write a SOSL query that searches only name fields

#### Return

**Type**

List&lt;List&lt;SObject&gt;&gt;

**Description**

List&lt;List&lt;SObject&gt;&gt;

#### Example
```java
System.debug(SOSLRecipes.nameFieldSearch());
```

---
