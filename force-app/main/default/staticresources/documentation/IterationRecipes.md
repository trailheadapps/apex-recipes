# IterationRecipes

Demonstrates how to iterate on lists and sets


**Group** Collection Recipes


**See** [IterableApiClient](https://github.com/trailheadapps/apex-recipes/wiki/IterableApiClient)

## Methods
### `public static Integer iterateOnAccountList(List<Account> accounts)`

Demonstrates how to iterate on a list of SObject thanks to the Iterable and Iterator interfaces. This example iterates on Accounts to sum the 'number of employees' field values (use the `SUM` SOQL function for a real-life application).

#### Parameters

|Param|Description|
|---|---|
|`accounts`|a list of accounts that will be iterated on|

#### Returns

|Type|Description|
|---|---|
|`Integer`|Integer the total number of employees for the accounts|

### `public static List<String> iterableApiClientRecipe()`

Demonstrates how to use a REST API client that leverages the Iterator interface. This example iterates on a paginated record list. Records are represented as strings for simplicity. Remote records are retrieved on the fly by IterableApiClient when the Iterator is accessed.

#### Returns

|Type|Description|
|---|---|
|`List<String>`|List<String> the 'records' retrieved|

---
