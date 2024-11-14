# PlatformCacheRecipes Class

Illustrates how to programatically use the Platform Cache 
feature of Salesforce. Many of these recipes are, taken together, not very 
DRY (don&#x27;t repeat yourself). However, they&#x27;re intentionally listed here as a 
way of repeatedly demonstrating Platform Cache functionality

**Group** Platform Cache Recipes

## Fields
### `DEFAULT_PARTITION`

Defines the default cache partition for use in this class.

#### Signature
```apex
private static final DEFAULT_PARTITION
```

#### Type
String

## Methods
### `storeValueInSessionCache(key, value)`

These methods are for the Session Cache 
Max TTL for Session partion is 8 hours.

#### Signature
```apex
public static void storeValueInSessionCache(String key, String value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String |  |
| value | String |  |

#### Return Type
**void**

---

### `storeValueInSessionCache(key, value, ttl)`

Stores a value in the Session cache with a custom timeout.

#### Signature
```apex
public static void storeValueInSessionCache(String key, String value, Integer ttl)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String | key under which the value is saved. |
| value | String | value to store in the cache |
| ttl | Integer | Time To Live (ttl) is the number of seconds this 
item will remain in cache. |

#### Return Type
**void**

---

### `getValueFromSessionCache(key)`

Retrieves a value from the cache identified by key

#### Signature
```apex
public static String getValueFromSessionCache(String key)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String | key of which value to retrieve. |

#### Return Type
**String**

the value

---

### `removeKeyFromSessionCache(key)`

removes a key/value from the cache manually

#### Signature
```apex
public static void removeKeyFromSessionCache(String key)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String | key to remove |

#### Return Type
**void**

#### Throws
CacheException: custom exception when key not found.

---

### `storeValueInOrgCache(key, value)`

These methods relate to the ORG cache 
Max TTL for Org Cache is 48 hours.

#### Signature
```apex
public static void storeValueInOrgCache(String key, String value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String |  |
| value | String |  |

#### Return Type
**void**

---

### `storeValueInOrgCache(key, value, ttl)`

Stores a value in the Org cache with a custom timeout.

#### Signature
```apex
public static void storeValueInOrgCache(String key, String value, Integer ttl)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String | key under which the value is saved. |
| value | String | value to store in the cache. |
| ttl | Integer | Time To Live (ttl) is the number of seconds this 
item will remain in cache. |

#### Return Type
**void**

---

### `getValueFromOrgCache(key)`

Retrieves a value from the cache identified by key

#### Signature
```apex
public static String getValueFromOrgCache(String key)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String | key of which value to retrieve. |

#### Return Type
**String**

the value associated with the supplied key

---

### `removeKeyFromOrgCache(key)`

removes a key/value from the cache manually

#### Signature
```apex
public static void removeKeyFromOrgCache(String key)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String | key to remove |

#### Return Type
**void**

#### Throws
CacheException: custom exception when key not found.

---

### `getDefaultPartition(type)`

returns a partition for a given name, and type

#### Signature
```apex
public static Cache.Partition getDefaultPartition(PartitionType type)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| type | PartitionType | the partition type |

#### Return Type
**Cache.Partition**

the partition

## Classes
### CacheException Class

internal custom exception class.

## Enums
### PartitionType Enum

Enum for partition type.

#### Values
| Value | Description |
|-------|-------------|
| SESSION |  |
| ORG |  |