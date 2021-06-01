---
layout: default
---
# Secrets class

A class to encrypt and decypt (store and retrieve) secrets that require two-factor usage. Note: Do not use this class, if you're simply storing a user/pass for an api callout - use a named credential instead for that use case.

---
## Properties

### `DEFAULTKEY` → `String`

### `ENCRYPTIONALGO` → `String`

### `key` → `Blob`

### `memoizedKey` → `Blob`

---
## Methods
### `boostrapKey()` → `String`
### `fetchSecret(String secretName)` → `String`
### `storeSecret(String secretName, String secret)` → `Boolean`
---
## Inner Classes

### Secrets.SecretDeployCallback class
---
#### Methods
##### `handleResult(Metadata.DeployResult result,Metadata.DeployCallbackContext context)` → `void`
---
### Secrets.SecretException class
---
