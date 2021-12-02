---
layout: default
---
# ApexClassUtilities class

Contains reusable code dealing with ApexClass objects. This is primarily used by the LWC components for displaying code in an org.

## Related

RecipeTreeViewController, FormattedRecipeDisplayController

---
## Methods
### `getGroupFromClassBody(ApexClass klass)` → `String`

Extracts the @group annotation from a class&apos; body. Also demonstrates the use of Regex matchers in Apex.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`klass` |  an ApexClass object |

#### Return

**Type**

String

**Description**

`String` This is the text following &apos;@group&apos; through

#### Example
```java
ApexClass klass = [SELECT Name, Body FROM ApexClass LIMIT 1];
System.debug(ApexClassUtilities.getGroupBodyFromClassBody(klass));
```

### `getRelatedClassesFromClassBody(ApexClass klass)` → `String`

Extracts the @see annotation from a class&apos; body. Also demonstrates the use of Regex matchers in Apex.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`klass` |  an ApexClass object |

#### Return

**Type**

String

**Description**

`String` This is the text following &apos;@see&apos; through

#### Example
```java
ApexClass klass = [SELECT Name, Body FROM ApexClass LIMIT 1];
System.debug(ApexClassUtilities.getRelatedClassesFromClassBody(klass));
```

---
