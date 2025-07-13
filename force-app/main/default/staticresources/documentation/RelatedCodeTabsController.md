# RelatedCodeTabsController Class

Apex server side controller for discovering other classes 
related to the one being viewed

**Group** Shared Code

**See** [ApexClassUtilities](ApexClassUtilities.md)

## Methods
### `getRelatedClasses(mainClassName)`

`SUPPRESSWARNINGS`
`AURAENABLED`

Inspects the ApexClass body definition for a `@see` 
tag in the opening class level doc block. It then parses the 
comma separated list and returns it as a list of strings 
 
Note: this method contains a false-positive PMD violation. 
Normally, we&#x27;d want to check for FLS/CRUD here, but for ApexClass 
a system level object that Admins and users cannot really change 
we&#x27;re ok.

#### Signature
```apex
public static List<String> getRelatedClasses(String mainClassName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| mainClassName | String | The name of the class to inspect |

#### Return Type
**List&lt;String&gt;**

#### Example
```apex
System.debug(RelatedCodeTabsController.getRelatedClasses('RelatedCodeTabsController'));
```