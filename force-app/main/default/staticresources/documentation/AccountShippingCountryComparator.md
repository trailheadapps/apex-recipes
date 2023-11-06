# AccountShippingCountryComparator

An example implementation of the Comparator Interface
In this example we show how to sort all the accounts by their country names in alphabetical order


**Implemented types**

[Comparator&lt;Account&gt;](Comparator&lt;Account&gt;)

## Constructors
### `public AccountShippingCountryComparator()`

No param constructor. Assigns sort order as ascending by default

### `public AccountShippingCountryComparator(String sortOrder)`

Constructor accepting sort order as ascending/descending. Use this constructor to *control* the sort order.

#### Parameters

|Param|Description|
|---|---|
|`sortOrder`||

---
## Fields

### `private VALID_SORT_ORDER` → `Set<String>`


### `private sortOrder` → `String`


---
## Methods
### `public Integer compare(Account a1, Account a2)`
---
## Classes
### ASCComparatorException

This exception class is for throwing a custom exception


**Inheritance**

ASCComparatorException


---
