# ObjectConversionRecipes

Demonstrates how to convert data in CSV or JSON format
into Salesforce sObjects and Apex objects using DataWeave scripts in Apex.
Notice that all script output MIME types are set to `application/apex`.


**Group** DataWeaveInApex Recipes

## Methods
### `public static List<Contact> convertCsvToContacts(String inputCsv)`

Converts CSV data into a list of contact records.
Uses the `/dw/csvToContacts.dwl` DataWeave script.

#### Parameters

|Param|Description|
|---|---|
|`inputCsv`|CSV data to tranform|

#### Returns

|Type|Description|
|---|---|
|`List<Contact>`|List of contact records|

### `public static List<Contact> convertJsonToContacts(String inputJson)`

Converts JSON data into a list of contact records.
Uses the `/dw/jsonToContacts.dwl` DataWeave script.

#### Parameters

|Param|Description|
|---|---|
|`inputJson`|JSON data to tranform|

#### Returns

|Type|Description|
|---|---|
|`List<Contact>`|List of contact records|

### `public static List<CsvData> convertCsvToApexObject(String inputCsv)`

Converts CSV data into a list of Apex objects.
Uses the `/dw/csvToApexObject.dwl` DataWeave script.

#### Parameters

|Param|Description|
|---|---|
|`inputCsv`|CSV data to tranform|

#### Returns

|Type|Description|
|---|---|
|`List<CsvData>`|List of Apex `CsvData` objects|

---
