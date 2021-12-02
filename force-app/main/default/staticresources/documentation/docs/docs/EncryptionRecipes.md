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
### `checkHMACSHA512Recipe(Blob hmac, Blob dataToCheck)` → `void`

Recomputes HMAC using the symmetric key and compares it with the received one, throwing an exception if they&apos;re not equal.

#### Parameters

| Param | Description |
| ----- | ----------- |
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
 EncryptionRecipes.checkHMACSHA512Recipe(hmac, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```

### `checkRSASHA512DigitalSignatureRecipe(Blob signature,Blob dataToCheck)` → `void`

Recomputes Digital Signature for and compares it with the received one, throwing an exception if they&apos;re not equal.

#### Parameters

| Param | Description |
| ----- | ----------- |
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
 EncryptionRecipes.checkRSASHA512DigitalSignatureRecipe(signature, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```

### `checkSHA512HashRecipe(Blob hash, Blob dataToCheck)` → `void`

Recomputes hash digest for and compares it with the received one, throwing an exception if they&apos;re not equal.

#### Parameters

| Param | Description |
| ----- | ----------- |
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
 EncryptionRecipes.checkSHA512HashRecipe(hash, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```

### `decryptAES256Recipe(Blob dataToDecrypt)` → `Blob`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the sender needs to share the initialization vector with the receiver.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`dataToDecrypt` |  Blob that contains the data to be decrypted |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob decryptedData = EncryptionRecipes.decryptAES256Recipe(encryptedData);
System.debug(decryptedData.toString());
```

### `decryptAES256WithManagedIVRecipe(Blob dataToDecrypt)` → `Blob`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the initialization vector will be the first 128 bits (16 bytes) of the received data.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`dataToDecrypt` |  Blob that contains the data to be decrypted |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob decryptedData = EncryptionRecipes.decryptAES256WithManagedIVRecipe(encryptedData);
System.debug(decryptedData.toString());
```

### `encryptAES256AndGenerateRSASHA512DigitalSignRecipe(Blob dataToEncryptAndSign)` → `EncryptedAndSignedData`

Encrypts the message with AES and then generates Digital Signature (encrypted with an asymmetric key) that can be checked in destination. This ensure confidentiality, integrity, authenticity and non-repudiation.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`dataToEncryptAndSign` |  Blob that contains some data to encrypt and sign |

#### Return

**Type**

EncryptedAndSignedData

**Description**

Blob

#### Example
```java
Blob dataToEncryptAndSign = Blob.valueOf('Test data');
EncryptedAndSignedData wrapper = EncryptionRecipes.encryptAES256AndGenerateRSASHA512DigitalSignRecipe();
System.debug(EncodingUtil.base64Encode(wrapper.encryptedData));
System.debug(EncodingUtil.base64Encode(wrapper.signature));
```

### `encryptAES256Recipe(Blob dataToEncrypt,Blob initializationVector)` → `Blob`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the initialization vector is specified by the sender. It needs to be random and 16 bytes (128 bits).

#### Parameters

| Param | Description |
| ----- | ----------- |
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
Blob encryptedData = EncryptionRecipes.encryptAES256Recipe(dataToEncrypt, initializationVector);
System.debug(EncodingUtil.base64Encode(encryptedData));
```

### `encryptAES256WithManagedIVRecipe(Blob dataToEncrypt)` → `Blob`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the initialization vector is managed by Salesforce.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`dataToEncrypt` |  Blob that contains the data to encrypt |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob dataToEncrypt = Blob.valueOf('Test data');
Blob encryptedData = EncryptionRecipes.encryptAES256WithManagedIVRecipe(dataToEncrypt);
System.debug(EncodingUtil.base64Encode(encryptedData));
```

### `generateHMACSHA512Recipe(Blob dataToHmac)` → `Blob`

Generates one-way HMAC (using a symmetric key) that can be checked in destination to ensure integrity and authenticity.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`dataToHmac` |  Blob that contains some data for which to generate an HMAC |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob dataToHmac = Blob.valueOf('Test data');
Blob hmac = EncryptionRecipes.generateHMACSHA512Recipe();
System.debug(EncodingUtil.base64Encode(hmac));
```

### `generateInitializationVector()` → `Blob`

Aux method to generate a random initialization vector.

#### Return

**Type**

Blob

**Description**

Blob

### `generateRSASHA512DigitalSignatureRecipe(Blob dataToSign)` → `Blob`

Generates one-way Digital Signature (encrypted with an asymmetric key) that can be checked in destination to ensure integrity, authenticity and non-repudiation.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`dataToSign` |  Blob that contains some data to sign |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob dataToSign = Blob.valueOf('Test data');
Blob signature = EncryptionRecipes.generateRSASHA512DigitalSignatureRecipe();
System.debug(EncodingUtil.base64Encode(signature));
```

### `generateSHA512HashRecipe(Blob dataToHash)` → `Blob`

Generates one-way hash digest that can be checked in destination to ensure integrity.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`dataToHmac` |  Blob that contains some data for which to generate a hash |

#### Return

**Type**

Blob

**Description**

Blob

#### Example
```java
Blob dataToHash = Blob.valueOf('Test data');
Blob hash = EncryptionRecipes.generateSHA512HashRecipe();
System.debug(EncodingUtil.base64Encode(hash));
```

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
##### `areEqualConstantTime(String first, String second)` → `boolean`

 Comparisons which involve cryptography need to be performed in constant time using specialized functions to avoid timing attack effects. https://en.wikipedia.org/wiki/Timing_attack

###### Parameters

| Param | Description |
| ----- | ----------- |
|`first` |  first String to compare |
|`second` |  second String to compare |

###### Return

**Type**

boolean

**Description**

Boolean strings are equal

##### `decryptAES256AndCheckRSASHA512DigitalSignRecipe(Blob signature,Blob dataToDecryptAndCheck)` → `Blob`

Decrypts the message and verifies its Digital Signature.

###### Parameters

| Param | Description |
| ----- | ----------- |
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
 EncryptionRecipes.decryptAES256AndCheckRSASHA512DigitalSignRecipe(signature, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```

---
