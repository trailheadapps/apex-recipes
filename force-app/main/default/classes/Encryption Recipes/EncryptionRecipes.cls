/**
 * @description Demonstrates how to use different encryption and signing algorithms in Apex
 * @group Encryption Recipes
 */
public with sharing class EncryptionRecipes {
    // Keys are here for testing purposes. NEVER DO THIS!!!
    // Use an approved secrets management solution like Shield Platform Encryption
    public static final Blob AES_KEY = Crypto.generateAESKey(256);
    public static final Blob HMAC_KEY = Blob.valueOf('HMAC super secret key!');
    public static final Blob DIGITAL_SIGNATURE_PRIVATE_KEY = EncodingUtil.base64Decode(
        'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCS7LXFvLFELXwy\n' +
            '8DyWjb+7QneZZsrzKnIHg8M5MTSTF3Iawhk/9GSKNUbGW8y0XzgrkNUmfuwL+5pT\n' +
            'HM/BQWToa8+QCIkCxPPJsw8N6gs/u7NYhD/Tv72HhBOoQNU5V45n/TSMmAMRjAnF\n' +
            'VxPMMfBCmJadVj7rf5CLrfWRtpeCpot5iyeaqoLLcsgfuaDPtCCeFULwkVzPb1Zo\n' +
            'KN7M790Aq9Tgez263dwyDw9wkmLinV6KBbnDBNEw0YZs/Zkzbo67MprJKjbCGRfs\n' +
            'zoezW/qmipFChAUc7Pjq97wgM5WOh/M+HsR6uBiPxdyMKq4EfW56ne7PJdnKXfhm\n' +
            'rYK77fyDAgMBAAECggEAOAkFjqPXq9v5KWhMg1MOk/nWqW/16WX/1XPgahilJ5Bi\n' +
            'mWf7v1OTYM7O7mommYhTYPI9CRCRMETGZ/puFhO9y5MKt7E5qA+7tuqOzEy9+5G3\n' +
            '5gOSYE0ZmOy7nokTiWomSuzcNN7pFLEnLNd4GoHVU2Dk2J8DIkgltdAj/233PQF0\n' +
            'fYsYzjzXg/2keSzMCR7AK7qr+lg/wxjJj3H/4OcCHWvrB3Wqh9DGAXkIOQi+0aWs\n' +
            'Ih6eO/bC38Ym3WaSX8X55Hm6FNU3I6T+s+uUCZiVsgLuRrFxI8VJ0swutvS19TEC\n' +
            'vm3+FvXu9HFrNSRRvEUT5SQH7IkV3RCjybdIisoceQKBgQD+RK7uMqonDuMZF8Qj\n' +
            'MtwIspODT2Gov/YIKLdETg8wWvmszJuQEV1yGRGbbU2Cf6lhBsUszzL2V/vQSDBP\n' +
            'VNh4E7uGtTwr6oF3nUo0YU0okzsvEiRWkfvx1J97H8Dm8fsaM+AzGjbR4L62O1oc\n' +
            'ibFsyOYMEHCQ10EyGDay20fCjwKBgQCT7N+Ew4nHR6BNQypbpAFoKVb11JQgJCg7\n' +
            'rTZZlR/gvoB3vyT3Rus1yfjmCWzCs3iWChddGxkZp/Bir5ZiG98BS3w22AgEN4x1\n' +
            'dXC4/ddl3LFtgAIxsKNbLHJwBYYPmC/5PIu55R5pFTghdyfSUOiphKdvs1Giz9Vo\n' +
            '2Bs0We3QzQKBgAxmVRGQrvOQqkqC+jGtPUW/T6pLqLuOAPWM5sMR+3OkPCDNKZjw\n' +
            '/9mcl1s5DVqb1yrAJcV1pUqWJ9WUb6auwI+6hp6fH/wUR5QJu6CqThT4eR5miBcg\n' +
            'r2SvtcdPWRzqGBDDDt/vG1VI3IQOiOpzXI+tjGpyMssddDR5MdGvF+TJAoGAKWgv\n' +
            '9TDrG05Qb/AyJi7VefvAbNXRlOGqJXJJ+W+F2dpZiauGxHUkmAzuUC4pNKMaSR2Q\n' +
            'Bq70KrtYzbcK6HGWzfz8SznTnKKT/bkfEZl0tv286MLhWllwkK/zZKoXKbxXCXRK\n' +
            'RIH/LjkTWkLJcdTWG8WXPOw8GNAGk++SReg6aq0CgYEAmIcjQgyOgr1SPPAPHBCD\n' +
            'UVKIYJEI3j/7b4HUIOJ1IU1la1g2Vr5SKPn+GziMFhFcBjx6LlJxAkJQlOgBOnkO\n' +
            'cHC3etOoAsrrRh4LPzZ6CXQeSRjilQnzaCdq2CIu+f8UqVWbwPtb3K/aQAX905Ck\n' +
            'qC9DNbUBwQx01n161Nm6Wsg='
    );
    public static final Blob DIGITAL_SIGNATURE_PUBLIC_KEY = EncodingUtil.base64Decode(
        'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAkuy1xbyxRC18MvA8lo2/\n' +
            'u0J3mWbK8ypyB4PDOTE0kxdyGsIZP/RkijVGxlvMtF84K5DVJn7sC/uaUxzPwUFk\n' +
            '6GvPkAiJAsTzybMPDeoLP7uzWIQ/07+9h4QTqEDVOVeOZ/00jJgDEYwJxVcTzDHw\n' +
            'QpiWnVY+63+Qi631kbaXgqaLeYsnmqqCy3LIH7mgz7QgnhVC8JFcz29WaCjezO/d\n' +
            'AKvU4Hs9ut3cMg8PcJJi4p1eigW5wwTRMNGGbP2ZM26OuzKaySo2whkX7M6Hs1v6\n' +
            'poqRQoQFHOz46ve8IDOVjofzPh7EergYj8XcjCquBH1uep3uzyXZyl34Zq2Cu+38\n' +
            'gwIDAQAB'
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
     * @example
     * ```
     * Blob dataToEncrypt = Blob.valueOf('Test data');
     * Blob encryptedData = EncryptionRecipes.encryptAES256WithManagedIVRecipe(dataToEncrypt);
     * System.debug(EncodingUtil.base64Encode(encryptedData));
     * ```
     */
    @AuraEnabled
    public static Blob encryptAES256WithManagedIVRecipe(Blob dataToEncrypt) {
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
     * @example
     * ```
     * Blob decryptedData = EncryptionRecipes.decryptAES256WithManagedIVRecipe(encryptedData);
     * System.debug(decryptedData.toString());
     * ```
     */
    @AuraEnabled
    public static Blob decryptAES256WithManagedIVRecipe(Blob dataToDecrypt) {
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
     * @example
     * ```
     * Blob initializationVector = EncryptionRecipes.generateInitializationVector();
     * Blob dataToEncrypt = Blob.valueOf('Test data');
     * Blob encryptedData = EncryptionRecipes.encryptAES256Recipe(dataToEncrypt, initializationVector);
     * System.debug(EncodingUtil.base64Encode(encryptedData));
     * ```
     */
    @AuraEnabled
    public static Blob encryptAES256Recipe(
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
     * @example
     * ```
     * Blob decryptedData = EncryptionRecipes.decryptAES256Recipe(encryptedData);
     * System.debug(decryptedData.toString());
     * ```
     */
    @AuraEnabled
    public static Blob decryptAES256Recipe(Blob dataToDecrypt) {
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
     */
    public static Blob generateInitializationVector() {
        // Generating IV this way until there's an Apex method for it
        //  Do not use the same value for the IV and AES key!!
        return Crypto.generateAesKey(128);
    }

    /**
     * @description Generates one-way hash digest that can be checked in destination to ensure integrity.
     * @param dataToHmac Blob that contains some data for which to generate a hash
     * @example
     * ```
     * Blob dataToHash = Blob.valueOf('Test data');
     * Blob hash = EncryptionRecipes.generateSHA512HashRecipe();
     * System.debug(EncodingUtil.base64Encode(hash));
     * ```
     */
    @AuraEnabled
    public static Blob generateSHA512HashRecipe(Blob dataToHash) {
        // Call Crypto.generateDigest specifying the selected algorithm
        return Crypto.generateDigest(HashAlgorithm.SHA512.name(), dataToHash);
    }

    /**
     * @description Recomputes hash digest for and compares it with the received one, throwing an exception if they're not equal.
     * @param hash Blob that contains the received hash
     * @param dataToCheck Blob that contains the data to check the hash for
     * @example
     * ```
     * try {
     *  EncryptionRecipes.checkSHA512HashRecipe(hash, corruptedData);
     * } catch(Exception e) {
     *  // Should log exception
     *  System.debug(e.getMessage());
     * }
     * ```
     */
    @AuraEnabled
    public static void checkSHA512HashRecipe(Blob hash, Blob dataToCheck) {
        Blob recomputedHash = Crypto.generateDigest(
            HashAlgorithm.SHA512.name(),
            dataToCheck
        );

        // recomputedHash and hash should  be identical!
        if (
            !areEqualConstantTime(
                EncodingUtil.base64Encode(hash),
                EncodingUtil.base64Encode(recomputedHash)
            )
        ) {
            throw new CryptographicException('Wrong hash!');
        }
    }

    /**
     * @description Generates one-way HMAC (using a symmetric key) that can be checked in destination to ensure integrity and authenticity.
     * @param dataToHmac Blob that contains some data for which to generate an HMAC
     * @example
     * ```
     * Blob dataToHmac = Blob.valueOf('Test data');
     * Blob hmac = EncryptionRecipes.generateHMACSHA512Recipe();
     * System.debug(EncodingUtil.base64Encode(hmac));
     * ```
     */
    @AuraEnabled
    public static Blob generateHMACSHA512Recipe(Blob dataToHmac) {
        // Call Crypto.generateMac specifying the selected algorithm
        return Crypto.generateMac(
            HMACAlgorithm.HMACSHA512.name(),
            dataToHmac,
            HMAC_KEY
        );
    }

    /**
     * @description Recomputes HMAC using the symmetric key and compares it with the received one, throwing an exception if they're not equal.
     * @param hmac Blob that contains the received hmac
     * @param dataToCheck Blob that contains the data to check the hmac for
     * @example
     * ```
     * try {
     *  EncryptionRecipes.checkHMACSHA512Recipe(hmac, corruptedData);
     * } catch(Exception e) {
     *  // Should log exception
     *  System.debug(e.getMessage());
     * }
     * ```
     */
    @AuraEnabled
    public static void checkHMACSHA512Recipe(Blob hmac, Blob dataToCheck) {
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
     * @example
     * ```
     * Blob dataToSign = Blob.valueOf('Test data');
     * Blob signature = EncryptionRecipes.generateRSASHA512DigitalSignatureRecipe();
     * System.debug(EncodingUtil.base64Encode(signature));
     * ```
     */
    @AuraEnabled
    public static Blob generateRSASHA512DigitalSignatureRecipe(
        Blob dataToSign
    ) {
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
     * @example
     * ```
     * try {
     *  EncryptionRecipes.checkRSASHA512DigitalSignatureRecipe(signature, corruptedData);
     * } catch(Exception e) {
     *  // Should log exception
     *  System.debug(e.getMessage());
     * }
     * ```
     */
    @AuraEnabled
    public static void checkRSASHA512DigitalSignatureRecipe(
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
     * @example
     * ```
     * Blob dataToEncryptAndSign = Blob.valueOf('Test data');
     * EncryptedAndSignedData wrapper = EncryptionRecipes.encryptAES256AndGenerateRSASHA512DigitalSignRecipe();
     * System.debug(EncodingUtil.base64Encode(wrapper.encryptedData));
     * System.debug(EncodingUtil.base64Encode(wrapper.signature));
     * ```
     */
    @AuraEnabled
    public static EncryptedAndSignedData encryptAES256AndGenerateRSASHA512DigitalSignRecipe(
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
     * @return Decrypted data
     * @example
     * ```
     * try {
     *  EncryptionRecipes.decryptAES256AndCheckRSASHA512DigitalSignRecipe(signature, corruptedData);
     * } catch(Exception e) {
     *  // Should log exception
     *  System.debug(e.getMessage());
     * }
     * ```
     */
    @AuraEnabled
    public static Blob decryptAES256AndCheckRSASHA512DigitalSignRecipe(
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
    /**
     * Comparisons which involve cryptography need to be performed in constant time
     * using specialized functions to avoid timing attack effects.
     * https://en.wikipedia.org/wiki/Timing_attack
     * @param first first String to compare
     * @param second second String to compare
     * @return True if strings are equal
     */
    public static boolean areEqualConstantTime(String first, String second) {
        Boolean result = true;
        if (first.length() != second.length()) {
            result = false;
        }
        Integer max = first.length() > second.length()
            ? second.length()
            : first.length();
        for (Integer i = 0; i < max; i++) {
            if (first.substring(i, i + 1) != second.substring(i, i + 1)) {
                result = false;
            }
        }
        return result;
    }
}
