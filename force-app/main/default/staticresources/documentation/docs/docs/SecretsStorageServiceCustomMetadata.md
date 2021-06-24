---
layout: default
---
# SecretsStorageServiceCustomMetadata class

concrete implementation of a secrets storage service. It features a base class that can be overridden / dependency injected and implements the Secrets Storage Service interface. Note: the design of the Secrets storage and key service are an example of the repository software pattern. To find out more about this pattern please see https://martinfowler.com/eaaCatalog/repository.html

---
## Constructors
### `SecretsStorageServiceCustomMetadata(SecretsKeyStorageService keyService)`

Standard constructor. This constructor assumes the defaults of this class are desired.
#### Parameters
|Param|Description|
|-----|-----------|
|`keyService` |  An instance of a class implementing the KeyService |

### `SecretsStorageServiceCustomMetadata(SecretsKeyStorageService keyService,EncryptionAlgorithm encryptionAlgo,HmacAlgorithm hmacAlgo,Integer keySize)`

Standard constructor. This constructor allows developers to override the defaults specified above, so long as the encryptionAlgo and hmacAlgo are valid enums.
#### Parameters
|Param|Description|
|-----|-----------|
|`keyService` |       A valid instance of a class implementing the |
|`encryptionAlgo` |   A valid ENUM from above |
|`hmacAlgo` |         A valid ENUM from above |
|`keySize` |          Integer key size. |

---
## Enums
### EncryptionAlgorithm


enum of allowed encryption algorithms.

### HmacAlgorithm


enum of allowed hmac algorithms.

---
## Properties

### `encryptionAlgo` → `EncryptionAlgorithm`

### `encryptionKeySize` → `Integer`

### `hmacAlgo` → `HmacAlgorithm`

### `keyService` → `SecretsKeyStorageService`

### `serializedSecret` → `String`

### `storageBase` → `SecretsCustomMetadataStorageBase`

---
## Methods
### `constantTimeCompare(String first, String second)` → `Boolean`

An approximate constant time comparison algorithm

#### Parameters
|Param|Description|
|-----|-----------|
|`first` |   first string to compare |
|`second` |  second string to compare |

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `createKey(String keyName)` → `Boolean`

convenience method for creating a key. Pass through to the injected KeyService implementation.

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |  Name to give this Key. |

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `encryptValueWithKey(String keyName, String clearText)` → `Blob`

Encrypts the given clear text with the specified key.

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |    Key to retrieve and use for encryption |
|`clearText` |  clearText to encrypt. |

#### Return

**Type**

Blob

**Description**

`Blob`

### `generateBase64EncodedHMAC(String integrityValue,Blob encryptedValue)` → `String`

Generates the hmac for this secret and encodes it.

#### Parameters
|Param|Description|
|-----|-----------|
|`integrityValue` |  name of the secret |
|`encryptedValue` |  encrypted blob. |

#### Return

**Type**

String

**Description**

`String`

### `getKey(String keyName)` → `Blob`

Passthrough convenience method for retrieving the key.

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |  Name of the key to retrieve. |

#### Return

**Type**

Blob

**Description**

`Blob`

### `retrieve(String itemName)` → `SecretsData`

Finds and decrypts a secret, if appropriate conditions are met.

#### Parameters
|Param|Description|
|-----|-----------|
|`itemName` |  Name of the Secret to return. |

#### Return

**Type**

SecretsData

**Description**

`SecretsData`

### `serializeSecret(String keyName,String encodedEncryptedValue,String hmac)` → `String`

Represent the secret value using  the required format of: <ENCRYPTION KEY NAME>~<ENCRYPTION ALGORITHM>~<HMAC ALGORITHM>~<ENCRYPTED VALUE>~<HMAC VALUE>

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |                Key name to use |
|`encodedEncryptedValue` |  Encoded and encrypted blob of the clear text |
|`hmac` |                   hmac of the secret |

#### Return

**Type**

String

**Description**

`String`

### `store(String keyName, String itemName, String clearText)` → `Boolean`

Stores a secret by generating the serialized format and triggering a metadata deploy with the secret.

#### Parameters
|Param|Description|
|-----|-----------|
|`keyName` |    Key to use |
|`itemName` |   Name to store this secret under. Use this same name to |
|`clearText` |  The clear text value. |

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `throwIfSecretHasBeenTamperedWith(String itemName,String payloadHmac,String payloadHmacAlgorithm,Blob payloadEncryptedValue)` → `void`

Verify that the data has not been tampered with by generating an HMAC of the encrypted data and comparing it to the HMAC of the retrieved secret. HMAC generation uses the name of the secret as the key to ensure integrity.

#### Parameters
|Param|Description|
|-----|-----------|
|`itemName` |               Name of the secret for comparison. |
|`payloadHmac` |            Retrieved hmac for comparison. |
|`payloadHmacAlgorithm` |   Retrieved hmac algorithm name for |
|`payloadEncryptedValue` |  Retrieved encrypted value for comparison. |

### `validateSecretFormat(String secretString)` → `List<String>`

Ensure the secret value meets the required format of: <ENCRYPTION KEY NAME>~<ENCRYPTION ALGORITHM>~<HMAC ALGORITHM>~<ENCRYPTED VALUE>~<HMAC VALUE>

#### Parameters
|Param|Description|
|-----|-----------|
|`` | g |

#### Return

**Type**

List<String>

**Description**

`List<String>`

---
