# RecipeTreeViewController

Provides the necessary data to populate a lightning-tree base
component with recipe and group information


**Group** Shared Code


**See** [ApexClassUtilities](https://github.com/trailheadapps/apex-recipes/wiki/ApexClassUtilities)

## Fields

### `private APEXRECIPESIDENTIFICATIONTAG` → `String`


The String here represents a relatively unique tag that Apex Recipe uses to help group related classes.

### `private groupToListOfNames` → `Map<String,List<String>>`


---
## Methods
### `public static List<RecipeTreeData> generateTreeData()`

`AURAENABLED`

Generates a recursive list of RecipeTreeData objects to feed to a Lightning-tree-view component. Importantly, the returning array has two RecipeTreeData objects - One for Recipes, the other for our supporting, shared code.

#### Returns

|Type|Description|
|---|---|
|`List<RecipeTreeData>`|`List<RecipeTreeData>`|

#### Example
```apex
System.debug(RecipeTreeViewController.generateTreeData());
```


### `private static Map<String,List<String>> generateMapOfGroupToListOfNames()`

`SUPPRESSWARNINGS`

Generates a map containing Group names as the Keys tied to a List of class names. Note: this method contains a false-positive PMD violation. Normally, we'd want to check for FLS/CRUD here, but for ApexClass a system level object that Admins and users cannot really change we're ok.

#### Returns

|Type|Description|
|---|---|
|`Map<String,List<String>>`|`Map<String, List<String>>`|

---
## Classes
### RecipeTreeData

Used to marshall data between Apex and the LWC component
that uses this data


**Implemented types**

[Comparable](Comparable)

#### Fields

##### `public expanded` → `Boolean`

`AURAENABLED` 

##### `public items` → `RecipeTreeData`

`AURAENABLED` 

##### `public label` → `String`

`AURAENABLED` 

##### `public name` → `String`

`AURAENABLED` 

---
#### Methods
##### `public Integer compareTo(Object compareTo)`

Required by the Comparable interface, this method, once implemented allows us to sort of this object type.

###### Parameters

|Param|Description|
|---|---|
|`compareTo`|A RecipeTreeData object to compare this instance against.|

###### Returns

|Type|Description|
|---|---|
|`Integer`|`Integer`|

---

---
