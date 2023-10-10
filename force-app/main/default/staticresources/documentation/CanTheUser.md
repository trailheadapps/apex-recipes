# CanTheUser

A reusable, intuitive library for determining wether or not the
current use can create, read, edit, or delete objects as well as
determining if the user has access or update permissions on specific fields.
This class name was chosen to facilitate easy-to-understand and read code.
Whenever you need to check FLS or CRUD access your code reads like this
`if(CanTheUser.read(new account())){}` making the calling and use of this
code easy and intuitive.


**Group** Security Recipes

## Fields

### `private accessibleFieldsByObject` → `Map<String,Set<String>>`

`TESTVISIBLE` 

### `private updatableFieldsByObject` → `Map<String,Set<String>>`

`TESTVISIBLE` 

---
## Methods
### `public static Boolean crud(SObject obj, CrudType permission)`
#### Parameters

|Param|Description|
|---|---|
|`obj`|the object type to check|
|`permission`|create, read, update or delete|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.crud(new Account(), CanTheUser.CrudType.READ));
```


### `private static Boolean crud(List<SObject> objs, CrudType permission)`

`TESTVISIBLE`
### `private static Boolean crud(String objectName, CrudType permission)`

`TESTVISIBLE`
### `public static Boolean create(SObject obj)`

convenience api for determining if the running user can create the specified object

#### Parameters

|Param|Description|
|---|---|
|`obj`|Object type to check create permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.create(new Account()));
```


### `public static Boolean create(List<SObject> objs)`

convenience api for determining if the running user can create the specified object

#### Parameters

|Param|Description|
|---|---|
|`objs`|list of objects. Only the first will be checked. (logically, a list is of uniform type and, and if the user can create one)|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

### `public static Boolean create(String objName)`

convenience api for determining if the running user can create the specified object

#### Parameters

|Param|Description|
|---|---|
|`String`|Object type to check create permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.create('Account'));
```


### `public static Boolean read(SObject obj)`

convenience api for determining if the running user can read / access the specified object

#### Parameters

|Param|Description|
|---|---|
|`obj`|object type to check read permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.read(new Account()));
```


### `public static Boolean read(List<SObject> objs)`

convenience api for determining if the running user can read / access the specified objects

#### Parameters

|Param|Description|
|---|---|
|`obj`|object type to check read permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
```


### `public static Boolean read(String objName)`

convenience api for determining if the running user can read the specified object

#### Parameters

|Param|Description|
|---|---|
|`String`|Object type to check read permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.read('Account'));
```


### `public static Boolean edit(SObject obj)`

convenience api for determining if the running user can edit / update the specified object

#### Parameters

|Param|Description|
|---|---|
|`obj`|object type to check edit permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.edit(new Account()));
```


### `public static Boolean edit(List<SObject> objs)`

convenience api for determining if the running user can edit / update the specified objects

#### Parameters

|Param|Description|
|---|---|
|`obj`|object type to check edit permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
```


### `public static Boolean edit(String objName)`

convenience api for determining if the running user can edit the specified object

#### Parameters

|Param|Description|
|---|---|
|`String`|Object type to check edit permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.edit('Account'));
```


### `public static Boolean ups(SObject obj)`

convenience api for determining if the running user can upsert (insert and update) the specified objects

#### Parameters

|Param|Description|
|---|---|
|`obj`|object type to check edit permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.ups(new Account()));
```


### `public static Boolean ups(List<SObject> objs)`

convenience api for determining if the running user can edit / update the specified objects

#### Parameters

|Param|Description|
|---|---|
|`obj`|object type to check upsert permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
```


### `public static Boolean ups(String objName)`

convenience api for determining if the running user can upsert the specified object

#### Parameters

|Param|Description|
|---|---|
|`String`|Object type to check upsert permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.ups('Account'));
```


### `public static Boolean destroy(SObject obj)`

convenience api for determining if the running user can delete/destroy the specified object

#### Parameters

|Param|Description|
|---|---|
|`obj`|object type to check destroy permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.destroy(new Account()));
```


### `public static Boolean destroy(List<SObject> objs)`

convenience api for determining if the running user can delete the specified object

#### Parameters

|Param|Description|
|---|---|
|`String`|Object type to check delete permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

### `public static Boolean destroy(String objName)`

convenience api for determining if the running user can delete the specified object

#### Parameters

|Param|Description|
|---|---|
|`String`|Object type to check create permissions on|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.destroy('Account'));
```


### `public static Boolean flsAccessible(String obj, String field)`

public method to determine if a given field on a given object is Accessible (readable)

#### Parameters

|Param|Description|
|---|---|
|`obj`|the object in question, in string form|
|`field`|the field in question in SObjectField form|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.flsAccessible('Account', 'Name'));
```


### `public static Map<String,Boolean> bulkFLSAccessible(String obj, Set<String> fields)`

bulk form of flsAccessible

#### Parameters

|Param|Description|
|---|---|
|`obj`|Obj name on which to check|
|`fields`|Set of Fields to check for accessibility.|

#### Returns

|Type|Description|
|---|---|
|`Map<String,Boolean>`|`Map<String, Boolean>`|

#### Example
```apex
String[] fields = new String[]{'Name', 'ShippingStreet'};
System.debug(CanTheUser.bulkFLSAccessible('Account', fields));
```


### `public static Boolean flsUpdatable(String obj, String field)`

public method to determine if a given field on a given object is Updatable.

#### Parameters

|Param|Description|
|---|---|
|`obj`|the string version of an object name|
|`field`|the field to check|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
System.debug(CanTheUser.flsUpdatable('Account', 'Name'));
```


### `public static Map<String,Boolean> bulkFLSUpdatable(String obj, Set<String> fields)`

bulk form of flsUpdatable call

#### Parameters

|Param|Description|
|---|---|
|`obj`|Name of the object|
|`fields`|Set of Field names to check|

#### Returns

|Type|Description|
|---|---|
|`Map<String,Boolean>`|`Map<String, Boolean>`|

#### Example
```apex
String[] fields = new String[]{'Name', 'ShippingStreet'};
System.debug(CanTheUser.bulkFLSUpdatable('Account', fields));
```


### `private static Set<String> memoizeFLSMDC(String objType, FLSType action)`

`SUPPRESSWARNINGS`

`TESTVISIBLE`

Utilizes the Metadata catalog to determine FLS Note: this method contains a false-positive PMD violation. Normally, we'd want to check for FLS/CRUD here, but for metadata catalog objects that admins cannot remove permissions to we're ok. Additionally, even the minimum access profile user has read access to the FieldPermissions object.

#### Parameters

|Param|Description|
|---|---|
|`objType`|String version of the object type to check|
|`action`|Enum of the FLS action to check permissions for|

#### Returns

|Type|Description|
|---|---|
|`Set<String>`|`set<String>`|

### `private static Boolean getFLSForFieldOnObject(String obj, String field, FLSType checkType)`

Abstracted method for retrieving or calculating (memoization) of the FLS for a given field on a given object.

#### Parameters

|Param|Description|
|---|---|
|`obj`|String version of object name to check|
|`field`|String version of the field to check|
|`checkType`|Enum of Accessible or Updatable.|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|`Boolean`|

---
## Enums
### CrudType

### FLSType

---
## Classes
### CanTheUserException

Internal custom exception class


**Inheritance**

CanTheUserException


### PermissionCache

this cachebuilder interface allows the CanTheUser class to
cache per-object results for each object requested. This prevents the
need to repeatedly calculate permission usage by calling
Schema.Describe* calls


**Implemented types**

[Cache.CacheBuilder](Cache.CacheBuilder)

#### Methods
##### `public Object doLoad(String objType)`

Required method for the CacheBuilder interface. Used here to either calculate an objects per-user FLS, OR to return it from Cache. The return datastructure for this is Map&lt;String, Map&lt;FLSType,Boolean&gt;&gt; and represents: FieldName -&gt; FLStype -&gt; True/False

###### Parameters

|Param|Description|
|---|---|
|`objType`|String object name used as the cache key|

###### Returns

|Type|Description|
|---|---|
|`Object`|`Object`|

##### `public Map&lt;String,Map&lt;FLSType,Boolean&gt;&gt; calculateFLS(string objType)`

Calculates the FLS for a given object type

###### Parameters

|Param|Description|
|---|---|
|`objType`|String name of the object type|

###### Returns

|Type|Description|
|---|---|
|`Map&lt;String,Map&lt;FLSType,Boolean&gt;&gt;`|`Map&lt;String, Map&lt;FLSType, Boolean&gt;&gt;`|

---

---
