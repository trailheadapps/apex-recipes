# CsvToJsonConversionRecipes

Demonstrates how to use DataWeave
in Apex to convert CSV to JSON.


**Group** DataWeaveInApex Recipes

## Methods
### `public static String convertCsvToJson(String csvPayload)`

Converts CSV to JSON.
Uses the `dw/csvToJsonBasic.dwl` DataWeave script.

#### Parameters

|Param|Description|
|---|---|
|`csvPayload`|CSV data to convert to JSON|

#### Returns

|Type|Description|
|---|---|
|`String`|JSON string|

### `public static String convertCsvToJsonWithFieldRenaming(String csvPayload)`

Converts CSV to JSON while renaming object fields.
Uses the `dw/csvToJsonWithFieldRenaming.dwl` DataWeave script.

#### Parameters

|Param|Description|
|---|---|
|`csvPayload`|CSV data to convert to JSON|

#### Returns

|Type|Description|
|---|---|
|`String`|JSON string|

### `public static String convertCsvWithCustomSeparatorToJson(String csvPayload)`

Converts CSV to JSON with a custom `;` CSV separator.
Uses the `dw/csvSeparatorToJson.dwl` DataWeave script.
Notice that the script input MIME type specifies `separator=';'`.

#### Parameters

|Param|Description|
|---|---|
|`csvPayload`|CSV data to convert to JSON|

#### Returns

|Type|Description|
|---|---|
|`String`|JSON string|

---
