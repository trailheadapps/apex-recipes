---
layout: default
---
# VaultEncrypt class

Data transfer object describing the Hashicorp Vault encryption and decryption payload.

## Related

Secrets, SecretsVaultCustomMetadata

---
## Properties

### `data` → `Data`

### `lease_duration` → `Integer`

### `lease_id` → `String`

### `renewable` → `Boolean`

### `request_id` → `String`

---
## Methods
### `parse(String json)` → `VaultEncrypt`
---
## Inner Classes

### VaultEncrypt.Data class
---
#### Properties

##### `ciphertext` → `String`

##### `key_version` → `Integer`

##### `plaintext` → `String`

---
