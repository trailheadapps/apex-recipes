# CsvToJsonConversion

Demonstrates how to use DataWeave scripts
in apex to convert CSV to JSON


**Group** DataWeaveInApex Recipes

## Methods
### `public static String convertCsvToJsonBasic(String csvPayload)`

Demonstrates how to use DataWeave script in Apex to convert a CSV to a JSON

#### Parameters

|Param|Description|
|---|---|
|`csvPayload`|CSV data to convert to JSON|

#### Returns

|Type|Description|
|---|---|
|`String`|JSON string|

### `public static List<Contact> convertCsvToJsonContacts(String data, System apexType)`

Demonstrates how to use DataWeave script in Apex to convert a CSV to list of Salesforce contact records

#### Parameters

|Param|Description|
|---|---|
|`data`|CSV data to convert to JSON and then to Salesforce contact records|
|`apexType`|Wrapper Apex class for deserializing JSON to Salesforce contact records|

#### Returns

|Type|Description|
|---|---|
|`List<Contact>`|List of contacts|

---
