---
layout: default
---
# SObjectStringFieldComparator class

 Comparator that lets you sort a list of SObject alphabetically based on a String field. @example ListUtils.sort(accounts, new SObjectStringFieldComparator('ShippingCountry')); Tip: don't use this to sort by Name as SObjects are already sorted by Name by default when calling List<SObject>.sort()

## Related

[ListUtils](https://github.com/trailheadapps/apex-recipes/wiki/ListUtils.md)

---
## Constructors
### `SObjectStringFieldComparator(String fieldName)`
---
## Properties

### `fieldName` → `String`

---
## Methods
### `compare(Object o1, Object o2)` → `Integer`
---
