---
layout: default
---
# MetadataTriggerService class
---
## Constructors
### `MetadataTriggerService(String objectTypeName)`
---
## Properties

### `objType` → `String`

---
## Methods
### `getMetadataTriggers()` → `List<Metadata_Driven_Trigger__mdt>`

This query finds an ordered list trigger handler classes to execute. It ignores any classes that are marked as disabled. Note: It will exclude any triggerHandler metadata records for which the user&apos;s email address is found in a related disabled_for__mdt record. Admin&apos;s and Developers can selectively disable trigger handlers for all or selected individuals *without* deploying.

#### Return

**Type**

List&lt;Metadata_Driven_Trigger__mdt&gt;

**Description**

`List&lt;Metadata_Driven_Trigger__mdt&gt;`

### `getSObjectType()` → `String`

This determines the active sObject type by describing the first record in the trigger New / Old list

#### Return

**Type**

String

**Description**

`String`

---
## Inner Classes

### MetadataTriggerService.MetadataTriggerServiceException class
---
