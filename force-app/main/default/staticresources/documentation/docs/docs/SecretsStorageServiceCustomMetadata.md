---
layout: default
---
# SecretsStorageServiceCustomMetadata class
---
## Constructors
### `SecretsStorageServiceCustomMetadata(SecretsKeyStorageService keyService)`
### `SecretsStorageServiceCustomMetadata(SecretsKeyStorageService keyService,EncryptionAlgorithm encyryptionAlgo,HmacAlgorithm hmacAlgo,Integer keySize)`
### `SecretsStorageServiceCustomMetadata()`
---
## Enums
### EncryptionAlgorithm

### HmacAlgorithm

---
## Properties

### `ENCRYPTION_ALGO` → `EncryptionAlgorithm`

### `ENCRYPTION_KEYSIZE` → `Integer`

### `HMAC_ALGO` → `HmacAlgorithm`

### `keyService` → `SecretsKeyStorageService`

---
## Methods
### `constantTimeCompare(String first, String second)` → `Boolean`
### `createAndDispatchMetadataRecordCreation(string itemName,String serializedValue)` → `Void`
### `createKey(String keyName)` → `Boolean`
### `encryptValueWithKey(String keyName, string clearText)` → `Blob`
### `fetchEncryptedValue(String itemName)` → `String`
### `getEncodedHMAC(string integrityValue, Blob encryptedValue)` → `String`
### `getKey(String keyName)` → `Blob`
### `retrieve(string itemName)` → `SecretsData`
### `serializeSecret(String keyName,String encodedEncryptedValue,String hmac)` → `string`
### `store(String keyName, string itemName, String clearText)` → `Boolean`
### `throwIfSecretHasBeenTamperedWith(string itemName,String payloadHmac,String payloadHmacAlgorithm,Blob payloadEncryptedValue)` → `void`
### `validateSecretFormat(String secretString)` → `List<String>`
---
## Inner Classes

### SecretsStorageServiceCustomMetadata.SecretsDeploymentCallback class
---
#### Methods
##### `handleResult(Metadata.DeployResult result,Metadata.DeployCallbackContext context)` → `void`
---
### SecretsStorageServiceCustomMetadata.SecretsStorageServiceException class
---
