---
layout: default
---
# Secrets class

A class to encrypt and decrypt (store and retrieve) secrets where the encryption keys are stored as custom settings. Note: Do not use this class, if you're simply storing a user/pass for an api callout - use a named credential instead for that use case.

---
## Properties

### `keyService` → `SecretsKeyService`

### `storageService` → `SecretsStorageService`

---
## Methods
### `Secret(SecretsStorageService storageService,SecretsKeyService keyService,String name,String keyName,String clearTextValue)` → `public`
### `constantTimeCompare(String first, String second)` → `Boolean`
### `decryptSecret()` → `String`
### `hydrateSecret(List<String> secretData)` → `Void`
### `throwIfSecretHasBeenTamperedWith()` → `void`
### `updateSecret(String newValue)` → `Void`
### `validateSecretFormat(String secretString)` → `List<String>`
---
## Inner Classes

### Secrets.Secret class
---
#### Constructors
##### `Secret()`
##### `Secret(SecretsStorageService storageService,SecretsKeyService keyService,String name)`
---
#### Properties

##### `algorithm` → `String`

##### `clearTextValue` → `String`

##### `encodedEncryptedValue` → `Blob`

##### `hmacAlgorithmPayload` → `String`

##### `hmacPayload` → `String`

##### `key` → `Blob`

##### `keyName` → `String`

##### `keyService` → `SecretsKeyService`

##### `name` → `String`

##### `storageService` → `SecretsStorageService`

---
### Secrets.SecretException class
---
#### Methods
##### `Secrets(SecretsStorageService storageService)` → `public`
##### `Secrets()` → `public`
##### `createKey(String keyName)` → `Boolean`
##### `createSecret(String secretName,String secretValue,String keyName)` → `Secret`
##### `fetchDecryptedSecretValue(String secretName)` → `String`
##### `fetchSecret(String secretName)` → `Secrets.Secret`
---
