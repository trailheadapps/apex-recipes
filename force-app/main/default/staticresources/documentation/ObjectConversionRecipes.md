# ObjectConversionRecipes Class

Demonstrates how to convert data in CSV or JSON format 
into Salesforce sObjects and Apex objects using DataWeave scripts in Apex. 
Notice that all script output MIME types are set to `application/apex` .

**Group** DataWeaveInApex Recipes

## Methods
### `convertCsvToContacts(inputCsv)`

Converts CSV data into a list of contact records. 
Uses the `/dw/csvToContacts.dwl` DataWeave script.

#### Signature
```apex
public static List<Contact> convertCsvToContacts(String inputCsv)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| inputCsv | String | CSV data to tranform |

#### Return Type
**List&lt;Contact&gt;**

List of contact records

---

### `convertJsonToContacts(inputJson)`

Converts JSON data into a list of contact records. 
Uses the `/dw/jsonToContacts.dwl` DataWeave script.

#### Signature
```apex
public static List<Contact> convertJsonToContacts(String inputJson)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| inputJson | String | JSON data to tranform |

#### Return Type
**List&lt;Contact&gt;**

List of contact records

---

### `convertCsvToApexObject(inputCsv)`

Converts CSV data into a list of Apex objects. 
Uses the `/dw/csvToApexObject.dwl` DataWeave script.

#### Signature
```apex
public static List<CsvData> convertCsvToApexObject(String inputCsv)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| inputCsv | String | CSV data to tranform |

#### Return Type
**List&lt;CsvData&gt;**

List of Apex ,[object Object], objects