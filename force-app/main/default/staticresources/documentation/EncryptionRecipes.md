# EncryptionRecipes

Demonstrates how to use different encryption and signing algorithms in Apex


**Group** Encryption Recipes

## Fields

### `public AES_KEY` → `Blob`


### `public DIGITAL_SIGNATURE_PRIVATE_KEY` → `Blob`


### `public DIGITAL_SIGNATURE_PUBLIC_KEY` → `Blob`


### `public HMAC_KEY` → `Blob`


---
## Methods
### `public static Blob encryptAES256WithManagedIVRecipe(Blob dataToEncrypt)`

`AURAENABLED`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the initialization vector is managed by Salesforce.

#### Parameters

|Param|Description|
|---|---|
|`dataToEncrypt`|Blob that contains the data to encrypt|

#### Returns

|Type|Description|
|---|---|
|`Blob`|Blob|

#### Example
```apex
Blob dataToEncrypt = Blob.valueOf('Test data');
Blob encryptedData = EncryptionRecipes.encryptAES256WithManagedIVRecipe(dataToEncrypt);
System.debug(EncodingUtil.base64Encode(encryptedData));
```


### `public static Blob decryptAES256WithManagedIVRecipe(Blob dataToDecrypt)`

`AURAENABLED`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the initialization vector will be the first 128 bits (16 bytes) of the received data.

#### Parameters

|Param|Description|
|---|---|
|`dataToDecrypt`|Blob that contains the data to be decrypted|

#### Returns

|Type|Description|
|---|---|
|`Blob`|Blob|

#### Example
```apex
Blob decryptedData = EncryptionRecipes.decryptAES256WithManagedIVRecipe(encryptedData);
System.debug(decryptedData.toString());
```


### `public static Blob encryptAES256Recipe(Blob dataToEncrypt, Blob initializationVector)`

`AURAENABLED`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the initialization vector is specified by the sender. It needs to be random and 16 bytes (128 bits).

#### Parameters

|Param|Description|
|---|---|
|`dataToEncrypt`|Blob that contains the data to encrypt|

#### Returns

|Type|Description|
|---|---|
|`Blob`|Blob|

#### Example
```apex
Blob initializationVector = EncryptionRecipes.generateInitializationVector();
Blob dataToEncrypt = Blob.valueOf('Test data');
Blob encryptedData = EncryptionRecipes.encryptAES256Recipe(dataToEncrypt, initializationVector);
System.debug(EncodingUtil.base64Encode(encryptedData));
```


### `public static Blob decryptAES256Recipe(Blob dataToDecrypt)`

`AURAENABLED`

Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver. In this case the sender needs to share the initialization vector with the receiver.

#### Parameters

|Param|Description|
|---|---|
|`dataToDecrypt`|Blob that contains the data to be decrypted|

#### Returns

|Type|Description|
|---|---|
|`Blob`|Blob|

#### Example
```apex
Blob decryptedData = EncryptionRecipes.decryptAES256Recipe(encryptedData);
System.debug(decryptedData.toString());
```


### `public static Blob generateInitializationVector()`

Aux method to generate a random initialization vector.

#### Returns

|Type|Description|
|---|---|
|`Blob`|Blob|

### `public static Blob generateSHA512HashRecipe(Blob dataToHash)`

`AURAENABLED`

Generates one-way hash digest that can be checked in destination to ensure integrity.

#### Parameters

|Param|Description|
|---|---|
|`dataToHmac`|Blob that contains some data for which to generate a hash|

#### Returns

|Type|Description|
|---|---|
|`Blob`|Blob|

#### Example
```apex
Blob dataToHash = Blob.valueOf('Test data');
Blob hash = EncryptionRecipes.generateSHA512HashRecipe();
System.debug(EncodingUtil.base64Encode(hash));
```


### `public static void checkSHA512HashRecipe(Blob hash, Blob dataToCheck)`

`AURAENABLED`

Recomputes hash digest for and compares it with the received one, throwing an exception if they're not equal.

#### Parameters

|Param|Description|
|---|---|
|`hash`|Blob that contains the received hash|
|`dataToCheck`|Blob that contains the data to check the hash for|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

#### Example
```apex
try {
 EncryptionRecipes.checkSHA512HashRecipe(hash, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```


### `public static Blob generateHMACSHA512Recipe(Blob dataToHmac)`

`AURAENABLED`

Generates one-way HMAC (using a symmetric key) that can be checked in destination to ensure integrity and authenticity.

#### Parameters

|Param|Description|
|---|---|
|`dataToHmac`|Blob that contains some data for which to generate an HMAC|

#### Returns

|Type|Description|
|---|---|
|`Blob`|Blob|

#### Example
```apex
Blob dataToHmac = Blob.valueOf('Test data');
Blob hmac = EncryptionRecipes.generateHMACSHA512Recipe();
System.debug(EncodingUtil.base64Encode(hmac));
```


### `public static void checkHMACSHA512Recipe(Blob hmac, Blob dataToCheck)`

`AURAENABLED`

Recomputes HMAC using the symmetric key and compares it with the received one, throwing an exception if they're not equal.

#### Parameters

|Param|Description|
|---|---|
|`hmac`|Blob that contains the received hmac|
|`dataToCheck`|Blob that contains the data to check the hmac for|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

#### Example
```apex
try {
 EncryptionRecipes.checkHMACSHA512Recipe(hmac, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```


### `public static Blob generateRSASHA512DigitalSignatureRecipe(Blob dataToSign)`

`AURAENABLED`

Generates one-way Digital Signature (encrypted with an asymmetric key) that can be checked in destination to ensure integrity, authenticity and non-repudiation.

#### Parameters

|Param|Description|
|---|---|
|`dataToSign`|Blob that contains some data to sign|

#### Returns

|Type|Description|
|---|---|
|`Blob`|Blob|

#### Example
```apex
Blob dataToSign = Blob.valueOf('Test data');
Blob signature = EncryptionRecipes.generateRSASHA512DigitalSignatureRecipe();
System.debug(EncodingUtil.base64Encode(signature));
```


### `public static void checkRSASHA512DigitalSignatureRecipe(Blob signature, Blob dataToCheck)`

`AURAENABLED`

Recomputes Digital Signature for and compares it with the received one, throwing an exception if they're not equal.

#### Parameters

|Param|Description|
|---|---|
|`signature`|Blob that contains the received signature|
|`dataToCheck`|Blob that contains the data to check the signature for|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

#### Example
```apex
try {
 EncryptionRecipes.checkRSASHA512DigitalSignatureRecipe(signature, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```


### `public static EncryptedAndSignedData encryptAES256AndGenerateRSASHA512DigitalSignRecipe(Blob dataToEncryptAndSign)`

`AURAENABLED`

Encrypts the message with AES and then generates Digital Signature (encrypted with an asymmetric key) that can be checked in destination. This ensure confidentiality, integrity, authenticity and non-repudiation.

#### Parameters

|Param|Description|
|---|---|
|`dataToEncryptAndSign`|Blob that contains some data to encrypt and sign|

#### Returns

|Type|Description|
|---|---|
|`EncryptedAndSignedData`|Blob|

#### Example
```apex
Blob dataToEncryptAndSign = Blob.valueOf('Test data');
EncryptedAndSignedData wrapper = EncryptionRecipes.encryptAES256AndGenerateRSASHA512DigitalSignRecipe();
System.debug(EncodingUtil.base64Encode(wrapper.encryptedData));
System.debug(EncodingUtil.base64Encode(wrapper.signature));
```


### `public static Blob decryptAES256AndCheckRSASHA512DigitalSignRecipe(Blob signature, Blob dataToDecryptAndCheck)`

`AURAENABLED`

Decrypts the message and verifies its Digital Signature.

#### Parameters

|Param|Description|
|---|---|
|`signature`|Blob that contains the received signature|
|`dataToDecryptAndCheck`|Blob that contains the data to check the signature for|

#### Returns

|Type|Description|
|---|---|
|`Blob`|Blob decrypted data|

#### Example
```apex
try {
 EncryptionRecipes.decryptAES256AndCheckRSASHA512DigitalSignRecipe(signature, corruptedData);
} catch(Exception e) {
 // Should log exception
 System.debug(e.getMessage());
}
```


### `public static boolean areEqualConstantTime(String first, String second)`

Comparisons which involve cryptography need to be performed in constant time using specialized functions to avoid timing attack effects. https://en.wikipedia.org/wiki/Timing_attack

#### Parameters

|Param|Description|
|---|---|
|`first`|first String to compare|
|`second`|second String to compare|

#### Returns

|Type|Description|
|---|---|
|`boolean`|Boolean strings are equal|

---
## Enums
### AESAlgorithm

### DigitalSignatureAlgorithm

### HMACAlgorithm

### HashAlgorithm

---
## Classes
### CryptographicException

Internal custom exception class


**Inheritance**

CryptographicException


### EncryptedAndSignedData
#### Fields

##### `public encryptedData` → `Blob`


##### `public signature` → `Blob`


---

---
