---
layout: default
---
# RelatedCodeTabsController class

Apex server side controller for discovering other classes related to the one being viewed

## Related

[ApexClassUtilities](https://github.com/trailheadapps/apex-recipes/wiki/ApexClassUtilities.md)

---
## Methods
### `getRelatedClasses(String mainClassName)` → `List<String>`

Inspects the ApexClass body definition for a @see tag in the opening class level doc block. It then parses the comma separated list and returns it as a list of strings Note: this method contains a false-positive PMD violation. Normally, we&apos;d want to check for FLS/CRUD here, but for ApexClass a system level object that Admins and users cannot really change we&apos;re ok.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`mainClassName` |  The name of the class to inspect |

#### Return

**Type**

List&lt;String&gt;

**Description**

`List&lt;String&gt;`

#### Example
```java
System.debug(RelatedCodeTabsController.getRelatedClasses('RelatedCodeTabsController'));
```

---
