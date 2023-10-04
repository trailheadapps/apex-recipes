# ListUtils

This is a utility class for List operations.
It provides a method that allows to sort lists in place with reusable comparators.
See SObjectStringFieldComparator for tests.


**Group** Shared Code


**See** [SObjectStringFieldComparator](https://github.com/trailheadapps/apex-recipes/wiki/SObjectStringFieldComparator)

## Methods
### `public static void sort(List<Object> objects, Comparator comparator)`

sorts a list of objects using bubble sort algorithm and a comparator

#### Parameters

|Param|Description|
|---|---|
|`objects`|a list of objects that will be sorted|
|`comparator`|an instance of the Comparator interface that describes the ordering logic used for sorting|

---
## Classes
### CompareException

Exception thrown when Comparator.compare fails


**Inheritance**

CompareException


---
## Interfaces
### Comparator

interface that specifies how two objects should be compared for ordering

#### Methods
##### `public Integer compare(Object o1, Object o2)`

compares two objects

###### Returns

|Type|Description|
|---|---|
|Integer|s 0 if objects are equal, 1 first object is 'greater' than the second or 2 otherwise.|

###### Throws

|Exception|Description|
|---|---|
|`Throws`|CompareException if an error occurs while comparing objects. For example, when comparing incompatible object types.|

---

