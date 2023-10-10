# CsvToJsonConversion

Demonstrates how to use DataWeave
in Apex to convert CSV to JSON.For more DataWeave for Apex example
head to https://github.com/developerforce/DataWeaveInApex


**Group** DataWeaveInApex Recipes

## Methods
### `public static String convertCsvToJsonBasic(String csvPayload)`

Demonstrates how to use DataWeave in Apex to convert a CSV to a basic JSON. The class uses the `/dw/csvToJsonBasic.dwl` script to convert CSV to JSON

#### Parameters

|Param|Description|
|---|---|
|`csvPayload`|CSV data to convert to JSON|

#### Returns

|Type|Description|
|---|---|
|`String`|JSON string|

### `public static List<Contact> convertCsvToJsonContacts(String data)`

Demonstrates how to use DataWeave script in Apex to convert a CSV to first JSON and then deserialize it to a list of Salesforce contact records The class uses the `/dw/csvToJson.dwl` script to convert CSV to JSON

#### Parameters

|Param|Description|
|---|---|
|`data`|CSV data to convert to Salesforce contact records|

#### Returns

|Type|Description|
|---|---|
|`List<Contact>`|List of contacts|

---
