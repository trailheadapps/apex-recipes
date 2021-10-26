---
layout: default
---
# EncryptionRecipes class

Demonstrates how to use different encryption and signing algorithms in Apex

---
## Enums
### AESAlgorithm

### HashAlgorithm

---
## Properties

### `AES_KEY` → `Blob`

---
## Methods
### `checkHashRecipe(Blob hash, Blob dataToCheck)` → `void`

Generates one-way hash digest that can be checked in destination to ensure integrity.

#### Return

**Type**

void

**Description**

void

### `decryptRecipe(Blob dataToDecrypt)` → `Blob`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the sender needs to share the initialization vector with the receiver.

#### Parameters
|Param|Description|
|-----|-----------|
|`dataToDecrypt` |  Blob that contains the data to be decrypted. |

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
|`dataToDecrypt` |  Blob that contains the data to be decrypted. |

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

### `encryptRecipe()` → `Blob`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the initialization vector is specified by the sender. It needs to be random and 16 bytes (128 bits).

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob encryptedData = EncryptionRecipes.encryptRecipe();
System.debug(EncodingUtil.base64Encode(encryptedData));
```

### `encryptWithManagedIVRecipe()` → `Blob`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the initialization vector is managed by Salesforce.

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob encryptedData = EncryptionRecipes.encryptWithManagedIVRecipe();
System.debug(EncodingUtil.base64Encode(encryptedData));
```

### `generateHashRecipe()` → `Blob`

Generates one-way hash digest that can be checked in destination to ensure integrity.

#### Return

**Type**

Blob

**Description**

Blob

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
