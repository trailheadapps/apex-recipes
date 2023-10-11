# TransformSobjectsInDataWeave

Demonstrates how to transform data in CSV/JSON file format
to Salesforce Sobjects using a DataWeave script in Apex.
For more DataWeave for Apex example head to https://github.com/developerforce/DataWeaveInApex


**Group** DataWeaveInApex Recipes

## Methods
### `public static List<Contact> convertCsvToContacts(String inputCsv)`

Demonstrates how to transform data in CSV format to the Salesforce contact records using a DataWeave script in Apex. The class uses the `/dw/csvToContacts.dwl` script to convert CSV to list of contact records.Notice that in the `csvToContacts.dwl` the output MIME type is `application/apex`

#### Parameters

|Param|Description|
|---|---|
|`inputCsv`|CSV data to tranform to Salesforce contact records|

#### Returns

|Type|Description|
|---|---|
|`List<Contact>`|List of contact records|

### `public static List<Contact> convertJsonToContacts(String inputJson)`

Demonstrates how to transform data in JSON format to Salesforce contact records using a DataWeave script in Apex. The class uses the `/dw/jsonToContacts.dwl` script to convert JSON string to a list of Salesforce contact records.Notice that in the `jsonToContacts.dwl` the output MIME type is `application/apex`

#### Parameters

|Param|Description|
|---|---|
|`inputJson`|JSON data to tranform to Salesforce contact records|

#### Returns

|Type|Description|
|---|---|
|`List<Contact>`|List of contact records|

---
