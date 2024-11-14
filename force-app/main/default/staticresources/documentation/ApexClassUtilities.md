# ApexClassUtilities Class

Contains reusable code dealing with ApexClass objects. 
This is primarily used by the LWC components for displaying code 
in an org.

**Group** Shared Code

**See** [RecipeTreeViewController](RecipeTreeViewController.md)

**See** [FormattedRecipeDisplayController](FormattedRecipeDisplayController.md)

## Methods
### `getGroupFromClassBody(klass)`

Extracts the `@group` annotation from a class&#x27; body. 
Also demonstrates the use of Regex matchers in Apex.

#### Signature
```apex
public static String getGroupFromClassBody(ApexClass klass)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| klass | ApexClass | an ApexClass object |

#### Return Type
**String**

Text following ,[object Object], through the end of the line.

#### Example
```apex
ApexClass klass = [SELECT Name, Body FROM ApexClass LIMIT 1];
System.debug(ApexClassUtilities.getGroupFromClassBody(klass));
```

---

### `getRelatedClassesFromClassBody(klass)`

Extracts the `@see` annotations from a class&#x27; body. 
Also demonstrates the use of Regex matchers in Apex.

#### Signature
```apex
public static List<String> getRelatedClassesFromClassBody(ApexClass klass)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| klass | ApexClass | an ApexClass object |

#### Return Type
**List&lt;String&gt;**

Values following ,[object Object], annotations

#### Example
```apex
ApexClass klass = [SELECT Name, Body FROM ApexClass LIMIT 1];
System.debug(ApexClassUtilities.getRelatedClassesFromClassBody(klass));
```