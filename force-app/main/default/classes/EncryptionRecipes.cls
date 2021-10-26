/**
 * @description Demonstrates how to use different encryption and signing algorithms in Apex
 * @group Encryption Recipes
 */
public with sharing class EncryptionRecipes {
    public static final Blob AES_KEY = Crypto.generateAESKey(256);
    public static final Blob HMAC_KEY = Blob.valueOf('HMAC super secret key!');
    public static final Blob DIGITAL_SIGNATURE_PRIVATE_KEY = EncodingUtil.base64Decode(
        'MIIrvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDIxM3n2w5utLyI\n' +
        'Umd4otfyrEYwl3s7E9j3yI2DrcCo3ZcRtX5I3bZYxeq9XzWH6+PzjeOBz+f5LtLN\n' +
        'zMijhuR/mYITzBg3an6U87Lkyg4E5+nDat8NPwAiH04TldNl/oM231GUzo4YGl0g\n' +
        'C6FBlsOEoU+UaZtC2QdKxKH7GFe9Ny4+YKRc8b/soK5gdFzJ12PFeWnfPrLaP415\n' +
        'mNn2peUOhek4Zni5Xld6yzi9A5jdiLt8ZB+jggCID+zF2y1v9IQQywg4K6HIczLG\n' +
        '65I0OXZSOu3pe0td226M72icVILXIYcjATvV7cFRXcka7/8ScNwW5pXX3gNmVp7z\n' +
        'FlWTaVYxAgMBAAECggEBALoKLGdSBNCvKBkGix0tgQA9hRkX9bgrzxzkucWwZ1vT\n' +
        'Yl6lmKz6zjL6y2fJ5vfZrbSN4ajzuBieu/a6cZ2erPRUkkW4FSScyUlLfZUmatE+\n' +
        '+c38pU5H996mtZnOd0MHEh3x2E4VDXTmUS8Vt8roYqrvM6fqKFZMd8Zf6V2dFAif\n' +
        'iMmUpYYivK7ZOGjvxmP4jBcVoK5pqAPW3QvBFKgq3KwfUrV8IXRNRkcnmS1vWWdh\n' +
        'uBdESANgTOco2r5l7KHWSQOsqabZ7P4vt1TNg5RCtzAcaotPQgSK899sTNhcJ6Gv\n' +
        'Hq0digaaWSMGxDKaDM3eGRnU1mIIcALMKJ6CFwjAcQUCgYEA9uIPhc1NA1T5KxY3\n' +
        '7REmFnfVKyNSuNJ9Rgu6Wz+/rQQrDis1qIouH/9O0UDTGzch5SRRrOTu1b3zXtqG\n' +
        'GrFnIKfIwTOv1X7vIIyg/6St1UYrkDnghpLSv69evXKNRz6jEjoAFHe12BcZkDWp\n' +
        'GkXTUpPqQb5G+o/kIcnIYIC5TDcCgYEA0C7L76CRQxeecb+z9+LAGRI68J4O4Pi6\n' +
        'JMi1EWpNae0XXfaN7J/HqJOrpkuP3siUfik+yyb7VpCjniXOY7Yje/YM/eCXP+mJ\n' +
        'G0JcPfdOtbHysrmxZmw1H/KR6Tl2xLIGFlTUoBokPANizwCB96NynZcTpcD1/unc\n' +
        '5L2Ud4MmTNcCgYAhlWDNL79BK8b1UIFtEz8eIVDzHEv9bkyyQZgpH4Pgcke1FrWm\n' +
        '5p0dpyo+ltXgxuAqfoVJwp6mnr9DcPB7IxTHQWuytGg/35OB1v9zpyAqefAlH2pm\n' +
        'hAR9JMr7dGC5h1DBgvhN0HcBHStSDaqiM0tq2UothUe8f+RloEBMuFX8gwKBgHCy\n' +
        'xKfmTnz5jkaZtr1cvQ1Vdx7HEdrsCyjallrlJx9OwDWXwWD1Zkp2Fpghk7LQ9sIN\n' +
        'ZfboFWvZRRnZ8Y69DRyQKJxPNtHchOKC3BiXhr6JpI7oQ4bk0SWIVUDiYM8+aFky\n' +
        'dyBsxmzOkHDrH3CFxQhWvsYeXY0v4OrbTkIcd2FlAoGBAN7Z4YfQiPBAWXwLS0HX\n' +
        'sc91GT/SifrX672TAQRPEv26uGXg27Vf7gJR53nXQo5MzQDAeuTkXmjwTt7rMUX4\n' +
        'UyLhd8myC6T6CzJukae/74cCTQ1bgmzwsVQgKVjGrFTLBND7uzhx8A5UJUNUX2qG\n' +
        'bzZat8b4jWDn5y0cImr3xbC/'
    );
    public static final Blob DIGITAL_SIGNATURE_PUBLIC_KEY = EncodingUtil.base64Decode(
        'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyMTN59sObrS8iFJneKLX\n' +
        '8qxGMJd7OxPY98iNg63AqN2XEbV+SN22WMXqvV81h+vj843jgc/n+S7SzczIo4bk\n' +
        'f5mCE8wYN2p+lPOy5goOBOfpw2rfDT8AIhdOE5XTZf6DNt9RlM6OGBpdIAuhQZbD\n' +
        'hKFPlGmbQtkHSsSh+xhXvTcuPmCkXPG/7KCuYHRcyddjxXlp3z6y2j+NeZjZ9qXl\n' +
        'DoXpOGZ4uV5Xess4vQOY3Yi7fGQfo4IAiA/sxdstb/SEEMsIOCuhyHMyxuuSNDl2\n' +
        'Ujrt6XtLXdtujO9onFSC1yGHIwE71e3BUV3JGu//EnDcFuaV194DZlae8xZVk2lW\n' +
        'MQIDAQAB'
    );

    public enum AESAlgorithm {
        AES128,
        AES192,
        AES256
    }

    public enum HashAlgorithm {
        MD5,
        SHA1,
        SHA256,
        SHA512
    }

    public enum HMACAlgorithm {
        HMACMD5,
        HMACSHA1,
        HMACSHA256,
        HMACSHA512
    }

    public enum DigitalSignatureAlgorithm {
        RSA,
        RSA_SHA1,
        RSA_SHA256,
        RSA_SHA384,
        RSA_SHA512,
        ECDSA_SHA256,
        ECDSA_SHA384,
        ECDSA_SHA512
    }

    /**
     * @description Internal custom exception class
     */
    public class CryptographicException extends Exception {
    }

    /**
     * @description Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver.
     * In this case the initialization vector is managed by Salesforce.
     * @param dataToEncrypt Blob that contains the data to encrypt
     * @return Blob
     * @example
     * Blob dataToEncrypt = Blob.valueOf('Test data');
     * Blob encryptedData = EncryptionRecipes.encryptWithManagedIVRecipe(dataToEncrypt);
     * System.debug(EncodingUtil.base64Encode(encryptedData));
     **/
    @AuraEnabled
    public static Blob encryptWithManagedIVRecipe(Blob dataToEncrypt) {
        // Call Crypto.encryptWithManagedIV specifying the selected AES Algorithm
        return Crypto.encryptWithManagedIV(
            AESAlgorithm.AES256.name(),
            AES_KEY,
            dataToEncrypt
        );
    }

    /**
     * @description Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver.
     * In this case the initialization vector will be the first 128 bits (16 bytes) of the received data.
     * @param dataToDecrypt Blob that contains the data to be decrypted
     * @return Blob
     * @example
     * Blob decryptedData = EncryptionRecipes.decryptWithManagedIVRecipe(encryptedData);
     * System.debug(decryptedData.toString());
     **/
    @AuraEnabled
    public static Blob decryptWithManagedIVRecipe(Blob dataToDecrypt) {
        // Call Crypto.decryptWithManagedIV specifying the selected AES Algorithm
        return Crypto.decryptWithManagedIV(
            AESAlgorithm.AES256.name(),
            AES_KEY,
            dataToDecrypt
        );
    }

    /**
     * @description Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver.
     * In this case the initialization vector is specified by the sender. It needs to be random and 16 bytes (128 bits).
     * @param dataToEncrypt Blob that contains the data to encrypt
     * @return Blob
     * @example
     * Blob initializationVector = EncryptionRecipes.generateInitializationVector();
     * Blob dataToEncrypt = Blob.valueOf('Test data');
     * Blob encryptedData = EncryptionRecipes.encryptRecipe(dataToEncrypt, initializationVector);
     * System.debug(EncodingUtil.base64Encode(encryptedData));
     **/
    @AuraEnabled
    public static Blob encryptRecipe(
        Blob dataToEncrypt,
        Blob initializationVector
    ) {
        // Call Crypto.encryptWithManagedIV specifying the selected AES Algorithm
        Blob encryptedData = Crypto.encrypt(
            EncryptionRecipes.AESAlgorithm.AES256.name(),
            AES_KEY,
            initializationVector,
            dataToEncrypt
        );
        // Combine the encryptedData and initializationVector to send both values to the receiver
        String blobsAsHex =
            EncodingUtil.convertToHex(initializationVector) +
            EncodingUtil.convertToHex(encryptedData);
        return EncodingUtil.convertFromHex(blobsAsHex);
    }

    /**
     * @description Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver.
     * In this case the sender needs to share the initialization vector with the receiver.
     * @param dataToDecrypt Blob that contains the data to be decrypted
     * @return Blob
     * @example
     * Blob decryptedData = EncryptionRecipes.decryptRecipe(encryptedData);
     * System.debug(decryptedData.toString());
     **/
    @AuraEnabled
    public static Blob decryptRecipe(Blob dataToDecrypt) {
        // Convert received blobs to hex
        String blobsAsHex = EncodingUtil.convertToHex(dataToDecrypt);
        // Substract first two bytes (initialization vector)
        String initializationVectorString = blobsAsHex.substring(0, 32);
        // Substract the rest (encrypted data)
        String encryptedDataString = blobsAsHex.substring(32);
        // Convert both hex values to Blob
        Blob initializationVector = EncodingUtil.convertFromHex(
            initializationVectorString
        );
        Blob encryptedData = EncodingUtil.convertFromHex(encryptedDataString);
        // Call Crypto.decryptWithManagedIV specifying the selected AES Algorithm
        return Crypto.decrypt(
            EncryptionRecipes.AESAlgorithm.AES256.name(),
            AES_KEY,
            initializationVector,
            encryptedData
        );
    }

    /**
     * @description Aux method to generate a random initialization vector.
     * @return Blob
     **/
    public static Blob generateInitializationVector() {
        String characters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randomString = '';
        while (randomString.length() < 16) {
            Integer index = Math.mod(
                Math.abs(Crypto.getRandomInteger()),
                characters.length()
            );
            randomString += characters.substring(index, index + 1);
        }
        return Blob.valueOf(randomString);
    }

    /**
     * @description Generates one-way hash digest that can be checked in destination to ensure integrity.
     * @param dataToHmac Blob that contains some data for which to generate a hash
     * @return Blob
     * @example
     * Blob dataToHash = Blob.valueOf('Test data');
     * Blob hash = EncryptionRecipes.generateHashRecipe();
     * System.debug(EncodingUtil.base64Encode(hash));
     **/
    @AuraEnabled
    public static Blob generateHashRecipe(Blob dataToHash) {
        // Call Crypto.generateDigest specifying the selected algorithm
        return Crypto.generateDigest(HashAlgorithm.SHA512.name(), dataToHash);
    }

    /**
     * @description Recomputes hash digest for and compares it with the received one, throwing an exception if they're not equal.
     * @param hash Blob that contains the received hash
     * @param dataToCheck Blob that contains the data to check the hash for
     * @return void
     * @example
     * try {
     *  EncryptionRecipes.checkHashRecipe(hash, corruptedData);
     * } catch(Exception e) {
     *  // Should log exception
     *  System.debug(e.getMessage());
     * }
     **/
    @AuraEnabled
    public static void checkHashRecipe(Blob hash, Blob dataToCheck) {
        Blob recomputedHash = Crypto.generateDigest(
            HashAlgorithm.SHA512.name(),
            dataToCheck
        );

        // recomputedHash and hash should  be identical!
        if (hash != recomputedHash) {
            throw new CryptographicException('Wrong hash!');
        }
    }

    /**
     * @description Generates one-way HMAC (encrypted with a symmetric key) that can be checked in destination to ensure integrity and authenticity.
     * @param dataToHmac Blob that contains some data for which to generate an HMAC
     * @return Blob
     * @example
     * Blob dataToHmac = Blob.valueOf('Test data');
     * Blob hmac = EncryptionRecipes.generateHMACRecipe();
     * System.debug(EncodingUtil.base64Encode(hmac));
     **/
    @AuraEnabled
    public static Blob generateHMACRecipe(Blob dataToHmac) {
        // Call Crypto.generateMac specifying the selected algorithm
        return Crypto.generateMac(
            HMACAlgorithm.HMACSHA512.name(),
            dataToHmac,
            HMAC_KEY
        );
    }

    /**
     * @description Recomputes HMAC for and compares it with the received one, throwing an exception if they're not equal.
     * @param hmac Blob that contains the received hmac
     * @param dataToCheck Blob that contains the data to check the hmac for
     * @return void
     * @example
     * try {
     *  EncryptionRecipes.checkHMACRecipe(hmac, corruptedData);
     * } catch(Exception e) {
     *  // Should log exception
     *  System.debug(e.getMessage());
     * }
     **/
    @AuraEnabled
    public static void checkHMACRecipe(Blob hmac, Blob dataToCheck) {
        Boolean correct = Crypto.verifyHMAC(
            HMACAlgorithm.HMACSHA512.name(),
            dataToCheck,
            HMAC_KEY,
            hmac
        );

        if (!correct) {
            throw new CryptographicException('Wrong HMAC!');
        }
    }

    /**
     * @description Generates one-way Digital Signature (encrypted with an asymmetric key) that can be checked in destination to ensure integrity, authenticity and non-repudiation.
     * @param dataToSign Blob that contains some data to sign
     * @return Blob
     * @example
     * Blob dataToSign = Blob.valueOf('Test data');
     * Blob signature = EncryptionRecipes.generateDigitalSignatureRecipe();
     * System.debug(EncodingUtil.base64Encode(signature));
     **/
    @AuraEnabled
    public static Blob generateDigitalSignatureRecipe(Blob dataToSign) {
        // Call Crypto.sign specifying the selected algorithm
        return Crypto.sign(
            DigitalSignatureAlgorithm.RSA_SHA512.name().replace('_', '-'),
            dataToSign,
            DIGITAL_SIGNATURE_PRIVATE_KEY
        );
    }

    /**
     * @description Recomputes Digital Signature for and compares it with the received one, throwing an exception if they're not equal.
     * @param signature Blob that contains the received signature
     * @param dataToCheck Blob that contains the data to check the signature for
     * @return void
     * @example
     * try {
     *  EncryptionRecipes.checkDigitalSignatureRecipe(signature, corruptedData);
     * } catch(Exception e) {
     *  // Should log exception
     *  System.debug(e.getMessage());
     * }
     **/
    @AuraEnabled
    public static void checkDigitalSignatureRecipe(
        Blob signature,
        Blob dataToCheck
    ) {
        Boolean correct = Crypto.verify(
            DigitalSignatureAlgorithm.RSA_SHA512.name().replace('_', '-'),
            dataToCheck,
            signature,
            DIGITAL_SIGNATURE_PUBLIC_KEY
        );

        if (!correct) {
            throw new CryptographicException('Wrong signature!');
        }
    }

    /**
     * @description Encrypts the message with AES and then generates Digital Signature (encrypted with an asymmetric key) that can be checked in destination.
     * This ensure confidentiality, integrity, authenticity and non-repudiation.
     * @param dataToEncryptAndSign Blob that contains some data to encrypt and sign
     * @return Blob
     * @example
     * Blob dataToEncryptAndSign = Blob.valueOf('Test data');
     * EncryptedAndSignedData wrapper = EncryptionRecipes.encryptAndGenerateDigitalSignatureRecipe();
     * System.debug(EncodingUtil.base64Encode(wrapper.encryptedData));
     * System.debug(EncodingUtil.base64Encode(wrapper.signature));
     **/
    @AuraEnabled
    public static EncryptedAndSignedData encryptAndGenerateDigitalSignatureRecipe(
        Blob dataToEncryptAndSign
    ) {
        // Call Crypto.encrypt specifying the selected algorithm
        Blob encryptedData = Crypto.encryptWithManagedIV(
            AESAlgorithm.AES256.name(),
            AES_KEY,
            dataToEncryptAndSign
        );

        // Call Crypto.sign specifying the selected algorithm
        Blob signature = Crypto.sign(
            DigitalSignatureAlgorithm.RSA_SHA512.name().replace('_', '-'),
            encryptedData,
            DIGITAL_SIGNATURE_PRIVATE_KEY
        );

        EncryptedAndSignedData wrapper = new EncryptedAndSignedData();
        wrapper.encryptedData = encryptedData;
        wrapper.signature = signature;

        return wrapper;
    }

    public class EncryptedAndSignedData {
        public Blob encryptedData;
        public Blob signature;
    }

    /**
     * @description Decrypts the message and verifies its Digital Signature.
     * @param signature Blob that contains the received signature
     * @param dataToDecryptAndCheck Blob that contains the data to check the signature for
     * @return Blob decrypted data
     * @example
     * try {
     *  EncryptionRecipes.decryptAndCheckDigitalSignatureRecipe(signature, corruptedData);
     * } catch(Exception e) {
     *  // Should log exception
     *  System.debug(e.getMessage());
     * }
     **/
    @AuraEnabled
    public static Blob decryptAndCheckDigitalSignatureRecipe(
        Blob signature,
        Blob dataToDecryptAndCheck
    ) {
        Boolean correct = Crypto.verify(
            DigitalSignatureAlgorithm.RSA_SHA512.name().replace('_', '-'),
            dataToDecryptAndCheck,
            signature,
            DIGITAL_SIGNATURE_PUBLIC_KEY
        );

        if (!correct) {
            throw new CryptographicException('Wrong signature!');
        }

        return Crypto.decryptWithManagedIV(
            AESAlgorithm.AES256.name(),
            AES_KEY,
            dataToDecryptAndCheck
        );
    }
}
