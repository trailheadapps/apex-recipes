# AccountShippingCountryComparator

An example implementation of Comparator Interface
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

### `private VALIDSORTORDER` → `Set<String>`


### `private sortOrder` → `String`


---
## Methods
### `public Integer compare(Account a1, Account a2)`
---
## Classes
### ASCComparatorException

This exception is for throwing a custom exception to


**Inheritance**

ASCComparatorException


---
