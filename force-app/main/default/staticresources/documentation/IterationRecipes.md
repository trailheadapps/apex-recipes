# IterationRecipes Class

Demonstrates how to iterate on lists and sets

**Group** Collection Recipes

**See** [IterableApiClient](https://github.com/trailheadapps/apex-recipes/wiki/IterableApiClient)

## Methods
### `iterateOnAccountList(accounts)`

Demonstrates how to iterate on a list of SObject thanks to the Iterable and Iterator interfaces. 
This example iterates on Accounts to sum the &#x27;number of employees&#x27; field values 
(use the `SUM` SOQL function for a real-life application).

#### Signature
```apex
public static Integer iterateOnAccountList(List<Account> accounts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accounts | List&lt;Account&gt; | a list of accounts that will be iterated on |

#### Return Type
**Integer**

Total number of employees for the accounts

---

### `iterableApiClientRecipe()`

Demonstrates how to use a REST API client that leverages the `Iterator` interface. 
This example iterates on a paginated record list. Records are represented as strings for simplicity. 
Remote records are retrieved on the fly by IterableApiClient when the Iterator is accessed.

#### Signature
```apex
public static List<String> iterableApiClientRecipe()
```

#### Return Type
**List&lt;String&gt;**

List of &quot;records&quot; retrieved