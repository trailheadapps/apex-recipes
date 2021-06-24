---
layout: default
---
# Secrets class

A class to encrypt and decrypt (store and retrieve) secrets where the encryption keys are stored as custom settings. Note: Do not use this class, if you're simply storing a user/pass for an api callout - use a named credential instead for that use case.

## Related

[Secrets](https://github.com/trailheadapps/apex-recipes/wiki/Secrets.md)

---
## Constructors
### `Secrets(SecretsStorageService storageService)`

Standard constructor - requires a Storage Service instance.
#### Parameters
|Param|Description|
|-----|-----------|
|`storageService` |  Any object conforming to the SecretsStorageService |

---
## Properties

### `storageService` → `SecretsStorageService`

---
## Methods
### `createKey(String keyName)` → `Boolean`

Creates a new Key to encrypt secrets with. Note: keys are immutable and cannot be updated.

### `createSecret(String secretName,String secretValue,String keyName)` → `Boolean`

Creates a net-new secret. Does not update.

#### Parameters
|Param|Description|
|-----|-----------|
|`secretName` |   Name of the secret to be created |
|`secretValue` |  Clear text of the secret's value - this will be |
|`keyName` |      Key to encrypt the secret with. |

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `fetchSecret(String secretName)` → `SecretsData`

retrieves the named secret and returns an object with the secret's properties.

#### Parameters
|Param|Description|
|-----|-----------|
|`secretName` |  the string naming the secret |

#### Return

**Type**

SecretsData

**Description**

`SecretsData`

### `updateSecret(SecretsData newSecretData)` → `void`

Updates a secret, with the values of the newSecretsData parameter

#### Parameters
|Param|Description|
|-----|-----------|
|`newSecretData` |  The new version of the SecretsData to store. |

---
