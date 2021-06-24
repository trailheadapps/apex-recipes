@isTest
private class SecretsStorageServiceCustomMdta_Tests {
    private static SecretsKeyStorageService testKeyService;
    static {
        testKeyService = new SecretsKeyServiceCustomSettings();
    }

    @isTest
    static Void testSingleParameterConstructorPositive() {
        Test.startTest();
        SecretsStorageServiceCustomMetadata cmdtStorage = new secretsStorageServiceCustomMetadata(
            testKeyService
        );
        Test.stopTest();
        System.assert(
            cmdtStorage.keyService != null,
            'expected constructor to set key service'
        );
    }

    @isTest
    static Void test4ParameterConstructorPositive() {
        Test.startTest();
        SecretsStorageServiceCustomMetadata cmdtStorage = new secretsStorageServiceCustomMetadata(
            testKeyService,
            SecretsStorageServiceCustomMetadata.EncryptionAlgorithm.AES256,
            SecretsStorageServiceCustomMetadata.HmacAlgorithm.HMACSHA512,
            256
        );
        Test.stopTest();
        System.assert(
            cmdtStorage.keyService != null,
            'expected constructor to set key service'
        );
    }

    @isTest
    static Void testCreateKeyPositive() {
        SecretsKeyServiceCustomSettings customSettingsKeyService = (SecretsKeyServiceCustomSettings) new Stub.Builder(
                SecretsKeyServiceCustomSettings.class
            )
            .mockingMethodCall('createKey')
            .withParameterTypes(String.class, Integer.class)
            .withParameterValues('newKey', 256)
            .returning(true)
            .defineStub(true);

        Test.startTest();
        SecretsStorageServiceCustomMetadata storageInstance = new secretsStorageServiceCustomMetadata(
            customSettingsKeyService
        );
        Boolean result = storageInstance.createKey('newKey');
        Test.stopTest();
        System.assert(result, 'Expected to receive true if a key was created');
    }

    @isTest
    static Void testStorePositive() {
        SecretsStorageServiceCustomMetadata storageInstance = new secretsStorageServiceCustomMetadata(
            testKeyService
        );
        Test.startTest();
        storageInstance.createKey('newKey');
        Boolean result = storageInstance.store(
            'newKey',
            'newSecret',
            'this is a secret'
        );
        Test.stopTest();
        System.assert(result, 'The store call should return true or throw');
    }

    @isTest
    static Void testStoreNegativeBlankSecret() {
        SecretsStorageServiceCustomMetadata storageInstance = new secretsStorageServiceCustomMetadata(
            testKeyService
        );
        Boolean didCatchTheRightException = false;
        storageInstance.createKey('newKey');
        Test.startTest();
        try {
            storageInstance.store('newKey', 'newSecret', '');
        } catch (SecretsCustomMetadataStorageBase.SecretsStorageServiceException ssse) {
            if (
                ssse.getMessage()
                    .containsIgnoreCase('cleartext parameter is empty')
            ) {
                didCatchTheRightException = true;
            }
        }

        Test.stopTest();
        System.assert(
            didCatchTheRightException,
            'We should prevent blank clear text secrets from being stored'
        );
    }

    @isTest
    static Void testSerializeSecretPositive() {
        SecretsStorageServiceCustomMetadata storageInstance = new secretsStorageServiceCustomMetadata(
            testKeyService
        );
        Test.startTest();
        String result = storageInstance.serializeSecret(
            'newKey',
            'fake encoded value',
            'fake hmac'
        );
        Test.stopTest();
        System.assert(
            result.containsIgnoreCase('newKey'),
            'serialized string should contain newkey'
        );
        System.assert(
            result.containsIgnoreCase('fake encoded value'),
            'serialized string should contain fake encoded value'
        );
        System.assert(
            result.containsIgnoreCase('fake hmac'),
            'serialized string should contain fake hmac value'
        );
        System.assert(
            result.split('~').size() == 5,
            'Expected to find 5 parts of the serialized string'
        );
    }

    @isTest
    static Void testConstantTimeComparePositiveSameString() {
        SecretsStorageServiceCustomMetadata storageInstance = new secretsStorageServiceCustomMetadata(
            testKeyService
        );
        Test.startTest();
        Boolean result = storageInstance.constantTimeCompare('test', 'test');
        Test.stopTest();
        System.assert(
            result,
            'expected this to return true for two identical strings'
        );
    }

    @isTest
    static Void testConstantTimeComparePositiveDiffStrings() {
        SecretsStorageServiceCustomMetadata storageInstance = new secretsStorageServiceCustomMetadata(
            testKeyService
        );
        Test.startTest();
        Boolean result = storageInstance.constantTimeCompare('test2', 'test');
        Test.stopTest();
        System.assertEquals(
            result,
            false,
            'expected this to return true for two identical strings'
        );
    }

    @isTest
    static Void testConstantTimeComparePositive2ndStringLonger() {
        SecretsStorageServiceCustomMetadata storageInstance = new secretsStorageServiceCustomMetadata(
            testKeyService
        );
        Test.startTest();
        Boolean result = storageInstance.constantTimeCompare(
            'test',
            'testing123'
        );
        Test.stopTest();
        System.assertEquals(
            result,
            false,
            'expected this to return true for two identical strings'
        );
    }

    @isTest
    static Void testValidateSecretFormatPositive() {
        SecretsStorageServiceCustomMetadata storageInstance = new secretsStorageServiceCustomMetadata(
            testKeyService
        );
        String serializedSecret = storageInstance.serializeSecret(
            'newKey',
            'fake encoded value',
            'fake hmac'
        );
        Test.startTest();
        List<String> results = storageInstance.validateSecretFormat(
            serializedSecret
        );
        Test.stopTest();
        System.assertEquals(results.size(), 5, 'expected to get 5 parts back');
    }

    @isTest
    static Void testValidateSecretFormatNegative() {
        SecretsStorageServiceCustomMetadata storageInstance = new secretsStorageServiceCustomMetadata(
            testKeyService
        );
        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            List<String> results = storageInstance.validateSecretFormat(
                'This string contains no tildes'
            );
        } catch (SecretsCustomMetadataStorageBase.SecretsStorageServiceException storageServiceException) {
            if (
                storageServiceException.getMessage()
                    .containsIgnoreCase('secret has invalid format')
            ) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();
        System.assert(
            didCatchTheRightException,
            'expected to get an exception when the formatted string is invalid'
        );
    }

    @isTest
    static Void testRetrievePositive() {
        SecretsStorageServiceCustomMetadata storageInstance = new secretsStorageServiceCustomMetadata(
            testKeyService
        );
        storageInstance.createKey('testKey');
        storageInstance.store('testKey', 'testItem', '$up3r$3cr3t!');
        String serializedSecret = storageInstance.serializedSecret;
        System.assert(
            serializedSecret != null,
            'Serialized secret should not be null'
        );

        SecretsCustomMetadataStorageBase storageBaseStub = (SecretsCustomMetadataStorageBase) new Stub.Builder(
                SecretsCustomMetadataStorageBase.class
            )
            .mockingMethodCall('fetchEncryptedValue')
            .withParameterTypes(String.class)
            .withParameterValues('testItem')
            .returning(serializedSecret)
            .defineStub(true);
        storageInstance.storageBase = storageBaseStub;

        Test.startTest();
        SecretsData secret = storageInstance.retrieve('testItem');
        Test.stopTest();
        System.assertEquals(
            secret.clearTextValue,
            '$up3r$3cr3t!',
            'Expected to see decrypted values match'
        );
    }
}
