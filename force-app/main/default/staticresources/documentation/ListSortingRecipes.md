# ListSortingRecipes

Demonstrates how to sort lists using Comparator Interface


**Group** Collection Recipes


**See** [AccountShippingCountryComparator](https://github.com/trailheadapps/apex-recipes/wiki/AccountShippingCountryComparator)


**See** [AccountNumberOfEmployeesComparator](https://github.com/trailheadapps/apex-recipes/wiki/AccountNumberOfEmployeesComparator)

## Methods
### `public static void sortAccountsByShippingCountry(List<Account> accounts)`

Demonstrates how to sort a list of Account using Comparator Interface In this example we pass in the implementation class `AccountShippingCountryComparator` as a parameter to the sort method of a list. This method sorts Accounts by shipping address in ascending alphabetical order

#### Parameters

|Param|Description|
|---|---|
|`accounts`|a list of accounts that will be sorted in place|

### `public static void sortAccountsByShippingCountryInDescending(List<Account> accounts)`

Demonstrates how to sort a list of Account using Comparator Interface In this example we pass in the implementation class `AccountShippingCountryComparator` as a parameter to the sort method of a list. This method sorts Accounts by shipping address in descending alphabetical order

#### Parameters

|Param|Description|
|---|---|
|`accounts`|a list of accounts that will be sorted in place|

### `public static void sortAccountsByNumberOfEmployees(List<Account> accounts)`

Demonstrates how to sort a list of Account using Comparator Interface In this example we pass in the implementation class `AccountNumberOfEmployeesComparator` as a parameter to the sort method of a list.This method sorts Accounts by employee number in the ascending order

#### Parameters

|Param|Description|
|---|---|
|`accounts`|a list of accounts that will be sorted in place|

---
