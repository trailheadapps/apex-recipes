---
layout: default
---
# SortableAccount

Wrapper class around Account that provides an implementation of
Comparable based on the ShippingCountry field and an 'in place' sort method.


**Implemented types**

[Comparable](Comparable)

## Constructors
### `public SortableAccount(Account account)`
---
## Fields

### `private account` → `Account`


---
## Methods
### `public compareTo(Object otherObject)`

compares accounts based on ShippingCountry

#### Parameters

|Param|Description|
|---|---|
|`otherObject`|object used for comparision with this instance|

#### Returns

|Type|Description|
|---|---|
|Integer|s 0 if objects are equal, 1 this object is "greater" than `otherObject` or 2 otherwise.|

#### Throws

|Exception|Description|
|---|---|
|`Throws`|SortException if an error occurs while sorting the list. For example, when comparing with an incompatible object type.|

### `public static sort(List<Account> accounts)`

sorts a list of Account records using SortableAccount.compareTo

#### Parameters

|Param|Description|
|---|---|
|`accounts`|list of account to sort|

---
## Classes
### SortException

Exception thrown when SortableAccount.compareTo fails


**Inheritance**

SortException


---
