---
layout: default
---
# Secrets class

A class to encrypt and decrypt (store and retrieve) secrets where the encryption keys are stored as custom settings. Note: Do not use this class, if you're simply storing a user/pass for an api callout - use a named credential instead for that use case.

---
## Constructors
### `Secrets(SecretsStorageService storageService)`
### `Secrets()`
---
## Properties

### `storageService` → `SecretsStorageService`

---
## Methods
### `createKey(String keyName)` → `Boolean`
### `createSecret(String secretName,String secretValue,String keyName)` → `Boolean`
### `fetchSecret(String secretName)` → `SecretsData`
### `updateSecret(SecretsData newValue)` → `void`
---
## Inner Classes

### Secrets.SecretException class
---
