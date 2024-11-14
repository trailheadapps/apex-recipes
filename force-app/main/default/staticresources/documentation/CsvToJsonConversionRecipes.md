# CsvToJsonConversionRecipes Class

Demonstrates how to use DataWeave 
in Apex to convert CSV to JSON.

**Group** DataWeaveInApex Recipes

## Methods
### `convertCsvToJson(csvPayload)`

Converts CSV to JSON. 
Uses the `dw/csvToJsonBasic.dwl` DataWeave script.

#### Signature
```apex
public static String convertCsvToJson(String csvPayload)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| csvPayload | String | CSV data to convert to JSON |

#### Return Type
**String**

JSON string

---

### `convertCsvToJsonWithFieldRenaming(csvPayload)`

Converts CSV to JSON while renaming object fields. 
Uses the `dw/csvToJsonWithFieldRenaming.dwl` DataWeave script.

#### Signature
```apex
public static String convertCsvToJsonWithFieldRenaming(String csvPayload)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| csvPayload | String | CSV data to convert to JSON |

#### Return Type
**String**

JSON string

---

### `convertCsvWithCustomSeparatorToJson(csvPayload)`

Converts CSV to JSON with a custom `;` CSV separator. 
Uses the `dw/csvSeparatorToJson.dwl` DataWeave script. 
Notice that the script input MIME type specifies `separator=';'` .

#### Signature
```apex
public static String convertCsvWithCustomSeparatorToJson(String csvPayload)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| csvPayload | String | CSV data to convert to JSON |

#### Return Type
**String**

JSON string