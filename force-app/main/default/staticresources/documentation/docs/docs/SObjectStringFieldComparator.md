---
layout: default
---
# SObjectStringFieldComparator class

 Comparator that lets you sort a list of SObject alphabetically based on a String field. @example ListUtils.sort(accounts, new SObjectStringFieldComparator(&apos;ShippingCountry&apos;)); Tip: don&apos;t use this to sort by Name as SObjects are already sorted by Name by default when calling List&lt;SObject&gt;.sort()

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
