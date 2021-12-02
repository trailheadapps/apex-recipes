---
layout: default
---
# IterationRecipes class

Demonstrates how to iterate on lists and sets

## Related

[IterableApiClient](https://github.com/trailheadapps/apex-recipes/wiki/IterableApiClient.md)

---
## Methods
### `iterableApiClientRecipe()` → `List<String>`

Demonstrates how to use a REST API client that leverages the Iterator interface. This example iterates on a paginated record list. Records are represented as strings for simplicity. Remote records are retrieved on the fly by IterableApiClient when the Iterator is accessed.

#### Return

**Type**

List&lt;String&gt;

**Description**

List&lt;String&gt; the &apos;records&apos; retrieved

### `iterateOnAccountList(List<Account> accounts)` → `Integer`

Demonstrates how to iterate on a list of SObject thanks to the Iterable and Iterator interfaces. This example iterates on Accounts to sum the &apos;number of employees&apos; field values (use the `SUM` SOQL function for a real-life application).

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accounts` |  a list of accounts that will be iterated on |

#### Return

**Type**

Integer

**Description**

Integer the total number of employees for the accounts

---
