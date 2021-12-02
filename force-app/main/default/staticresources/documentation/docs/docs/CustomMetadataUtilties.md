---
layout: default
---
# CustomMetadataUtilties class

This class utilizes Custom Metadata objects and the example use case we&apos;ve established for Apex Recipes.

## Related

CustomMetadataRecipes_Tests

---
## Methods
### `getBucketedPicklistsForObject(Id objId)` → `List<Bucketed_Picklist__mdt>`

Identifies Bucketed Picklists the given object id has associated with it.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | d |

#### Return

**Type**

List&lt;Bucketed_Picklist__mdt&gt;

**Description**

`List&lt;Bucketed_Picklist__mdt&gt;`

### `getBucketedPicklistsForObject(List<Id> objIds)` → `List<Bucketed_Picklist__mdt>`

Convenience method accepts a list and send the first entry in the list to it&apos;s twin above.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | s |

#### Return

**Type**

List&lt;Bucketed_Picklist__mdt&gt;

**Description**

`List&lt;Bucketed_Picklist__mdt&gt;`

### `getPicklistBucketWithValues(List<Bucketed_Picklist__mdt> bPL,String search)` → `List<Picklist_Bucket__mdt>`

Returns a list of bucket names that match the given search term, and list of possible fields.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`bPL` |     Bucketed Picklist list |
|`search` |  Search String for Bucketed_Picklist_Value__mdt.label |

#### Return

**Type**

List&lt;Picklist_Bucket__mdt&gt;

**Description**

`List&lt;Picklist_Bucket__mdt&gt;`

---
