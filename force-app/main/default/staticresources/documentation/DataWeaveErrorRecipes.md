# DataWeaveErrorRecipes

Demonstrates how to handle DataWeave script errors in Apex.


**Group** DataWeaveInApex Recipes

## Methods
### `public static void runtimeError()`

Runs a DataWeave script that triggers a runtime error on pupose. Uses the `dw/error.dwl` DataWeave script.

### `public static DataWeave convertContactsToExcel(List<Contact> contacts)`

Attempts to output records as Excel. This always results in an error as the Excel format is not supported in DataWeave in Apex. Uses the `dw/excelOutputError.dwl` DataWeave script.

#### Parameters

|Param|Description|
|---|---|
|`contacts`|list of contacts|

#### Returns

|Type|Description|
|---|---|
|`DataWeave`|DataWeave script result (never used as a `DataWeaveScriptException` is thrown)|

---
