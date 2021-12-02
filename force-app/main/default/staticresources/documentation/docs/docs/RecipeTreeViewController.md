---
layout: default
---
# RecipeTreeViewController class

Provides the necessary data to populate a lightning-tree base component with recipe and group information

## Related

[ApexClassUtilities](https://github.com/trailheadapps/apex-recipes/wiki/ApexClassUtilities.md)

---
## Properties

### `APEXRECIPESIDENTIFICATIONTAG` → `String`

The String here represents a relatively unique tag that Apex Recipe uses to help group related classes.

### `groupToListOfNames` → `List<String>>`

---
## Methods
### `generateMapOfGroupToListOfNames()` → `List<String>>`

Generates a map containing Group names as the Keys tied to a List of class names. Note: this method contains a false-positive PMD violation. Normally, we&apos;d want to check for FLS/CRUD here, but for ApexClass a system level object that Admins and users cannot really change we&apos;re ok.

#### Return

**Type**

List&lt;String&gt;&gt;

**Description**

`Map&lt;String, List&lt;String&gt;&gt;`

### `generateTreeData()` → `List<RecipeTreeData>`

Generates a recursive list of RecipeTreeData objects to feed to a Lightning-tree-view component. Importantly, the returning array has two RecipeTreeData objects - One for Recipes, the other for our supporting, shared code.

#### Return

**Type**

List&lt;RecipeTreeData&gt;

**Description**

`List&lt;RecipeTreeData&gt;`

#### Example
```java
System.debug(RecipeTreeViewController.generateTreeData());
```

---
## Inner Classes

### RecipeTreeViewController.RecipeTreeData class

Used to marshall data between Apex and the LWC component that uses this data

---
#### Properties

##### `expanded` → `Boolean`

##### `items` → `RecipeTreeData[]`

##### `label` → `String`

##### `name` → `String`

---
#### Methods
##### `compareTo(Object compareTo)` → `Integer`

Required by the Comparable interface, this method, once implemented allows us to sort of this object type.

###### Parameters

| Param | Description |
| ----- | ----------- |
|`compareTo` |  A RecipeTreeData object to compare this instance against. |

###### Return

**Type**

Integer

**Description**

`Integer`

---
