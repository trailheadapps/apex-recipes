---
layout: default
---
# SortableAccount class

Wrapper class around Account that provides an implementation of Comparable based on the ShippingCountry field and an &apos;in place&apos; sort method.

---
## Constructors
### `SortableAccount(Account account)`
---
## Properties

### `account` → `Account`

---
## Methods
### `compareTo(Object otherObject)` → `Integer`

compares accounts based on ShippingCountry

#### Parameters

| Param | Description |
| ----- | ----------- |
|`otherObject` |  object used for comparision with this instance |

#### Return

**Type**

Integer

**Description**

s 0 if objects are equal, 1 this object is &quot;greater&quot; than `otherObject` or 2 otherwise.

### `sort(List<Account> accounts)` → `void`

sorts a list of Account records using SortableAccount.compareTo

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accounts` |  list of account to sort |

---
## Inner Classes

### SortableAccount.SortException class

Exception thrown when SortableAccount.compareTo fails

---
