---
layout: default
---
# SecretsStorageService class
---
## Constructors
### `SecretsStorageService(SecretsKeyService keyService)`
### `SecretsStorageService()`
---
## Properties

### `ENCRYPTIONALGORITHM` → `String`

### `HMACALGO` → `String`

### `keyService` → `SecretsKeyService`

### `serializedSecret` → `String`

---
## Methods
### `createAndDispatchMetadataRecordCreation(Secrets.Secret newSecret,String serializedValue)` → `Void`
### `encryptValueWithKey(Secrets.Secret newSecret)` → `Blob`
### `ensureKeyExists(Secrets.Secret newSecret)` → `Void`
### `fetchExistingSecret(String secretName)` → `SecretMDT__mdt`
### `getEncodedHMAC(Secrets.Secret newSecret,Blob encryptedValue)` → `String`
### `serializeSecret(Secrets.secret newSecret,String encodedEncryptedValue,String hmac)` → `string`
### `storeSecret(Secrets.Secret newSecret)` → `Void`
---
## Inner Classes

### SecretsStorageService.SecretStorageServiceException class
---
### SecretsStorageService.SecretsDeploymentCallback class
---
#### Methods
##### `handleResult(Metadata.DeployResult result,Metadata.DeployCallbackContext context)` → `void`
---
