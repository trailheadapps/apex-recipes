# MultipleInputRecipes Class

Demonstrates how use multiple input parameters in a DataWeave script in Apex.

**Group** DataWeaveInApex Recipes

## Methods
### `runScriptWithMultipleInputs(products, attributes, exchangeRates)`

Converts the information of a shopping basket into another currency. 
Uses the `/dw/multipleInputs.dwl` DataWeave script.

#### Signature
```apex
public static String runScriptWithMultipleInputs(String products, String attributes, String exchangeRates)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| products | String | list of products in the form of a JSON string |
| attributes | String | list of product attributes used as a filters in the form of a JSON string |
| exchangeRates | String | list of currency exchange rates in the form of a JSON string |

#### Return Type
**String**

script output as an XML string