---
layout: default
---
# SecretsVaultCustomMetadata class

This implementation of SecretsStorageService is focused on the acceptance and storage of Hashicorp's Vault format.

---
## Constructors
### `SecretsVaultCustomMetadata(SecretsKeyStorageService keyService)`

Constructor requiring injected keyService
#### Parameters
|Param|Description|
|-----|-----------|
|`keyService` |  Key service instance |

---
## Properties

### `keyService` → `SecretsKeyStorageService`

### `storageBase` → `SecretsCustomMetadataStorageBase`

---
## Methods
### `createKey(String keyName)` → `Boolean`

Required to conform to interface, but not used in this implementation

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |  Name to use |

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `decryptData(String keyName,String itemName,String cipherText)` → `String`

Makes a callout to Hashicorp's Vault service and retrieves the secret data from there.

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |     Key to use |
|`itemName` |    Secret to fetch |
|`cipherText` |  Local encrypted version of the secret |

#### Return

**Type**

String

**Description**

`String`

### `encryptData(String keyName,String itemName,String clearText)` → `String`

Encrypts a clear text String and stores it in Hashicorp's Vault. Note this relies on a named credential being setup.

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |    Key to use |
|`itemName` |   Name of the secret |
|`clearText` |  Unencrypted String to encrypt |

#### Return

**Type**

String

**Description**

`String`

### `retrieve(String itemName)` → `SecretsData`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

#### Return

**Type**

SecretsData

**Description**

`SecretsData`

### `store(String keyName, String itemName, String clearText)` → `Boolean`

Required to conform to interface, but not used in this implementation

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |    Key to use |
|`itemName` |   Name of the Secret |
|`clearText` |  Clear text to encode/encrypt |

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `validateSecretFormat(String secretString)` → `List<String>`

Validates that the stored secret string matches the expected format.

#### Parameters
|Param|Description|
|-----|-----------|
|`secretString` |  Retrieved Secret string. |

#### Return

**Type**

List<String>

**Description**

`List<String>`

---
