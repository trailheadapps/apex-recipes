# ApiServiceRecipesDataModel Class

This class contains the &#x27;data transfer object&#x27; details. 
Data transfer objects are used to serialize Apex objects to JSON and 
web service response JSON to Apex objects.

**Group** Integration Recipes

**See** [ApiServiceRecipes](ApiServiceRecipes.md)

## Fields
### `exampleArray`

These properties represent the JSON keys that we need 
to send or receive.

#### Signature
```apex
public exampleArray
```

#### Type
List&lt;Integer&gt;

---

### `exampleBoolean`

#### Signature
```apex
public exampleBoolean
```

#### Type
Boolean

---

### `exampleColor`

#### Signature
```apex
public exampleColor
```

#### Type
String

---

### `exampleCouldBeNull`

#### Signature
```apex
public exampleCouldBeNull
```

#### Type
String

---

### `exampleNumber`

#### Signature
```apex
public exampleNumber
```

#### Type
Integer

---

### `exampleObject`

#### Signature
```apex
public exampleObject
```

#### Type
ExampleObject

---

### `exampleString`

#### Signature
```apex
public exampleString
```

#### Type
String

## Methods
### `parse(json)`

Parses the provided JSON string into a list of 
ApiServiceRecipesDataModel objects

#### Signature
```apex
public static List<ApiServiceRecipesDataModel> parse(String json)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| json | String | Incoming JSON string. Often from an api call&#x27;s results. |

#### Return Type
**List&lt;ApiServiceRecipesDataModel&gt;**

#### Example
```apex
System.debug(ApiServiceRecipesDataModel.parse(ApiServiceRecipesDataModel_Tests.testJSON));
```

## Classes
### ExampleObject Class

example of how to model a nested JSON object

#### Fields
##### `a`

###### Signature
```apex
public a
```

###### Type
String

---

##### `c`

###### Signature
```apex
public c
```

###### Type
String