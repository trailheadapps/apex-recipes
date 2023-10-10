# RelatedCodeTabsController

Apex server side controller for discovering other classes
related to the one being viewed


**Group** Shared Code


**See** [ApexClassUtilities](https://github.com/trailheadapps/apex-recipes/wiki/ApexClassUtilities)

## Methods
### `public static List<String> getRelatedClasses(String mainClassName)`

`SUPPRESSWARNINGS`

`AURAENABLED`

Inspects the ApexClass body definition for a `@see` tag in the opening class level doc block. It then parses the comma separated list and returns it as a list of strings Note: this method contains a false-positive PMD violation. Normally, we'd want to check for FLS/CRUD here, but for ApexClass a system level object that Admins and users cannot really change we're ok.

#### Parameters

|Param|Description|
|---|---|
|`mainClassName`|The name of the class to inspect|

#### Returns

|Type|Description|
|---|---|
|`List<String>`|`List<String>`|

#### Example
```apex
System.debug(RelatedCodeTabsController.getRelatedClasses('RelatedCodeTabsController'));
```


---
