---
layout: default
---
# CanTheUser class

A reusable, intuitive library for determing wether or not the current use can create, read, edit, or delete objects as well as determining if the user has access or update permissions on specific fields. This class name was chosen to facilitate easy-to-understand and read code. Whenever you need to check FLS or CRUD access your code reads like this `if(CanTheUser.read(new account())){}` making the calling and use of this code easy and intuitive.

---
## Enums
### CrudType

### FLSType

---
## Properties

### `accessibleFieldsByObject` → `Set<String>>`

### `updatableFieldsByObject` → `Set<String>>`

---
## Methods
### `bulkFLSAccessible(String obj,Set<String> fields)` → `Boolean>`

bulk form of flsAccessible

#### Parameters
|Param|Description|
|-----|-----------|
|`obj` |     Obj name on which to check |
|`fields` |  Set of Fields to check for accessibility. |

#### Example
```java
String[] fields = new String[]{'Name', 'ShippingStreet'};
System.debug(CanTheuser.bulkFLSAccessible('Account', fields));
```

### `bulkFLSUpdatable(String obj,Set<String> fields)` → `Boolean>`

bulk form of flsUpdatable call

#### Parameters
|Param|Description|
|-----|-----------|
|`obj` |     Name of the object |
|`fields` |  Set of Field names to check |

#### Example
```java
String[] fields = new String[]{'Name', 'ShippingStreet'};
System.debug(CanTheuser.bulkFLSUpdatable('Account', fields));
```

### `create(SObject obj)` → `Boolean`

convenience api for determining if the running user can create the specified object

#### Parameters
|Param|Description|
|-----|-----------|
|`obj` |  Object type to check create permissions on |

#### Example
```java
System.debug(CanTheUser.create(new Account()));
```

### `crud(SObject obj, CrudType permission)` → `Boolean`
#### Parameters
|Param|Description|
|-----|-----------|
|`obj` |  the object type to check |
|`permission` |  create, read, update or delete |

#### Example
```java
System.debug(CanTheUser.crud(new Account(), CanTheUser.CrudType.READ));
```

### `destroy(SObject obj)` → `Boolean`

convenience api for determining if the running user can delete/destroy the specified object

#### Parameters
|Param|Description|
|-----|-----------|
|`obj` |  object type to check destroy permissions on |

#### Example
```java
System.debug(CanTheUser.destroy(new Account()));
```

### `edit(SObject obj)` → `Boolean`

convenience api for determining if the running user can edit / update the specified object

#### Parameters
|Param|Description|
|-----|-----------|
|`obj` |  object type to check edit permissions on |

#### Example
```java
System.debug(CanTheUser.edit(new Account()));
```

### `flsAccessible(String obj, String field)` → `Boolean`

public method to determine if a given field on a given object is Accessible (readable)

#### Parameters
|Param|Description|
|-----|-----------|
|`obj` |  the object in question, in string form |
|`field` |  the field in question in SObjectField form |

#### Example
```java
System.debug(CanTheuser.flsAccessible('Account', 'Name'));
```

### `flsUpdatable(String obj, String field)` → `Boolean`

public method to determine if a given field on a given object is Updatable.

#### Parameters
|Param|Description|
|-----|-----------|
|`obj` |  the string version of an object name |
|`field` |  the field to check |

#### Example
```java
System.debug(CanTheuser.flsUpdatable('Account', 'Name'));
```

### `getFLSForFieldOnObject(String obj,String field,FLSType checkType)` → `Boolean`

Abstracted method for retrieving or calculating (memoization) of the FLS for a given field on a given object.

#### Parameters
|Param|Description|
|-----|-----------|
|`obj` |        String version of object name to check |
|`field` |      String version of the field to check |
|`checkType` |  Enum of Accessible or Updatable. |

### `memoizeFLSMDC(String objType, FLSType action)` → `set<String>`

Utilizes the Metadata catalog to determine FLS Note: this method contains a false-positive PMD violation. Normally, we'd want to check for FLS/CRUD here, but for metadata catalog objects that admins cannot remove permissions to we're ok. Additionally, even the minimum access profile user has read access to the FieldPermissions object.

#### Parameters
|Param|Description|
|-----|-----------|
|`objType` |  String version of the object type to check |
|`action` |   Enum of the FLS action to check permissions for |

### `read(SObject obj)` → `Boolean`

convenience api for determining if the running user can read / access the specified object

#### Parameters
|Param|Description|
|-----|-----------|
|`obj` |  object type to check read permissions on |

#### Example
```java
System.debug(CanTheUser.read(new Account()));
```

---
## Inner Classes

### CanTheUser.CanTheUserException class

Internal custom exception class

---
### CanTheUser.PermissionCache class

 Description this cachebuilder interface allows the CanTheUser clas to cache per-object results for each object requested. This prevents the need to repeatedly calculate permission usage by calling Schema.Describe* calls

---
#### Methods
##### `calculateFLS(string objType)` → `Boolean>>`
##### `doLoad(string objType)` → `Object`

Required method for the CacheBuilder interface. Used here to either calcuate an objects per-user FLS, OR to return it from Cache. The return datastructure for this is Map<String, Map<FLSType,Boolean>> and represents: FieldName -> FLStype -> True/False

###### Parameters
|Param|Description|
|-----|-----------|
|`objType` |  String object name used as the cache key |

---
