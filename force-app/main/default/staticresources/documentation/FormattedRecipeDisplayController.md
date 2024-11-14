# FormattedRecipeDisplayController Class

this is the server side controller for the Formatted Recipe 
Display component. It has one method that delivers a class, and it&#x27;s matching 
test class to the UI for display. The component is reponsible for formatting 
and syntax highlighting

**Group** Shared Code

**See** [ApexClassUtilities](ApexClassUtilities.md)

## Methods
### `getRecipeCode(recipeName)`

`SUPPRESSWARNINGS`
`AURAENABLED`

AuraEnabled, and cached read-only method for 
grabbing the body of a given Apex Class 
 
Note: this method contains a false-positive PMD violation. 
Normally, we&#x27;d want to check for FLS/CRUD here, but for ApexClass 
a system level object that Admins and users cannot really change 
we&#x27;re ok.

#### Signature
```apex
public static ClassData getRecipeCode(String recipeName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recipeName | String | Name of the Class to return |

#### Return Type
**ClassData**

#### Example
```apex
System.debug(FormattedRecipeDisplayController.getRecipeCode('FormattedRecipeDisplayController'));
```

## Classes
### ClassData Class

Data transfer object for marshalling information form this 
class to the LWC that consumes it

#### Fields
##### `name`

`AURAENABLED`

###### Signature
```apex
public name
```

###### Type
String

---

##### `apiVersion`

`AURAENABLED`

###### Signature
```apex
public apiVersion
```

###### Type
Decimal

---

##### `body`

`AURAENABLED`

###### Signature
```apex
public body
```

###### Type
String

---

##### `lengthWithoutComments`

`AURAENABLED`

###### Signature
```apex
public lengthWithoutComments
```

###### Type
Integer

---

##### `groupName`

`AURAENABLED`

###### Signature
```apex
public groupName
```

###### Type
String

#### Constructors
##### `ClassData(klass)`

constructor for ClassData that accepts an ApexClass 
object

###### Signature
```apex
public ClassData(ApexClass klass)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| klass | ApexClass | An ApexClass object to build this object from. |