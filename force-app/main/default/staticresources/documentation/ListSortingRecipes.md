# ListSortingRecipes Class

Demonstrates how to sort lists using the Comparator Interface

**Group** Collection Recipes

**See** [AccountShippingCountryComparator](https://github.com/trailheadapps/apex-recipes/wiki/AccountShippingCountryComparator)

**See** [AccountNumberOfEmployeesComparator](https://github.com/trailheadapps/apex-recipes/wiki/AccountNumberOfEmployeesComparator)

## Methods
### `sortAccountsByShippingCountry(accounts)`

Demonstrates how to sort a list of Account using Comparator Interface 
In this example we pass in the implementation class `AccountShippingCountryComparator` 
as a parameter to the sort method of a list. This method sorts Accounts 
by shipping address in ascending alphabetical order

#### Signature
```apex
public static void sortAccountsByShippingCountry(List<Account> accounts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accounts | List&lt;Account&gt; | a list of accounts that will be sorted in place |

#### Return Type
**void**

---

### `sortAccountsByShippingCountryInDescending(accounts)`

Demonstrates how to sort a list of Account using Comparator Interface 
In this example we pass in the implementation class `AccountShippingCountryComparator` 
as a parameter to the sort method of a list. This method sorts Accounts 
by shipping address in descending alphabetical order

#### Signature
```apex
public static void sortAccountsByShippingCountryInDescending(List<Account> accounts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accounts | List&lt;Account&gt; | a list of accounts that will be sorted in place |

#### Return Type
**void**

---

### `sortAccountsByNumberOfEmployees(accounts)`

Demonstrates how to sort a list of Account using Comparator Interface 
In this example we pass in the implementation class `AccountNumberOfEmployeesComparator` 
as a parameter to the sort method of a list.This method sorts Accounts 
by employee number in the ascending order

#### Signature
```apex
public static void sortAccountsByNumberOfEmployees(List<Account> accounts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accounts | List&lt;Account&gt; | a list of accounts that will be sorted in place |

#### Return Type
**void**