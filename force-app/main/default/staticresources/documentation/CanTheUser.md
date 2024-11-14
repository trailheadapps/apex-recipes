# CanTheUser Class

A reusable, intuitive library for determining wether or not the 
current use can create, read, edit, or delete objects as well as 
determining if the user has access or update permissions on specific fields. 
This class name was chosen to facilitate easy-to-understand and read code. 
Whenever you need to check FLS or CRUD access your code reads like this 
 `if(CanTheUser.read(new account())){}` making the calling and use of this 
code easy and intuitive.

**Group** Security Recipes

## Fields
### `accessibleFieldsByObject`

`TESTVISIBLE`

#### Signature
```apex
private static accessibleFieldsByObject
```

#### Type
Map&lt;String,Set&lt;String&gt;&gt;

---

### `updatableFieldsByObject`

`TESTVISIBLE`

#### Signature
```apex
private static updatableFieldsByObject
```

#### Type
Map&lt;String,Set&lt;String&gt;&gt;

## Methods
### `crud(obj, permission)`

#### Signature
```apex
public static Boolean crud(SObject obj, CrudType permission)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | SObject | the object type to check |
| permission | CrudType | create, read, update or delete |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.crud(new Account(), CanTheUser.CrudType.READ));
```

---

### `crud(objs, permission)`

`TESTVISIBLE`

#### Signature
```apex
private static Boolean crud(List<SObject> objs, CrudType permission)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objs | List&lt;SObject&gt; |  |
| permission | CrudType |  |

#### Return Type
**Boolean**

---

### `crud(objectName, permission)`

`TESTVISIBLE`

#### Signature
```apex
private static Boolean crud(String objectName, CrudType permission)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objectName | String |  |
| permission | CrudType |  |

#### Return Type
**Boolean**

---

### `create(obj)`

convenience api for determining if the running user can 
create the specified object

#### Signature
```apex
public static Boolean create(SObject obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | SObject | Object type to check create permissions on |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.create(new Account()));
```

---

### `create(objs)`

convenience api for determining if the running user can 
create the specified object

#### Signature
```apex
public static Boolean create(List<SObject> objs)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objs | List&lt;SObject&gt; | list of objects. Only the first will be checked. (logically, a list is of uniform type 
and, and if the user can create one) |

#### Return Type
**Boolean**

---

### `create(objName)`

convenience api for determining if the running user can 
create the specified object

#### Signature
```apex
public static Boolean create(String objName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objName | String |  |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.create('Account'));
```

---

### `read(obj)`

convenience api for determining if the running user can 
read / access the specified object

#### Signature
```apex
public static Boolean read(SObject obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | SObject | object type to check read permissions on |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.read(new Account()));
```

---

### `read(objs)`

convenience api for determining if the running user can 
read / access the specified objects

#### Signature
```apex
public static Boolean read(List<SObject> objs)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objs | List&lt;SObject&gt; |  |

#### Return Type
**Boolean**

---

### `read(objName)`

convenience api for determining if the running user can 
read the specified object

#### Signature
```apex
public static Boolean read(String objName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objName | String |  |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.read('Account'));
```

---

### `edit(obj)`

convenience api for determining if the running user can 
edit / update the specified object

#### Signature
```apex
public static Boolean edit(SObject obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | SObject | object type to check edit permissions on |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.edit(new Account()));
```

---

### `edit(objs)`

convenience api for determining if the running user can 
edit / update the specified objects

#### Signature
```apex
public static Boolean edit(List<SObject> objs)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objs | List&lt;SObject&gt; |  |

#### Return Type
**Boolean**

---

### `edit(objName)`

convenience api for determining if the running user can 
edit the specified object

#### Signature
```apex
public static Boolean edit(String objName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objName | String |  |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.edit('Account'));
```

---

### `ups(obj)`

convenience api for determining if the running user can 
upsert (insert and update) the specified objects

#### Signature
```apex
public static Boolean ups(SObject obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | SObject | object type to check edit permissions on |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.ups(new Account()));
```

---

### `ups(objs)`

convenience api for determining if the running user can 
edit / update the specified objects

#### Signature
```apex
public static Boolean ups(List<SObject> objs)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objs | List&lt;SObject&gt; |  |

#### Return Type
**Boolean**

---

### `ups(objName)`

convenience api for determining if the running user can 
upsert the specified object

#### Signature
```apex
public static Boolean ups(String objName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objName | String |  |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.ups('Account'));
```

---

### `destroy(obj)`

convenience api for determining if the running user can 
delete/destroy the specified object

#### Signature
```apex
public static Boolean destroy(SObject obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | SObject | object type to check destroy permissions on |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.destroy(new Account()));
```

---

### `destroy(objs)`

convenience api for determining if the running user can 
delete the specified object

#### Signature
```apex
public static Boolean destroy(List<SObject> objs)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objs | List&lt;SObject&gt; |  |

#### Return Type
**Boolean**

---

### `destroy(objName)`

convenience api for determining if the running user can 
delete the specified object

#### Signature
```apex
public static Boolean destroy(String objName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objName | String |  |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.destroy('Account'));
```

---

### `flsAccessible(obj, field)`

public method to determine if a given field on a given 
object is Accessible (readable)

#### Signature
```apex
public static Boolean flsAccessible(String obj, String field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | String | the object in question, in string form |
| field | String | the field in question in SObjectField form |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.flsAccessible('Account', 'Name'));
```

---

### `bulkFLSAccessible(obj, fields)`

bulk form of flsAccessible

#### Signature
```apex
public static Map<String,Boolean> bulkFLSAccessible(String obj, Set<String> fields)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | String | Obj name on which to check |
| fields | Set&lt;String&gt; | Set of Fields to check for accessibility. |

#### Return Type
**Map&lt;String,Boolean&gt;**

#### Example
```apex
String[] fields = new String[]{'Name', 'ShippingStreet'};
System.debug(CanTheUser.bulkFLSAccessible('Account', fields));
```

---

### `flsUpdatable(obj, field)`

public method to determine if a given field on a given 
object is Updatable.

#### Signature
```apex
public static Boolean flsUpdatable(String obj, String field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | String | the string version of an object name |
| field | String | the field to check |

#### Return Type
**Boolean**

#### Example
```apex
System.debug(CanTheUser.flsUpdatable('Account', 'Name'));
```

---

### `bulkFLSUpdatable(obj, fields)`

bulk form of flsUpdatable call

#### Signature
```apex
public static Map<String,Boolean> bulkFLSUpdatable(String obj, Set<String> fields)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | String | Name of the object |
| fields | Set&lt;String&gt; | Set of Field names to check |

#### Return Type
**Map&lt;String,Boolean&gt;**

#### Example
```apex
String[] fields = new String[]{'Name', 'ShippingStreet'};
System.debug(CanTheUser.bulkFLSUpdatable('Account', fields));
```

---

### `memoizeFLSMDC(objType, action)`

`SUPPRESSWARNINGS`
`TESTVISIBLE`

Utilizes the Metadata catalog to determine FLS 
 
Note: this method contains a false-positive PMD violation. 
Normally, we&#x27;d want to check for FLS/CRUD here, but for metadata catalog 
objects that admins cannot remove permissions to we&#x27;re ok. 
 
Additionally, even the minimum access profile user has read access 
to the FieldPermissions object.

#### Signature
```apex
private static Set<String> memoizeFLSMDC(String objType, FLSType action)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| objType | String | String version of the object type to check |
| action | FLSType | Enum of the FLS action to check permissions for |

#### Return Type
**Set&lt;String&gt;**

---

### `getFLSForFieldOnObject(obj, field, checkType)`

Abstracted method for retrieving or calculating 
(memoization) of the FLS for a given field on a given object.

#### Signature
```apex
private static Boolean getFLSForFieldOnObject(String obj, String field, FLSType checkType)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | String | String version of object name to check |
| field | String | String version of the field to check |
| checkType | FLSType | Enum of Accessible or Updatable. |

#### Return Type
**Boolean**

## Classes
### CanTheUserException Class

Internal custom exception class

### PermissionCache Class

this cachebuilder interface allows the CanTheUser class to 
cache per-object results for each object requested. This prevents the 
need to repeatedly calculate permission usage by calling 
Schema.Describe* calls

**Implements**

Cache.CacheBuilder

#### Methods
##### `doLoad(objType)`

Required method for the CacheBuilder interface. Used 
here to either calculate an objects per-user FLS, OR to return it 
from Cache. 
The return datastructure for this is 
Map&lt;String, Map&lt;FLSType,Boolean&gt;&gt; and represents: 
FieldName -&gt; FLStype -&gt; True/False

###### Signature
```apex
public Object doLoad(String objType)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| objType | String | String object name used as the cache key |

###### Return Type
**Object**

---

##### `calculateFLS(objType)`

Calculates the FLS for a given object type

###### Signature
```apex
public Map<String,Map<FLSType,Boolean>> calculateFLS(string objType)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| objType | string | String name of the object type |

###### Return Type
**Map&lt;String,Map&lt;FLSType,Boolean&gt;&gt;**

## Enums
### CrudType Enum

#### Values
| Value | Description |
|-------|-------------|
| CREATE |  |
| READ |  |
| EDIT |  |
| DEL |  |
| UPS |  |
### FLSType Enum

#### Values
| Value | Description |
|-------|-------------|
| ACCESSIBLE |  |
| UPDATABLE |  |