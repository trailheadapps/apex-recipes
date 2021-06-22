---
layout: default
---
# SecretsKeyServiceCustomSettings class

Concrete implementation of the SecretsKeyStorageService interface that stores the keys inside custom settings. Note, as a reminder, custom settings are not deployable and are thus not able to be put in SCM.

## Related

Secrets, SecretsKeyStorageService

---
## Properties

### `memoizedKeys` → `Blob>`

 Because retrieving keys can be a time consuming, or query burning activity, this code 'memoizes' the keys previously accessed in this transaction

---
## Methods
### `createKey(String keyName, Integer keySize)` → `Boolean`

Creates a new key and stores it in custom settings

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |  Name of the key |
|`keySize` |  Size of the key |

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `getKey(String keyName)` → `Blob`

Retrieves the key from custom settings

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |  Name of the key to return |

#### Return

**Type**

Blob

**Description**

`Blob`

### `queryForKey(String keyName)` → `List<Secrets__c>`

Method uses Soql to query Key

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |  Name of the key to find |

#### Return

**Type**

List<Secrets__c>

**Description**

`List<Secrets__c>`

### `writeKey(String keyName, Integer keySize)` → `Boolean`

Method to generate a new random encryption key

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |  Name of the key to generate |
|`keySize` |  Size of the key to generate |

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `writeKey(String keyName, String keyValue)` → `Boolean`

Method to write a new encryption key with a specified value

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |   Name of the key to generate |
|`keyValue` |  Value to give the key |

#### Return

**Type**

Boolean

**Description**

`Boolean`

---
## Inner Classes

### SecretsKeyServiceCustomSettings.SecretsKeyServiceException class

internally used exception subclass.

---
