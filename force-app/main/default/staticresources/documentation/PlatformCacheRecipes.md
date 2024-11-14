# PlatformCacheRecipes

Illustrates how to programatically use the Platform Cache
feature of Salesforce. Many of these recipes are, taken together, not very
DRY (don't repeat yourself). However, they're intentionally listed here as a
way of repeatedly demonstrating Platform Cache functionality


**Group** Platform Cache Recipes

## Fields

### `private DEFAULT_PARTITION` → `String`


Defines the default cache partition for use in this class.

---
## Methods
### `public static void storeValueInSessionCache(String key, String value)`

These methods are for the Session Cache
Max TTL for Session partion is 8 hours.

### `public static void storeValueInSessionCache(String key, String value, Integer ttl)`

Stores a value in the Session cache with a custom timeout.

#### Parameters

|Param|Description|
|---|---|
|`key`|key under which the value is saved.|
|`value`|value to store in the cache|
|`ttl`|Time To Live (ttl) is the number of seconds this item will remain in cache.|

### `public static String getValueFromSessionCache(String key)`

Retrieves a value from the cache identified by key

#### Parameters

|Param|Description|
|---|---|
|`key`|key of which value to retrieve.|

#### Returns

|Type|Description|
|---|---|
|`String`|the value|

### `public static void removeKeyFromSessionCache(String key)`

removes a key/value from the cache manually

#### Parameters

|Param|Description|
|---|---|
|`key`|key to remove|

#### Throws

|Exception|Description|
|---|---|
|`CacheException`|custom exception when key not found.|

### `public static void storeValueInOrgCache(String key, String value)`

These methods relate to the ORG cache
Max TTL for Org Cache is 48 hours.

### `public static void storeValueInOrgCache(String key, String value, Integer ttl)`

Stores a value in the Org cache with a custom timeout.

#### Parameters

|Param|Description|
|---|---|
|`key`|key under which the value is saved.|
|`value`|value to store in the cache.|
|`ttl`|Time To Live (ttl) is the number of seconds this item will remain in cache.|

### `public static String getValuefromOrgCache(String key)`

Retrieves a value from the cache identified by key

#### Parameters

|Param|Description|
|---|---|
|`key`|key of which value to retrieve.|

#### Returns

|Type|Description|
|---|---|
|`String`|the value associated with the supplied key|

### `public static void removeKeyFromOrgCache(String key)`

removes a key/value from the cache manually

#### Parameters

|Param|Description|
|---|---|
|`key`|key to remove|

#### Throws

|Exception|Description|
|---|---|
|`CacheException`|custom exception when key not found.|

### `public static Cache.Partition getDefaultPartition(PartitionType type)`

returns a partition for a given name, and type

#### Parameters

|Param|Description|
|---|---|
|`type`|the partition type|

#### Returns

|Type|Description|
|---|---|
|`Cache.Partition`|the partition|

---
## Enums
### PartitionType

Enum for partition type.


---
## Classes
### CacheException

internal custom exception class.


**Inheritance**

CacheException


---
