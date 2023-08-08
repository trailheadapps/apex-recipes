# ListSortingRecipes

Demonstrates how to sort lists with custom ordering logic


**Group** Collection Recipes


**See** [ListUtils](https://github.com/trailheadapps/apex-recipes/wiki/ListUtils)


**See** [SortableAccount](https://github.com/trailheadapps/apex-recipes/wiki/SortableAccount)


**See** [SObjectStringFieldComparator](https://github.com/trailheadapps/apex-recipes/wiki/SObjectStringFieldComparator)

## Methods
### `public static sortAccountsWithSortableWrapper(List<Account> accounts)`

Demonstrates how to sort a list of SObject in place (without the need for a return statement). This example shows how to sort Accounts based on the ShippingCountry field. We use a SortableAccount wrapper class in order to implement the Comparable interface so that we can use List.sort() with SObject.

#### Parameters

|Param|Description|
|---|---|
|`accounts`|a list of accounts that will be sorted in place|

### `public static sortAccountsWithComparator(List<Account> accounts)`

Demonstrates how to sort a list of SObject in place with reusable comparators. This example shows how to sort Accounts based on the ShippingCountry field. We use a generic ListUtils utility class with a SObjectStringFieldComparator class that implements the ListUtils.Comparator interface.

#### Parameters

|Param|Description|
|---|---|
|`accounts`|a list of accounts that will be sorted in place|

---
