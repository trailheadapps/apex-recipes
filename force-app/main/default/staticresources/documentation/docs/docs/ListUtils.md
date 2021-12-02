---
layout: default
---
# ListUtils class

This is a utility class for List operations. It provides a method that allows to sort lists in place with reusable comparators. See SObjectStringFieldComparator for tests.

## Related

[SObjectStringFieldComparator](https://github.com/trailheadapps/apex-recipes/wiki/SObjectStringFieldComparator.md)

---
## Methods
### `sort(List<Object> objects, Comparator comparator)` → `void`

sorts a list of objects using bubble sort algorithm and a comparator

#### Parameters

| Param | Description |
| ----- | ----------- |
|`objects` |  a list of objects that will be sorted |
|`comparator` |  an instance of the Comparator interface that describes the ordering logic used for sorting |

---
## Inner Classes

### ListUtils.Comparator interface

interface that specifies how two objects should be compared for ordering

---
#### Methods
##### `compare(Object o1, Object o2)` → `Integer`

compares two objects

###### Return

**Type**

Integer

**Description**

s 0 if objects are equal, 1 first object is &apos;greater&apos; than the second or 2 otherwise.

---
### ListUtils.CompareException class

Exception thrown when Comparator.compare fails

---
