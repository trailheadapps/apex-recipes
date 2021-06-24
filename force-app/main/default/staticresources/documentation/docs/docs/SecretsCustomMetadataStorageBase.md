---
layout: default
---
# SecretsCustomMetadataStorageBase class

Base class for storing secrets in custom metadata.

## Related

Secrets, SecretsStorageServiceCustomMetadata

---
## Properties

### `queryService` → `SecretsCustomMetadataQueryService`

---
## Methods
### `createAndDispatchMetadataRecordCreation(string itemName,String serializedValue)` → `Void`

This method is responsible for creating new metadata records, and triggering a metadata deploy to save them. Note: don't forget that custom metadata records cannot be inserted/updated with dml.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |
|`` | e |

#### Return

**Type**

Void

**Description**

`Void`

### `fetchEncryptedValue(String itemName)` → `String`

This method is responsible for retrieving the encrypted data from the custom metadata. It's built out as it's own method so that this method can be stubbed during unit testing.

---
## Inner Classes

### SecretsCustomMetadataStorageBase.SecretsDeploymentCallback class

This is the callback method fired after a metadata deployment. This implementation doesn't do much, other than log success or failure; but this is here to demonstrate how you can hook into the deployment process after a new metadata backed secret is stored.

---
#### Methods
##### `handleResult(Metadata.DeployResult result,Metadata.DeployCallbackContext context)` → `void`
---
### SecretsCustomMetadataStorageBase.SecretsStorageServiceException class

 Custom exception used by storage providers.

---
