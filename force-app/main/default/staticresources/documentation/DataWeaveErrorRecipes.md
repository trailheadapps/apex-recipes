# DataWeaveErrorRecipes Class

Demonstrates how to handle DataWeave script errors in Apex.

**Group** DataWeaveInApex Recipes

## Methods
### `runtimeError()`

Runs a DataWeave script that triggers a runtime error on pupose. 
Uses the `dw/error.dwl` DataWeave script.

#### Signature
```apex
public static void runtimeError()
```

#### Return Type
**void**

---

### `convertContactsToExcel(contacts)`

Attempts to output records as Excel. 
This always results in an error as the Excel format is not supported in DataWeave in Apex. 
Uses the `dw/excelOutputError.dwl` DataWeave script.

#### Signature
```apex
public static DataWeave.Result convertContactsToExcel(List<Contact> contacts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| contacts | List&lt;Contact&gt; | list of contacts |

#### Return Type
**DataWeave.Result**

DataWeave script result (never used as a ,[object Object], is thrown)