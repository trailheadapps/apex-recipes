# EncryptionRecipes Class

Demonstrates how to use different encryption and signing algorithms in Apex

**Group** Encryption Recipes

## Fields
### `AES_KEY`

#### Signature
```apex
public static final AES_KEY
```

#### Type
Blob

---

### `HMAC_KEY`

#### Signature
```apex
public static final HMAC_KEY
```

#### Type
Blob

---

### `DIGITAL_SIGNATURE_PRIVATE_KEY`

#### Signature
```apex
public static final DIGITAL_SIGNATURE_PRIVATE_KEY
```

#### Type
Blob

---

### `DIGITAL_SIGNATURE_PUBLIC_KEY`

#### Signature
```apex
public static final DIGITAL_SIGNATURE_PUBLIC_KEY
```

#### Type
Blob

## Methods
### `encryptAES256WithManagedIVRecipe(dataToEncrypt)`

`AURAENABLED`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. 
In this case the initialization vector is managed by Salesforce.

#### Signature
```apex
public static Blob encryptAES256WithManagedIVRecipe(Blob dataToEncrypt)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dataToEncrypt | Blob | Blob that contains the data to encrypt |

#### Return Type
**Blob**

#### Example
```apex
Blob dataToEncrypt = Blob.valueOf('Test data');
Blob encryptedData = EncryptionRecipes.encryptAES256WithManagedIVRecipe(dataToEncrypt);
System.debug(EncodingUtil.base64Encode(encryptedData));
```

---

### `decryptAES256WithManagedIVRecipe(dataToDecrypt)`

`AURAENABLED`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. 
In this case the initialization vector will be the first 128 bits (16 bytes) of the received data.

#### Signature
```apex
public static Blob decryptAES256WithManagedIVRecipe(Blob dataToDecrypt)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dataToDecrypt | Blob | Blob that contains the data to be decrypted |

#### Return Type
**Blob**

#### Example
```apex
Blob decryptedData = EncryptionRecipes.decryptAES256WithManagedIVRecipe(encryptedData);
System.debug(decryptedData.toString());
```

---

### `encryptAES256Recipe(dataToEncrypt, initializationVector)`

`AURAENABLED`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. 
In this case the initialization vector is specified by the sender. It needs to be random and 16 bytes (128 bits).

#### Signature
```apex
public static Blob encryptAES256Recipe(Blob dataToEncrypt, Blob initializationVector)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dataToEncrypt | Blob | Blob that contains the data to encrypt |
| initializationVector | Blob |  |

#### Return Type
**Blob**

#### Example
```apex
Blob initializationVector = EncryptionRecipes.generateInitializationVector();
Blob dataToEncrypt = Blob.valueOf('Test data');
Blob encryptedData = EncryptionRecipes.encryptAES256Recipe(dataToEncrypt, initializationVector);
System.debug(EncodingUtil.base64Encode(encryptedData));
```

---

### `decryptAES256Recipe(dataToDecrypt)`

`AURAENABLED`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. 
In this case the sender needs to share the initialization vector with the receiver.

#### Signature
```apex
public static Blob decryptAES256Recipe(Blob dataToDecrypt)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dataToDecrypt | Blob | Blob that contains the data to be decrypted |

#### Return Type
**Blob**

#### Example
```apex
Blob decryptedData = EncryptionRecipes.decryptAES256Recipe(encryptedData);
System.debug(decryptedData.toString());
```

---

### `generateInitializationVector()`

Aux method to generate a random initialization vector.

#### Signature
```apex
public static Blob generateInitializationVector()
```

#### Return Type
**Blob**

---

### `generateSHA512HashRecipe(dataToHash)`

`AURAENABLED`

Generates one-way hash digest that can be checked in destination to ensure integrity.

#### Signature
```apex
public static Blob generateSHA512HashRecipe(Blob dataToHash)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dataToHash | Blob |  |

#### Return Type
**Blob**

#### Example
```apex
Blob dataToHash = Blob.valueOf('Test data');
Blob hash = EncryptionRecipes.generateSHA512HashRecipe();
System.debug(EncodingUtil.base64Encode(hash));
```

---

### `checkSHA512HashRecipe(hash, dataToCheck)`

`AURAENABLED`

Recomputes hash digest for and compares it with the received one, throwing an exception if they&#x27;re not equal.

#### Signature
```apex
public static void checkSHA512HashRecipe(Blob hash, Blob dataToCheck)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| hash | Blob | Blob that contains the received hash |
| dataToCheck | Blob | Blob that contains the data to check the hash for |

#### Return Type
**void**

#### Example
```apex
try {
 EncryptionRecipes.checkSHA512HashRecipe(hash, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```

---

### `generateHMACSHA512Recipe(dataToHmac)`

`AURAENABLED`

Generates one-way HMAC (using a symmetric key) that can be checked in destination to ensure integrity and authenticity.

#### Signature
```apex
public static Blob generateHMACSHA512Recipe(Blob dataToHmac)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dataToHmac | Blob | Blob that contains some data for which to generate an HMAC |

#### Return Type
**Blob**

#### Example
```apex
Blob dataToHmac = Blob.valueOf('Test data');
Blob hmac = EncryptionRecipes.generateHMACSHA512Recipe();
System.debug(EncodingUtil.base64Encode(hmac));
```

---

### `checkHMACSHA512Recipe(hmac, dataToCheck)`

`AURAENABLED`

Recomputes HMAC using the symmetric key and compares it with the received one, throwing an exception if they&#x27;re not equal.

#### Signature
```apex
public static void checkHMACSHA512Recipe(Blob hmac, Blob dataToCheck)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| hmac | Blob | Blob that contains the received hmac |
| dataToCheck | Blob | Blob that contains the data to check the hmac for |

#### Return Type
**void**

#### Example
```apex
try {
 EncryptionRecipes.checkHMACSHA512Recipe(hmac, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```

---

### `generateRSASHA512DigitalSignatureRecipe(dataToSign)`

`AURAENABLED`

Generates one-way Digital Signature (encrypted with an asymmetric key) that can be checked in destination to ensure integrity, authenticity and non-repudiation.

#### Signature
```apex
public static Blob generateRSASHA512DigitalSignatureRecipe(Blob dataToSign)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dataToSign | Blob | Blob that contains some data to sign |

#### Return Type
**Blob**

#### Example
```apex
Blob dataToSign = Blob.valueOf('Test data');
Blob signature = EncryptionRecipes.generateRSASHA512DigitalSignatureRecipe();
System.debug(EncodingUtil.base64Encode(signature));
```

---

### `checkRSASHA512DigitalSignatureRecipe(signature, dataToCheck)`

`AURAENABLED`

Recomputes Digital Signature for and compares it with the received one, throwing an exception if they&#x27;re not equal.

#### Signature
```apex
public static void checkRSASHA512DigitalSignatureRecipe(Blob signature, Blob dataToCheck)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| signature | Blob | Blob that contains the received signature |
| dataToCheck | Blob | Blob that contains the data to check the signature for |

#### Return Type
**void**

#### Example
```apex
try {
 EncryptionRecipes.checkRSASHA512DigitalSignatureRecipe(signature, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```

---

### `encryptAES256AndGenerateRSASHA512DigitalSignRecipe(dataToEncryptAndSign)`

`AURAENABLED`

Encrypts the message with AES and then generates Digital Signature (encrypted with an asymmetric key) that can be checked in destination. 
This ensure confidentiality, integrity, authenticity and non-repudiation.

#### Signature
```apex
public static EncryptedAndSignedData encryptAES256AndGenerateRSASHA512DigitalSignRecipe(Blob dataToEncryptAndSign)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dataToEncryptAndSign | Blob | Blob that contains some data to encrypt and sign |

#### Return Type
**EncryptedAndSignedData**

#### Example
```apex
Blob dataToEncryptAndSign = Blob.valueOf('Test data');
EncryptedAndSignedData wrapper = EncryptionRecipes.encryptAES256AndGenerateRSASHA512DigitalSignRecipe();
System.debug(EncodingUtil.base64Encode(wrapper.encryptedData));
System.debug(EncodingUtil.base64Encode(wrapper.signature));
```

---

### `decryptAES256AndCheckRSASHA512DigitalSignRecipe(signature, dataToDecryptAndCheck)`

`AURAENABLED`

Decrypts the message and verifies its Digital Signature.

#### Signature
```apex
public static Blob decryptAES256AndCheckRSASHA512DigitalSignRecipe(Blob signature, Blob dataToDecryptAndCheck)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| signature | Blob | Blob that contains the received signature |
| dataToDecryptAndCheck | Blob | Blob that contains the data to check the signature for |

#### Return Type
**Blob**

Decrypted data

#### Example
```apex
try {
 EncryptionRecipes.decryptAES256AndCheckRSASHA512DigitalSignRecipe(signature, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```

---

### `areEqualConstantTime(first, second)`

Comparisons which involve cryptography need to be performed in constant time 
using specialized functions to avoid timing attack effects. 
https://en.wikipedia.org/wiki/Timing_attack

#### Signature
```apex
public static boolean areEqualConstantTime(String first, String second)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| first | String | first String to compare |
| second | String | second String to compare |

#### Return Type
**boolean**

True if strings are equal

## Classes
### CryptographicException Class

Internal custom exception class

### EncryptedAndSignedData Class

#### Fields
##### `encryptedData`

###### Signature
```apex
public encryptedData
```

###### Type
Blob

---

##### `signature`

###### Signature
```apex
public signature
```

###### Type
Blob

## Enums
### AESAlgorithm Enum

#### Values
| Value | Description |
|-------|-------------|
| AES128 |  |
| AES192 |  |
| AES256 |  |
### HashAlgorithm Enum

#### Values
| Value | Description |
|-------|-------------|
| MD5 |  |
| SHA1 |  |
| SHA256 |  |
| SHA512 |  |
### HMACAlgorithm Enum

#### Values
| Value | Description |
|-------|-------------|
| HMACMD5 |  |
| HMACSHA1 |  |
| HMACSHA256 |  |
| HMACSHA512 |  |
### DigitalSignatureAlgorithm Enum

#### Values
| Value | Description |
|-------|-------------|
| RSA |  |
| RSA_SHA1 |  |
| RSA_SHA256 |  |
| RSA_SHA384 |  |
| RSA_SHA512 |  |
| ECDSA_SHA256 |  |
| ECDSA_SHA384 |  |
| ECDSA_SHA512 |  |