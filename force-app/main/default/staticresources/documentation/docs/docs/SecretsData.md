---
layout: default
---
# SecretsData class

This class is a data-model class. It represents a `Secret` - a piece of information that is: encrypted at rest. deployable. useless without metadata that cannot be deployed. Functionally, the Secrets family of recipes separate the encrypted data and the decryption keys into two different storage mediums. Secrets themselves are stored in Custom Metadata. Keys, however, are stored in Custom Settings. Because custom settings are not deployable, the secrets records themselves are safe to be committed to SCM.

## Related

[Secrets](https://github.com/trailheadapps/apex-recipes/wiki/Secrets.md)

---
## Properties

### `clearTextValue` → `String`

### `encryptedValue` → `String`

### `keyName` → `String`

### `name` → `String`

---
