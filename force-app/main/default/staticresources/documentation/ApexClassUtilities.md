# ApexClassUtilities

Contains reusable code dealing with ApexClass objects.
This is primarily used by the LWC components for displaying code
in an org.


**Group** Shared Code


**See** [RecipeTreeViewController](https://github.com/trailheadapps/apex-recipes/wiki/RecipeTreeViewController)


**See** [FormattedRecipeDisplayController](https://github.com/trailheadapps/apex-recipes/wiki/FormattedRecipeDisplayController)

## Methods
### `public static String getGroupFromClassBody(ApexClass klass)`

Extracts the `@group` annotation from a class' body. Also demonstrates the use of Regex matchers in Apex.

#### Parameters

|Param|Description|
|---|---|
|`klass`|an ApexClass object|

#### Returns

|Type|Description|
|---|---|
|`String`|`String` This is the text following `@group` through the end of the line.|

#### Example
```apex
ApexClass klass = [SELECT Name, Body FROM ApexClass LIMIT 1];
System.debug(ApexClassUtilities.getGroupFromClassBody(klass));
```


### `public static List<String> getRelatedClassesFromClassBody(ApexClass klass)`

Extracts the `@see` annotations from a class' body. Also demonstrates the use of Regex matchers in Apex.

#### Parameters

|Param|Description|
|---|---|
|`klass`|an ApexClass object|

#### Returns

|Type|Description|
|---|---|
|`List<String>`|`List<String>` These are the values following `@see` annotations|

#### Example
```apex
ApexClass klass = [SELECT Name, Body FROM ApexClass LIMIT 1];
System.debug(ApexClassUtilities.getRelatedClassesFromClassBody(klass));
```


---
