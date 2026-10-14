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
public List<Bucketed_Picklist__mdt> getBucketedPicklistsForObject(Id objId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objId | Id |  |

#### Return Type
**List<Bucketed_Picklist__mdt>**

---

### `getBucketedPicklistsForObject(objIds)`

Convenience method accepts a list and send the first 
entry in the list to it&#x27;s twin above.

#### Signature
```apex
public List<Bucketed_Picklist__mdt> getBucketedPicklistsForObject(List<Id> objIds)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objIds | List<Id> |  |

#### Return Type
**List<Bucketed_Picklist__mdt>**

---

### `getPicklistBucketWithValues(bPL, search)`

`SUPPRESSWARNINGS`

Returns a list of bucket names that match the given search 
term, and list of possible fields.

#### Signature
```apex
public List<Picklist_Bucket__mdt> getPicklistBucketWithValues(List<Bucketed_Picklist__mdt> bPL, String search)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| bPL | List<Bucketed_Picklist__mdt> | Bucketed Picklist list |
| search | String | Search String for Bucketed_Picklist_Value__mdt.label |

#### Return Type
**List<Picklist_Bucket__mdt>**