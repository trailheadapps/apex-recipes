---
layout: default
---
# PlatformCacheRecipes class

Illustrates how to programatically use the Platform Cache feature of Salesforce. Many of these recipes are, taken together, not very DRY (don&apos;t repeat yourself). However, they&apos;re intentionally listed here as a way of repeatedly demonstrating Platform Cache functionality

---
## Enums
### PartitionType


 Enum for partition type.

---
## Properties

### `DEFAULTPARTITION` → `String`

Defines the default cache partition for use in this class.

---
## Methods
### `getDefaultPartition(PartitionType type)` → `Cache.Partition`

returns a Cache.Partition for a given name, and type

#### Parameters

| Param | Description |
| ----- | ----------- |
|`type` |   Enum of .SESSION or .ORG |

#### Return

**Type**

Cache.Partition

**Description**

`Cache.Partition`

### `getValueFromSessionCache(String key)` → `String`

Retrieves a value from the cache identified by key

#### Parameters

| Param | Description |
| ----- | ----------- |
|`key` |    String key of which value to retrieve. |

#### Return

**Type**

String

**Description**

`String`

### `getValuefromOrgCache(String key)` → `String`

Retrieves a value from the cache identified by key

#### Parameters

| Param | Description |
| ----- | ----------- |
|`key` |    String key of which value to retrieve. |

#### Return

**Type**

String

**Description**

`String`

### `removeKeyFromOrgCache(String key)` → `void`

removes a key/value from the cache manually

#### Parameters

| Param | Description |
| ----- | ----------- |
|`key` |    String key to remove |

### `removeKeyFromSessionCache(String key)` → `void`

removes a key/value from the cache manually

#### Parameters

| Param | Description |
| ----- | ----------- |
|`key` |    String key to remove |

### `storeValueInOrgCache(String key, String toStore)` → `void`

Stores a value in the Org cache with a default timeout of 3600 seconds (1hr)

#### Parameters

| Param | Description |
| ----- | ----------- |
|`key` |      String name of key used to store the value in the cache. |
|`toStore` |  String value to store in the cache. |

### `storeValueInOrgCache(String key,String toStore,Integer ttl)` → `void`

Stores a value in the Org cache with a custom timeout.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`key` |      String Name to the store the value under. |
|`toStore` |  String to store in the cache |
|`ttl` |      Integer Time To Live (ttl) is the number of seconds this |

### `storeValueInSessionCache(String key, String toStore)` → `void`

Stores a value in the Session cache with a default timeout of 3600 seconds (1hr)

#### Parameters

| Param | Description |
| ----- | ----------- |
|`key` |      String name of key used to store the value in the cache. |
|`toStore` |  String value to store in the cache. |

### `storeValueInSessionCache(String key,String toStore,Integer ttl)` → `void`

Stores a value in the Session cache with a custom timeout.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`key` |      String Name to the store the value under. |
|`toStore` |  String to store in the cache |
|`ttl` |      Integer Time To Live (ttl) is the number of seconds this |

---
## Inner Classes

### PlatformCacheRecipes.CacheException class

internal custom exception class.

---
