/**
 * @description Demonstrates how to use different encryption and signing algorithms in Apex
 * @group Encryption Recipes
 */
public with sharing class EncryptionRecipes {
    public static final Blob AES_KEY = Crypto.generateAESKey(256);

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

    /**
     * @description Internal custom exception class
     */
    public class CryptographicException extends Exception {
    }

    /**
     * @description Encrypts data using AES algorithm, which needs a symmetric key to be shared with the receiver.
     * In this case the initialization vector is managed by Salesforce.
     * @return Blob
     * @example
     * Blob encryptedData = EncryptionRecipes.encryptWithManagedIVRecipe();
     * System.debug(EncodingUtil.base64Encode(encryptedData));
     **/
    @AuraEnabled
    public static Blob encryptWithManagedIVRecipe() {
        // Generate a Blob that contains the AES key to use

        // Generate a Blob that contains some data to encrypt
        Blob dataToEncrypt = Blob.valueOf('Test data');
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
     * @param dataToDecrypt Blob that contains the data to be decrypted.
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
     * @return Blob
     * @example
     * Blob encryptedData = EncryptionRecipes.encryptRecipe();
     * System.debug(EncodingUtil.base64Encode(encryptedData));
     **/
    @AuraEnabled
    public static Blob encryptRecipe() {
        // Generate a Blob that contains some data to encrypt
        Blob dataToEncrypt = Blob.valueOf('Test data');
        // Generate a random initialization vector
        Blob initializationVector = EncryptionRecipes.generateInitializationVector();
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
     * @param dataToDecrypt Blob that contains the data to be decrypted.
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
     * @return Blob
     * Blob hash = EncryptionRecipes.generateHashRecipe();
     * System.debug(EncodingUtil.base64Encode(hash));
     **/
    @AuraEnabled
    public static Blob generateHashRecipe() {
        // Generate a Blob that contains some data to hash
        Blob dataToHash = Blob.valueOf('Test data');
        // Call Crypto.generateDigest specifying the selected Hashing Algorithm
        return Crypto.generateDigest(HashAlgorithm.SHA512.name(), dataToHash);
    }

    /**
     * @description Generates one-way hash digest that can be checked in destination to ensure integrity.
     * @return void
     * try {
     *  EncryptionRecipes.checkHashRecipe(corruptedData, hash);
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
}
