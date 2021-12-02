---
layout: default
---
# ListSortingRecipes class

Demonstrates how to sort lists with custom ordering logic

## Related

ListUtils, SortableAccount, SObjectStringFieldComparator

---
## Methods
### `sortAccountsWithComparator(List<Account> accounts)` → `void`

Demonstrates how to sort a list of SObject in place with reusable comparators. This example shows how to sort Accounts based on the ShippingCountry field. We use a generic ListUtils utility class with a SObjectStringFieldComparator class that implements the ListUtils.Comparator interface.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accounts` |  a list of accounts that will be sorted in place |

### `sortAccountsWithSortableWrapper(List<Account> accounts)` → `void`

Demonstrates how to sort a list of SObject in place (without the need for a return statement). This example shows how to sort Accounts based on the ShippingCountry field. We use a SortableAccount wrapper class in order to implement the Comparable interface so that we can use List.sort() with SObject.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accounts` |  a list of accounts that will be sorted in place |

---
