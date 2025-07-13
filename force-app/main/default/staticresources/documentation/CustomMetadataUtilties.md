# CustomMetadataUtilties Class

This class utilizes Custom Metadata objects and the example 
use case we&#x27;ve established for Apex Recipes.

**Group** Custom Metadata Recipes

**See** CustomMetadataRecipes_Tests

## Methods
### `getBucketedPicklistsForObject(objId)`

`SUPPRESSWARNINGS`

Understanding this class, and it&#x27;s utility requires understanding the use 
case we&#x27;ve setup for: 
 
Our org has the need to periodically act on the value of picklist fields. 
However, sometimes we need to &#x27;bucket&#x27; the values. This is similar to the 
way Case and Opportunity have &#x27;status&#x27; picklists that are &#x27;open&#x27; or 
&#x27;closed&#x27;. Open and Closed are &#x27;buckets&#x27; that picklist values fall into. 
 
For our use case, and to demonstrate CustomMetadata relationships we&#x27;ve 
Setup three Custom Metadata objects: 
1. Bucketed_Picklist__mdt. This metadata has two metadata relationships 
looking up to an object entity (object__c) and a field entity (field__c) 
The field lookup is controlled by the object lookup. The purpose of this 
metadata is to concretely identify object.field references to picklists 
we want to bucket. Ie: Contact.AttendanceStatus__c is a bucketed picklist 
because a CMD record exists specifying &#x27;Contact&#x27; as the object and 
&#x27;Attendance__c&#x27; as the field. 
2. Picklist_Bucket__mdt. This metadata has an metadata relationship to 
Bucketed_Picklist__mdt. It&#x27;s label serves not only as the label for the 
record, but also for the &#x27;bucket&#x27; name. Ie, if we were using this setup 
for Opportunity&#x27;s open/closed bucketing, the labels would be &#x27;Open&#x27;, and 
&#x27;Closed&#x27;. 
3. Bucketed_Picklist_value__mdt. This metadata has a relationship to 
Picklist_Bucket__mdt, and represents a value that is understood to be 
in the bucket it&#x27;s related too. For instance, given the Opportunity 
parallel, one value here would be &#x27;closed/Won&#x27;. There is generally a 1:1 
relationship between the picklist values of the field identified by 
Bucketed_Picklist__mdt, and the values of the 
Bucketed_Picklist_value__mdt records. 
 
Put another way: 
Bucketed_Picklist__mdt belongs to one object, and one field on that obj 
Bucketed_Picklist_Value__mdt belongs to a single Picklist_Bucket__mdt rec 
Picklist_Bucket__mdt has many Bucketed_Picklist_Value__mdt records and 
belongs to one Bucketed_Picklist__mdt record. 
 
This class help you solve for: What Bucket of values does the sObject 
record belong to in a user-scalable way that doesn&#x27;t require code updates 
to update buckets, values or even add new bucketed picklists.

#### Signature
```apex
public List<Bucketed_Picklist__mdt> getBucketedPicklistsForObject(Id objId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objId | Id |  |

#### Return Type
**List&lt;Bucketed_Picklist__mdt&gt;**

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
| objIds | List&lt;Id&gt; |  |

#### Return Type
**List&lt;Bucketed_Picklist__mdt&gt;**

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
| bPL | List&lt;Bucketed_Picklist__mdt&gt; | Bucketed Picklist list |
| search | String | Search String for Bucketed_Picklist_Value__mdt.label |

#### Return Type
**List&lt;Picklist_Bucket__mdt&gt;**