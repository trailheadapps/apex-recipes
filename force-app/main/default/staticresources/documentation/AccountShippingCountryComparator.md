# AccountShippingCountryComparator Class

An example implementation of the Comparator Interface 
In this example we show how to sort all the accounts by their country names in alphabetical order

**Implements**

Comparator&lt;Account&gt;

## Properties
### `order`

#### Signature
```apex
public order
```

#### Type
SortOrder

## Constructors
### `AccountShippingCountryComparator()`

No param constructor. Assigns sort order as ascending by default

#### Signature
```apex
public AccountShippingCountryComparator()
```

---

### `AccountShippingCountryComparator(order)`

Constructor accepting sort order as ascending/descending. Use 
this constructor to *control* the sort order.

#### Signature
```apex
public AccountShippingCountryComparator(AccountShippingCountryComparator.SortOrder order)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| order | AccountShippingCountryComparator.SortOrder |  |

## Methods
### `compare(a1, a2)`

#### Signature
```apex
public Integer compare(Account a1, Account a2)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| a1 | Account |  |
| a2 | Account |  |

#### Return Type
**Integer**

## Classes
### ASCComparatorException Class

This exception class is for throwing a custom exception

## Enums
### SortOrder Enum

#### Values
| Value | Description |
|-------|-------------|
| ASCENDING |  |
| DESCENDING |  |