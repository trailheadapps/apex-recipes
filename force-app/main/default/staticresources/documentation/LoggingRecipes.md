# LoggingRecipes Class

Demonstrates how to use the logger in DataWeave scripts in Apex.

**Group** DataWeaveInApex Recipes

## Methods
### `logWithDataWeaveScript(jsonInput)`

Filters &#x27;winner&#x27; items from a list and log the filtered items 
Uses the `dw/logFilter.dwl` DataWeave script.

#### Signature
```apex
public static String logWithDataWeaveScript(String jsonInput)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| jsonInput | String | JSON string |

#### Return Type
**String**

JSON string