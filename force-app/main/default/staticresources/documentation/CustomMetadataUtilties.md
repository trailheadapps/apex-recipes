# CustomMetadataUtilties Class

This class utilizes Custom Metadata objects and the example 
use case we&#x27;ve established for Apex Recipes.

**Group** Custom Metadata Recipes

**See** CustomMetadataRecipes_Tests

## Methods
### `getBucketedPicklistsForObject(objId)`

`SUPPRESSWARNINGS`

Identifies Bucketed Picklists the given object ID has 
associated with it.

#### Signature
```apex
public List&lt;Bucketed_Picklist__mdt&gt; getBucketedPicklistsForObject(Id objId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objId | Id |  |

#### Return Type
**List&lt;Bucketed_Picklist__mdt&gt;**

List of Bucketed_Picklist__mdt records associated with the 
given object Id, or an empty list if objId is null.

---

### `getBucketedPicklistsForObject(objIds)`

Convenience method accepts a list and send the first 
entry in the list to it&#x27;s twin above.

#### Signature
```apex
public List&lt;Bucketed_Picklist__mdt&gt; getBucketedPicklistsForObject(List&lt;Id&gt; objIds)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objIds | List&lt;Id&gt; |  |

#### Return Type
**List&lt;Bucketed_Picklist__mdt&gt;**

List of Bucketed_Picklist__mdt records associated with the 
first object Id in the list.

---

### `getPicklistBucketWithValues(bPL, search)`

`SUPPRESSWARNINGS`

Returns a list of bucket names that match the given search 
term, and list of possible fields.

#### Signature
```apex
public List&lt;Picklist_Bucket__mdt&gt; getPicklistBucketWithValues(List&lt;Bucketed_Picklist__mdt&gt; bPL, String search)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| bPL | List&lt;Bucketed_Picklist__mdt&gt; | Bucketed Picklist list |
| search | String | Search String for Bucketed_Picklist_Value__mdt.label |

#### Return Type
**List&lt;Picklist_Bucket__mdt&gt;**

List of Picklist_Bucket__mdt records, with their related 
Bucketed_Picklist_values__r matching the search term, for the given 
Bucketed Picklists.