# MetadataTriggerService
## Constructors
### `public MetadataTriggerService(String objectTypeName)`
---
## Fields

### `private objType` → `String`


---
## Methods
### `public List<Metadata_Driven_Trigger__mdt> getMetadataTriggers()`

`SUPPRESSWARNINGS`

This query finds an ordered list trigger handler classes to execute. It ignores any classes that are marked as disabled. Note: It will exclude any triggerHandler metadata records for which the user's email address is found in a related disabled_for__mdt record. Admin's and Developers can selectively disable trigger handlers for all or selected individuals *without* deploying.

#### Returns

|Type|Description|
|---|---|
|`List<Metadata_Driven_Trigger__mdt>`|`List<Metadata_Driven_Trigger__mdt>`|

### `public static String getSObjectType()`

This determines the active sObject type by describing the first record in the trigger New / Old list

#### Returns

|Type|Description|
|---|---|
|`String`|`String`|

---
## Classes
### MetadataTriggerServiceException

**Inheritance**

MetadataTriggerServiceException


---
