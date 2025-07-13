# MetadataTriggerService Class

## Fields
### `objType`

#### Signature
```apex
private objType
```

#### Type
String

## Constructors
### `MetadataTriggerService(objectTypeName)`

#### Signature
```apex
public MetadataTriggerService(String objectTypeName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objectTypeName | String |  |

## Methods
### `getMetadataTriggers()`

`SUPPRESSWARNINGS`

This query finds an ordered list trigger handler classes 
to execute. It ignores any classes that are marked as disabled. 
 
Note: It will exclude any `triggerHandler` metadata records for which 
the user&#x27;s email address is found in a related `Disabled_for__mdt` 
record. 
 
Admin&#x27;s and Developers can selectively disable trigger handlers 
for all or selected individuals *without* deploying.

#### Signature
```apex
public List<Metadata_Driven_Trigger__mdt> getMetadataTriggers()
```

#### Return Type
**List&lt;Metadata_Driven_Trigger__mdt&gt;**

---

### `getSObjectType()`

This determines the active sObject type by describing the first 
record in the trigger New / Old list

#### Signature
```apex
public static String getSObjectType()
```

#### Return Type
**String**

## Classes
### MetadataTriggerServiceException Class