# PlatformCacheBuilderRecipes Class

demonstrates how to use the Cache.CacheBuilder Interface

**Implements**

Cache.CacheBuilder

## Methods
### `doLoad(key)`

The doLoad method is required by the CacheBuilder interface 
This method needs to return an Object - and that&#x27;s the key to the Cache 
builder interface - You must have this method return a single Object that 
is either calculated by this method, or returned from the Cache by the 
key

#### Signature
```apex
public Object doLoad(String key)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String | String used to help generate the Cache Key |

#### Return Type
**Object**

Oject that should be casted at the call location

#### Example
Account[] accounts &#x3D; (Account[]) Cache.Session.get(PlatformCacheBuilderRecipes.class, &#x27;myAccounts&#x27;)