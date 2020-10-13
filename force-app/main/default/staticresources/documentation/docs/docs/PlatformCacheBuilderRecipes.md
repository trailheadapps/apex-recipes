---
layout: default
---
# PlatformCacheBuilderRecipes class

demonstrates how to use the Cache.CacheBuilder Interface

---
## Methods
### `doLoad(String key)` → `Object`

The doLoad method is required by the CacheBuilder interface This method needs to return an Object - and that's the key to the Cache builder interface - You must have this method return a single Object that is either calculated by this method, or returned from the Cache by the key

#### Parameters
|Param|Description|
|-----|-----------|
|`key` |    String used to help generate the Cache Key |

#### Example
```java
Account[] accounts = (Account[]) Cache.Session.get(PlatformCacheBuilderRecipes.class, 'myAccounts')
```

---
