# RecipeTreeViewController Class

Provides the necessary data to populate a lightning-tree base 
component with recipe and group information

**Group** Shared Code

**See** [ApexClassUtilities](ApexClassUtilities.md)

## Fields
### `groupToListOfNames`

#### Signature
```apex
private static groupToListOfNames
```

#### Type
Map&lt;String,List&lt;String&gt;&gt;

---

### `GROUP_TAG`

The String here represents a relatively unique tag that 
Apex Recipe uses to help group related classes.

#### Signature
```apex
private static final GROUP_TAG
```

#### Type
String

## Methods
### `generateTreeData()`

`AURAENABLED`

Generates a recursive list of RecipeTreeData objects 
to feed to a Lightning-tree-view component. Importantly, the returning 
array has two RecipeTreeData objects - One for Recipes, the other 
for our supporting, shared code.

#### Signature
```apex
public static List<RecipeTreeData> generateTreeData()
```

#### Return Type
**List&lt;RecipeTreeData&gt;**

list of RecipeTreeData objects

#### Example
```apex
System.debug(RecipeTreeViewController.generateTreeData());
```

---

### `generateMapOfGroupToListOfNames()`

`SUPPRESSWARNINGS`

Generates a map containing Group names as the Keys tied to 
a List of class names. 
 
Note: this method contains a false-positive PMD violation. 
Normally, we&#x27;d want to check for FLS/CRUD here, but for ApexClass 
a system level object that Admins and users cannot really change 
we&#x27;re ok.

#### Signature
```apex
private static Map<String,List<String>> generateMapOfGroupToListOfNames()
```

#### Return Type
**Map&lt;String,List&lt;String&gt;&gt;**

map containing Group names as the Keys tied to a List of class names.

## Classes
### RecipeTreeData Class

Used to marshall data between Apex and the LWC component 
that uses this data

**Implements**

Comparable

#### Fields
##### `label`

`AURAENABLED`

###### Signature
```apex
public label
```

###### Type
String

---

##### `name`

`AURAENABLED`

###### Signature
```apex
public name
```

###### Type
String

---

##### `expanded`

`AURAENABLED`

###### Signature
```apex
public expanded
```

###### Type
Boolean

---

##### `items`

`AURAENABLED`

###### Signature
```apex
public items
```

###### Type
RecipeTreeData

#### Methods
##### `compareTo(compareTo)`

Required by the Comparable interface, this method, 
once implemented allows us to sort of this object type.

###### Signature
```apex
public Integer compareTo(Object compareTo)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| compareTo | Object | A RecipeTreeData object to compare this instance against. |

###### Return Type
**Integer**

sort index