---
layout: default
---
# ApiServiceRecipes class

This recipe extends the custom RestClient class and represents a specific API service we need to interact with - in this case a MockBin REST service. This APIService class is responsible for serializing and deserializing the Data Transfer Objects (Model Objects) necessary for input and output from this org to the third party system and back. More on MockBin here: http://mockbin.org/

## Related

RestClient, ApiServiceRecipesDataModel

---
## Constructors
### `ApiServiceRecipes()`

default constructor. Sets the inherited named credential to the DEFAULTNAMEDCREDENTIAL constant above. Setting the namedCredentialName binds all the methods in this class to the specific namedCredential URL and auth.
---
## Properties

### `DEFAULTNAMEDCREDENTIAL` → `String`

### `GETBINPATH` → `String`

---
## Methods
### `getCurrentData()` → `List<ApiServiceRecipesDataModel>`

Encapsulates a specific callout to the Named Credential URL that returns JSON into an method that transforms the raw JSON into an Apex Object.

#### Return

**Type**

List&lt;ApiServiceRecipesDataModel&gt;

**Description**

`List&lt;ApiServiceRecipesDataModel&gt;`

#### Example
```java
ApiServiceRecipes asr = new ApiServiceRecipes();
System.debug(asr.getCurrentData());
```

---
## Inner Classes

### ApiServiceRecipes.ApiException class

Internal custom exception used by this class for errors

---
