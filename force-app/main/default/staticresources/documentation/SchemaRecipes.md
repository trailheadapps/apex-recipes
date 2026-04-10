# SchemaRecipes Class

Responsible for showing how to use schema and schema tokens

**Group** Schema Recipes

## Methods
### `schemaTokenRecipe()`

demonstrates how to use a field token for schema access

#### Signature
```apex
public void schemaTokenRecipe()
```

#### Return Type
**void**

---

### `getFieldsForObject(objectName)`

Demonstrates how to get all field names for a given object

#### Signature
```apex
public static List<String> getFieldsForObject(String objectName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objectName | String | The API name of the SObject (e.g. &#x27;Account&#x27;) |

#### Return Type
**List<String>**

List of field API names

#### Example
List&lt;String&gt; fields &#x3D; SchemaRecipes.getFieldsForObject(&#x27;Account&#x27;);

---

### `getPicklistValues(objectName, fieldName)`

Demonstrates how to get picklist values for a field

#### Signature
```apex
public static List<String> getPicklistValues(String objectName, String fieldName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objectName | String | The API name of the SObject (e.g. &#x27;Account&#x27;) |
| fieldName | String | The API name of the picklist field (e.g. &#x27;Industry&#x27;) |

#### Return Type
**List<String>**

List of picklist values

#### Example
List&lt;String&gt; values &#x3D; SchemaRecipes.getPicklistValues(&#x27;Account&#x27;, &#x27;Industry&#x27;);

---

### `doesObjectExist(objectName)`

Demonstrates how to check if an SObject exists in the org

#### Signature
```apex
public static Boolean doesObjectExist(String objectName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objectName | String | The API name of the SObject to check |

#### Return Type
**Boolean**

true if the object exists, false otherwise

#### Example
Boolean exists &#x3D; SchemaRecipes.doesObjectExist(&#x27;Account&#x27;);