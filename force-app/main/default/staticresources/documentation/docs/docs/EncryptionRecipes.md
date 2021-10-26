---
layout: default
---
# EncryptionRecipes class

Demonstrates how to use different encryption and signing algorithms in Apex

---
## Enums
### AESAlgorithm

### DigitalSignatureAlgorithm

### HMACAlgorithm

### HashAlgorithm

---
## Properties

### `AES_KEY` → `Blob`

### `DIGITAL_SIGNATURE_PRIVATE_KEY` → `Blob`

### `DIGITAL_SIGNATURE_PUBLIC_KEY` → `Blob`

### `HMAC_KEY` → `Blob`

---
## Methods
### `checkDigitalSignatureRecipe(Blob signature,Blob dataToCheck)` → `void`

Recomputes Digital Signature for and compares it with the received one, throwing an exception if they're not equal.

#### Parameters
|Param|Description|
|-----|-----------|
|`signature` |  Blob that contains the received signature |
|`dataToCheck` |  Blob that contains the data to check the signature for |

#### Return

**Type**

void

**Description**

void

#### Example
```java
try {
 EncryptionRecipes.checkDigitalSignatureRecipe(signature, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```

### `checkHMACRecipe(Blob hmac, Blob dataToCheck)` → `void`

Recomputes HMAC for and compares it with the received one, throwing an exception if they're not equal.

#### Parameters
|Param|Description|
|-----|-----------|
|`hmac` |  Blob that contains the received hmac |
|`dataToCheck` |  Blob that contains the data to check the hmac for |

#### Return

**Type**

void

**Description**

void

#### Example
```java
try {
 EncryptionRecipes.checkHMACRecipe(hmac, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```

### `checkHashRecipe(Blob hash, Blob dataToCheck)` → `void`

Recomputes hash digest for and compares it with the received one, throwing an exception if they're not equal.

#### Parameters
|Param|Description|
|-----|-----------|
|`hash` |  Blob that contains the received hash |
|`dataToCheck` |  Blob that contains the data to check the hash for |

#### Return

**Type**

void

**Description**

void

#### Example
```java
try {
 EncryptionRecipes.checkHashRecipe(hash, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```

### `decryptRecipe(Blob dataToDecrypt)` → `Blob`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the sender needs to share the initialization vector with the receiver.

#### Parameters
|Param|Description|
|-----|-----------|
|`dataToDecrypt` |  Blob that contains the data to be decrypted |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob decryptedData = EncryptionRecipes.decryptRecipe(encryptedData);
System.debug(decryptedData.toString());
```

### `decryptWithManagedIVRecipe(Blob dataToDecrypt)` → `Blob`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the initialization vector will be the first 128 bits (16 bytes) of the received data.

#### Parameters
|Param|Description|
|-----|-----------|
|`dataToDecrypt` |  Blob that contains the data to be decrypted |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob decryptedData = EncryptionRecipes.decryptWithManagedIVRecipe(encryptedData);
System.debug(decryptedData.toString());
```

### `encryptAndGenerateDigitalSignatureRecipe(Blob dataToEncryptAndSign)` → `EncryptedAndSignedData`

Encrypts the message with AES and then generates Digital Signature (encrypted with an asymmetric key) that can be checked in destination. This ensure confidentiality, integrity, authenticity and non-repudiation.

#### Parameters
|Param|Description|
|-----|-----------|
|`dataToEncryptAndSign` |  Blob that contains some data to encrypt and sign |

#### Return

**Type**

EncryptedAndSignedData

**Description**

Blob

#### Example
```java
Blob dataToEncryptAndSign = Blob.valueOf('Test data');
EncryptedAndSignedData wrapper = EncryptionRecipes.encryptAndGenerateDigitalSignatureRecipe();
System.debug(EncodingUtil.base64Encode(wrapper.encryptedData));
System.debug(EncodingUtil.base64Encode(wrapper.signature));
```

### `encryptRecipe(Blob dataToEncrypt,Blob initializationVector)` → `Blob`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the initialization vector is specified by the sender. It needs to be random and 16 bytes (128 bits).

#### Parameters
|Param|Description|
|-----|-----------|
|`dataToEncrypt` |  Blob that contains the data to encrypt |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob initializationVector = EncryptionRecipes.generateInitializationVector();
Blob dataToEncrypt = Blob.valueOf('Test data');
Blob encryptedData = EncryptionRecipes.encryptRecipe(dataToEncrypt, initializationVector);
System.debug(EncodingUtil.base64Encode(encryptedData));
```

### `encryptWithManagedIVRecipe(Blob dataToEncrypt)` → `Blob`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the initialization vector is managed by Salesforce.

#### Parameters
|Param|Description|
|-----|-----------|
|`dataToEncrypt` |  Blob that contains the data to encrypt |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob dataToEncrypt = Blob.valueOf('Test data');
Blob encryptedData = EncryptionRecipes.encryptWithManagedIVRecipe(dataToEncrypt);
System.debug(EncodingUtil.base64Encode(encryptedData));
```

### `generateDigitalSignatureRecipe(Blob dataToSign)` → `Blob`

Generates one-way Digital Signature (encrypted with an asymmetric key) that can be checked in destination to ensure integrity, authenticity and non-repudiation.

#### Parameters
|Param|Description|
|-----|-----------|
|`dataToSign` |  Blob that contains some data to sign |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob dataToSign = Blob.valueOf('Test data');
Blob signature = EncryptionRecipes.generateDigitalSignatureRecipe();
System.debug(EncodingUtil.base64Encode(signature));
```

### `generateHMACRecipe(Blob dataToHmac)` → `Blob`

Generates one-way HMAC (encrypted with a symmetric key) that can be checked in destination to ensure integrity and authenticity.

#### Parameters
|Param|Description|
|-----|-----------|
|`dataToHmac` |  Blob that contains some data for which to generate an HMAC |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob dataToHmac = Blob.valueOf('Test data');
Blob hmac = EncryptionRecipes.generateHMACRecipe();
System.debug(EncodingUtil.base64Encode(hmac));
```

### `generateHashRecipe(Blob dataToHash)` → `Blob`

Generates one-way hash digest that can be checked in destination to ensure integrity.

#### Parameters
|Param|Description|
|-----|-----------|
|`dataToHmac` |  Blob that contains some data for which to generate a hash |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob dataToHash = Blob.valueOf('Test data');
Blob hash = EncryptionRecipes.generateHashRecipe();
System.debug(EncodingUtil.base64Encode(hash));
```

### `generateInitializationVector()` → `Blob`

Aux method to generate a random initialization vector.

#### Return

**Type**

Blob

**Description**

Blob

---
## Inner Classes

### EncryptionRecipes.CryptographicException class

Internal custom exception class

---
### EncryptionRecipes.EncryptedAndSignedData class
---
#### Properties

##### `encryptedData` → `Blob`

##### `signature` → `Blob`

---
#### Methods
##### `decryptAndCheckDigitalSignatureRecipe(Blob signature,Blob dataToDecryptAndCheck)` → `Blob`

Decrypts the message and verifies its Digital Signature.

###### Parameters
|Param|Description|
|-----|-----------|
|`signature` |  Blob that contains the received signature |
|`dataToDecryptAndCheck` |  Blob that contains the data to check the signature for |

###### Return

**Type**

Blob

**Description**

Blob decrypted data

###### Example
```java
try {
 EncryptionRecipes.decryptAndCheckDigitalSignatureRecipe(signature, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```

---
