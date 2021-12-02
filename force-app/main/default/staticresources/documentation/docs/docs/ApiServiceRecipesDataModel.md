---
layout: default
---
# ApiServiceRecipesDataModel class

This class contains the &apos;data transfer object&apos; details. Data transfer objects are used to serialize Apex objects to JSON and web service response JSON to Apex objects.

## Related

[ApiServiceRecipes](https://github.com/trailheadapps/apex-recipes/wiki/ApiServiceRecipes.md)

---
## Properties

### `exampleArray` → `List<Integer>`

 These properties represent the JSON keys that we need to send or recieve.

### `exampleBoolean` → `Boolean`

### `exampleColor` → `String`

### `exampleCouldBeNull` → `String`

### `exampleNumber` → `Integer`

### `exampleObject` → `ExampleObject`

### `exampleString` → `String`

---
## Methods
### `parse(String json)` → `List<ApiServiceRecipesDataModel>`

Parses the provided JSON string into a list of ApiServiceRecipesDataModel objects

#### Parameters

| Param | Description |
| ----- | ----------- |
|`json` |   Incoming JSON string. Often from an api call&apos;s results. |

#### Return

**Type**

List&lt;ApiServiceRecipesDataModel&gt;

**Description**

`List&lt;ApiServiceRecipesDataModel&gt;`

#### Example
```java
System.debug(ApiServiceRecipesDataModel.parse(ApiServiceRecipesDataModel_Tests.testJSON));
```

---
## Inner Classes

### ApiServiceRecipesDataModel.ExampleObject class

example of how to model a nested json object

---
#### Properties

##### `a` → `String`

##### `c` → `publi`

---
