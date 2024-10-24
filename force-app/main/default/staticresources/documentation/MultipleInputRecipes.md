# MultipleInputRecipes

Demonstrates how use multiple input parameters in a DataWeave script in Apex.


**Group** DataWeaveInApex Recipes

## Methods
### `public static String runScriptWithMultipleInputs(String products, String attributes, String exchangeRates)`

Converts the information of a shopping basket into another currency.
Uses the `/dw/multipleInputs.dwl` DataWeave script.

#### Parameters

|Param|Description|
|---|---|
|`products`|list of products in the form of a JSON string|
|`attributes`|list of product attributes used as a filters in the form of a JSON string|
|`exchangeRates`|list of currency exchange rates in the form of a JSON string|

#### Returns

|Type|Description|
|---|---|
|`String`|script output as an XML string|

---
