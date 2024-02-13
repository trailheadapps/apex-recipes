# FormattingRecipes

Demonstrates various ways to apply formatting using DataWeave scripts in Apex.


**Group** DataWeaveInApex Recipes

## Methods
### `public static String formatDateInJson(List<Contact> contacts)`

Outputs a list of contacts in JSON with properly formatted dates. Uses the `dw/jsonDateFormat.dwl` DataWeave script.

#### Parameters

|Param|Description|
|---|---|
|`contacts`|list of contacts to convert into JSON|

#### Returns

|Type|Description|
|---|---|
|`String`|JSON string|

### `public static String pluralize(String singularWords)`

Uses the DataWeave `pluralize` function in a script (https://docs.mulesoft.com/dataweave/2.4/dw-strings-functions-pluralize). Uses the `dw/pluralizeFunction.dwl` DataWeave script.

#### Parameters

|Param|Description|
|---|---|
|`singularWords`|list of singular words as a JSON string|

#### Returns

|Type|Description|
|---|---|
|`String`|list of plural words as a JSON string|

### `public static String escapeApexReservedKeywords(String jsonInput)`

Parses a JSON input and escape properties named after Apex reserved keywords (private, object, currency...). Full list of reserved keywords: https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_reserved_words.htm Uses the `dw/reservedApexKeywords.dwl` DataWeave script.

#### Parameters

|Param|Description|
|---|---|
|`jsonInput`|JSON string with Apex reserved keywords used as properties|

#### Returns

|Type|Description|
|---|---|
|`String`|JSON string without the Apex reserved keywords|

---
