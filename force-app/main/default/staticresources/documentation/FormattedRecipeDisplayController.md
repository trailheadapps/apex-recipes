# FormattedRecipeDisplayController

this is the server side controller for the Formatted Recipe
Display component. It has one method that delivers a class, and it's matching
test class to the UI for display. The component is reponsible for formatting
and syntax highlighting


**Group** Shared Code


**See** [ApexClassUtilities](https://github.com/trailheadapps/apex-recipes/wiki/ApexClassUtilities)

## Methods
### `public static ClassData getRecipeCode(String recipeName)`

`SUPPRESSWARNINGS`

`AURAENABLED`

AuraEnabled, and cached read-only method for grabbing the body of a given Apex Class Note: this method contains a false-positive PMD violation. Normally, we'd want to check for FLS/CRUD here, but for ApexClass a system level object that Admins and users cannot really change we're ok.

#### Parameters

|Param|Description|
|---|---|
|`recipeName`|Name of the Class to return|

#### Returns

|Type|Description|
|---|---|
|`ClassData`|`ClassData`|

#### Example
```apex
System.debug(FormattedRecipeDisplayController.getRecipeCode('FormattedRecipeDisplayController'));
```


---
## Classes
### ClassData

Data transfer object for marshalling information form this
class to the LWC that consumes it

#### Constructors
##### `public ClassData(ApexClass klass)`

constructor for ClassData that accepts an ApexClass object

###### Parameters

|Param|Description|
|---|---|
|`klass`|An ApexClass object to build this object from.|

---
#### Fields

##### `public apiVersion` → `Decimal`

`AURAENABLED` 

##### `public body` → `String`

`AURAENABLED` 

##### `public groupName` → `String`

`AURAENABLED` 

##### `public lengthWithoutComments` → `Integer`

`AURAENABLED` 

##### `public name` → `String`

`AURAENABLED` 

---

---
