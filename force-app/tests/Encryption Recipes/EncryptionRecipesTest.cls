@isTest
private with sharing class EncryptionRecipesTest {
    @isTest
    static void encryptAndDecryptWithManagedIVRecipesTest() {
        // GIVEN
        String toEncrypt = 'Test data';
        Blob dataToEncrypt = Blob.valueOf(toEncrypt);

        // WHEN
        Test.startTest();
        Blob encryptedData = EncryptionRecipes.encryptAES256WithManagedIVRecipe(
            dataToEncrypt
        );
        Blob decryptedData = EncryptionRecipes.decryptAES256WithManagedIVRecipe(
            encryptedData
        );
        Test.stopTest();

        // THEN
        System.assertEquals(
            toEncrypt,
            decryptedData.toString(),
            'Decrypted data does not match'
        );
    }

    @isTest
    static void encryptAndDecryptRecipesTest() {
        // GIVEN
        String toEncrypt = 'Test data';
        Blob dataToEncrypt = Blob.valueOf(toEncrypt);
        Blob initializationVector = EncryptionRecipes.generateInitializationVector();

        // WHEN
        Test.startTest();
        Blob encryptedData = EncryptionRecipes.encryptAES256Recipe(
            dataToEncrypt,
            initializationVector
        );
        Blob decryptedData = EncryptionRecipes.decryptAES256Recipe(
            encryptedData
        );
        Test.stopTest();

        // THEN
        System.assertEquals(
            toEncrypt,
            decryptedData.toString(),
            'Decrypted data does not match'
        );
    }

    @isTest
    static void hashRecipesWhenSuccessTest() {
        // GIVEN
        String toHash = 'Test data';
        Blob dataToHash = Blob.valueOf(toHash);

        // WHEN
        Test.startTest();
        Blob hash = EncryptionRecipes.generateSHA512HashRecipe(dataToHash);
        EncryptionRecipes.checkSHA512HashRecipe(hash, dataToHash);
        Test.stopTest();

        // THEN
        System.assert(true, 'No error was expected');
    }

    @isTest
    static void hashRecipesWhenErrorTest() {
        // GIVEN
        String toHash = 'Test data';
        Blob dataToHash = Blob.valueOf(toHash);

        // WHEN
        Test.startTest();
        Blob hash = EncryptionRecipes.generateSHA512HashRecipe(dataToHash);
        try {
            EncryptionRecipes.checkSHA512HashRecipe(
                hash,
                Blob.valueOf('Corrupted data')
            );
            Test.stopTest();
            System.assert(false, 'An exception was expected');
        } catch (Exception e) {
            // THEN
            System.assert(
                e.getMessage().contains('Wrong hash!'),
                'The error message does not match'
            );
        }
    }

    @isTest
    static void hmacRecipesWhenSuccessTest() {
        // GIVEN
        String toHmac = 'Test data';
        Blob dataToHmac = Blob.valueOf(toHmac);

        // WHEN
        Test.startTest();
        Blob hmac = EncryptionRecipes.generateHMACSHA512Recipe(dataToHmac);
        EncryptionRecipes.checkHMACSHA512Recipe(hmac, dataToHmac);
        Test.stopTest();

        // THEN
        System.assert(true, 'No error was expected');
    }

    @isTest
    static void hmacRecipesWhenErrorTest() {
        // GIVEN
        String toHmac = 'Test data';
        Blob dataToHmac = Blob.valueOf(toHmac);

        // WHEN
        Test.startTest();
        Blob hmac = EncryptionRecipes.generateHMACSHA512Recipe(dataToHmac);
        try {
            EncryptionRecipes.checkHMACSHA512Recipe(
                hmac,
                Blob.valueOf('Corrupted data')
            );
            Test.stopTest();
            System.assert(false, 'An exception was expected');
        } catch (Exception e) {
            // THEN
            System.assert(
                e.getMessage().contains('Wrong HMAC!'),
                'The error message does not match'
            );
        }
    }

    @isTest
    static void digitalSignatureRecipesWhenSuccessTest() {
        // GIVEN
        String toSign = 'Test data';
        Blob dataToSign = Blob.valueOf(toSign);

        // WHEN
        Test.startTest();
        Blob signature = EncryptionRecipes.generateRSASHA512DigitalSignatureRecipe(
            dataToSign
        );
        EncryptionRecipes.checkRSASHA512DigitalSignatureRecipe(
            signature,
            dataToSign
        );
        Test.stopTest();

        // THEN
        System.assert(true, 'No error was expected');
    }

    @isTest
    static void digitalSignatureRecipesWhenErrorTest() {
        // GIVEN
        String toSign = 'Test data';
        Blob dataToSign = Blob.valueOf(toSign);

        // WHEN
        Test.startTest();
        Blob signature = EncryptionRecipes.generateRSASHA512DigitalSignatureRecipe(
            dataToSign
        );
        try {
            EncryptionRecipes.checkRSASHA512DigitalSignatureRecipe(
                signature,
                Blob.valueOf('Corrupted data')
            );
            Test.stopTest();
            System.assert(false, 'An exception was expected');
        } catch (Exception e) {
            // THEN
            System.assert(
                e.getMessage().contains('Wrong signature!'),
                'The error message does not match'
            );
        }
    }

    @isTest
    static void encryptionAndDigitalSignatureRecipesWhenSuccessTest() {
        // GIVEN
        String toEncryptAndSign = 'Test data';
        Blob dataToEncryptAndSign = Blob.valueOf(toEncryptAndSign);

        // WHEN
        Test.startTest();
        EncryptionRecipes.EncryptedAndSignedData wrapper = EncryptionRecipes.encryptAES256AndGenerateRSASHA512DigitalSignRecipe(
            dataToEncryptAndSign
        );
        Blob decryptedData = EncryptionRecipes.decryptAES256AndCheckRSASHA512DigitalSignRecipe(
            wrapper.signature,
            wrapper.encryptedData
        );
        Test.stopTest();

        // THEN
        System.assertEquals(
            toEncryptAndSign,
            decryptedData.toString(),
            'Encrypted and decrypted values do not match'
        );
    }

    @isTest
    static void encryptionAndDigitalSignatureRecipesWhenErrorTest() {
        // GIVEN
        String toEncryptAndSign = 'Test data';
        Blob dataToEncryptAndSign = Blob.valueOf(toEncryptAndSign);

        // WHEN
        Test.startTest();
        EncryptionRecipes.EncryptedAndSignedData wrapper = EncryptionRecipes.encryptAES256AndGenerateRSASHA512DigitalSignRecipe(
            dataToEncryptAndSign
        );
        try {
            EncryptionRecipes.decryptAES256AndCheckRSASHA512DigitalSignRecipe(
                wrapper.signature,
                Blob.valueOf('Encrypted and Corrupted data')
            );
            Test.stopTest();
            System.assert(false, 'An exception was expected');
        } catch (Exception e) {
            // THEN
            System.assert(
                e.getMessage().contains('Wrong signature!'),
                'The error message does not match'
            );
        }
    }
}
