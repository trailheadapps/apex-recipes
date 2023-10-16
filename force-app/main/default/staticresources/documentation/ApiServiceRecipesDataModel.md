# ApiServiceRecipesDataModel

This class contains the 'data transfer object' details.
Data transfer objects are used to serialize Apex objects to JSON and
web service response JSON to Apex objects.


**Group** Integration Recipes


**See** [ApiServiceRecipes](https://github.com/trailheadapps/apex-recipes/wiki/ApiServiceRecipes)

## Fields

### `public exampleArray` → `List<Integer>`


These properties represent the JSON keys that we need to send or recieve.

### `public exampleBoolean` → `Boolean`


### `public exampleColor` → `String`


### `public exampleCouldBeNull` → `String`


### `public exampleNumber` → `Integer`


### `public exampleObject` → `ExampleObject`


### `public exampleString` → `String`


---
## Methods
### `public static List<ApiServiceRecipesDataModel> parse(String json)`

Parses the provided JSON string into a list of ApiServiceRecipesDataModel objects

#### Parameters

|Param|Description|
|---|---|
|`json`|Incoming JSON string. Often from an api call's results.|

#### Returns

|Type|Description|
|---|---|
|`List<ApiServiceRecipesDataModel>`|`List<ApiServiceRecipesDataModel>`|

#### Example
```apex
System.debug(ApiServiceRecipesDataModel.parse(ApiServiceRecipesDataModel_Tests.testJSON));
```


---
## Classes
### ExampleObject

example of how to model a nested json object

#### Fields

##### `public a` → `String`


##### `public c` → `String`


---

---
