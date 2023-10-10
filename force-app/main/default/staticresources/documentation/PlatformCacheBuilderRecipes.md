# PlatformCacheBuilderRecipes

demonstrates how to use the Cache.CacheBuilder Interface


**Implemented types**

[Cache.CacheBuilder](Cache.CacheBuilder)

## Methods
### `public Object doLoad(String key)`

The doLoad method is required by the CacheBuilder interface This method needs to return an Object - and that's the key to the Cache builder interface - You must have this method return a single Object that is either calculated by this method, or returned from the Cache by the key

#### Parameters

|Param|Description|
|---|---|
|`key`|String used to help generate the Cache Key|

#### Returns

|Type|Description|
|---|---|
|`Object`|`Object` This object should be casted at the call location|


**Group** Platform Cache Recipes


**See** [CanTheUser](https://github.com/trailheadapps/apex-recipes/wiki/CanTheUser)

#### Example
```apex
Account[] accounts = (Account[]) Cache.Session.get(PlatformCacheBuilderRecipes.class, 'myAccounts')
```


---
