# FormattingRecipes Class

Demonstrates various ways to apply formatting using DataWeave scripts in Apex.

**Group** DataWeaveInApex Recipes

## Methods
### `formatDateInJson(contacts)`

Outputs a list of contacts in JSON with properly formatted dates. 
Uses the `dw/jsonDateFormat.dwl` DataWeave script.

#### Signature
```apex
public static String formatDateInJson(List<Contact> contacts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| contacts | List&lt;Contact&gt; | list of contacts to convert into JSON |

#### Return Type
**String**

JSON string

---

### `pluralize(singularWords)`

Uses the DataWeave `pluralize` function in a script (https://docs.mulesoft.com/dataweave/2.4/dw-strings-functions-pluralize). 
Uses the `dw/pluralizeFunction.dwl` DataWeave script.

#### Signature
```apex
public static String pluralize(String singularWords)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| singularWords | String | list of singular words as a JSON string |

#### Return Type
**String**

list of plural words as a JSON string

---

### `escapeApexReservedKeywords(jsonInput)`

Parses a JSON input and escape properties named after Apex reserved keywords (private, object, currency...). 
Full list of reserved keywords: https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_reserved_words.htm 
Uses the `dw/reservedApexKeywords.dwl` DataWeave script.

#### Signature
```apex
public static String escapeApexReservedKeywords(String jsonInput)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| jsonInput | String | JSON string with Apex reserved keywords used as properties |

#### Return Type
**String**

JSON string without the Apex reserved keywords