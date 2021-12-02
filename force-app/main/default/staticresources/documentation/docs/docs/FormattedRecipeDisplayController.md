---
layout: default
---
# FormattedRecipeDisplayController class

this is the server side controller for the Formatted Recipe Display component. It has one method that delivers a class, and it&apos;s matching test class to the UI for display. The component is reponsible for formatting and syntax highlighting

## Related

[ApexClassUtilities](https://github.com/trailheadapps/apex-recipes/wiki/ApexClassUtilities.md)

---
## Methods
### `getRecipeCode(String recipeName)` → `ClassData`

AuraEnabled, and cached read-only method for grabbing the body of a given Apex Class Note: this method contains a false-positive PMD violation. Normally, we&apos;d want to check for FLS/CRUD here, but for ApexClass a system level object that Admins and users cannot really change we&apos;re ok.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`recipeName` |  Name of the Class to return |

#### Return

**Type**

ClassData

**Description**

`ClassData`

#### Example
```java
System.debug(FormattedRecipeDisplayController.getRecipeCode('FormattedRecipeDisplayController'));
```

---
## Inner Classes

### FormattedRecipeDisplayController.ClassData class

Data transfer object for marshalling information form this class to the LWC that consumes it

---
#### Constructors
##### `ClassData(ApexClass klass)`

constructor for ClassData that accepts an ApexClass object
###### Parameters

| Param | Description |
| ----- | ----------- |
|`klass` |  An ApexClass object to build this object from. |

---
#### Properties

##### `apiVersion` → `Decimal`

##### `body` → `String`

##### `groupName` → `String`

##### `lengthWithoutComments` → `Integer`

##### `name` → `String`

---
