@isTest
private class SecretsVaultCustomMetadata_Tests {
    public final static String TESTJSON = '{"request_id":"1","lease_id":"234","renewable":true,"lease_duration":5000,"data":{"ciphertext":"a;sldfkjas;dlkf","plaintext":"Rm9vQmFyQmF6","key_version":3}}';
    private static SecretsKeyStorageService testKeyService;
    static {
        testKeyService = new SecretsKeyServiceCustomSettings();
    }

    @isTest
    static Void testConstructorPositive() {
        Test.startTest();
        SecretsVaultCustomMetadata instance = new SecretsVaultCustomMetadata(
            testKeyService
        );
        Test.StopTest();

        System.assert(
            instance.keyService != null,
            'Expected the key service to have been set by the constructor'
        );
    }

    @isTest
    static Void testCreateKeyReturnsFalsePositive() {
        Test.startTest();
        SecretsVaultCustomMetadata instance = new SecretsVaultCustomMetadata(
            testKeyService
        );
        Boolean result = instance.createKey('newKey');
        Test.stopTest();
        System.assertEquals(false, result, 'Expected to receive false');
    }

    @isTest
    static Void testStoreReturnsFalsePositive() {
        Test.startTest();
        SecretsVaultCustomMetadata instance = new SecretsVaultCustomMetadata(
            testKeyService
        );
        instance.createKey('newKey');
        Boolean result = instance.store('newKey', 'SecretName', 'ClearText');
        Test.stopTest();
        System.assertEquals(false, result, 'Expected to receive false');
    }

    @isTest
    static Void testRetrievePositive() {
        String serializedSecret = 'testKey~a;sldfkjas;dlkf';
        SecretsVaultCustomMetadata storageInstance = new SecretsVaultCustomMetadata(
            testKeyService
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

        HttpCalloutMock mock = new HttpCalloutMockFactory(
            201,
            'OK',
            TESTJSON,
            new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, mock);
        VaultEncrypt checkData = VaultEncrypt.parse(TESTJSON);
        Test.startTest();
        SecretsData data = storageInstance.retrieve('testItem');
        Test.stopTest();
        System.assertEquals(
            data.clearTextValue,
            EncodingUtil.base64Decode(checkData.Data.plaintext).toString(),
            'Expected the mock to return the hard coded plain text'
        );
    }

    @isTest
    static Void testEncryptDataPositiveHttpMock() {
        HttpCalloutMock mock = new HttpCalloutMockFactory(
            201,
            'OK',
            TESTJSON,
            new Map<String, String>()
        );
        SecretsVaultCustomMetadata instance = new SecretsVaultCustomMetadata(
            testKeyService
        );
        instance.createKey('newKey');
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        String result = instance.encryptData(
            'newKey',
            'someSecret',
            'fooBarBaz1'
        );
        Test.stopTest();
        VaultEncrypt checkData = VaultEncrypt.parse(TESTJSON);
        System.assertEquals(
            result,
            checkData.Data.ciphertext,
            'Expected the mock to return the hard coded cipher text'
        );
    }

    @isTest
    static Void testDecryptDataPositiveHttpMock() {
        HttpCalloutMock mock = new HttpCalloutMockFactory(
            201,
            'OK',
            TESTJSON,
            new Map<String, String>()
        );
        SecretsVaultCustomMetadata instance = new SecretsVaultCustomMetadata(
            testKeyService
        );
        instance.createKey('newKey');
        Test.setMock(HttpCalloutMock.class, mock);
        VaultEncrypt checkData = VaultEncrypt.parse(TESTJSON);
        Test.startTest();
        String result = instance.decryptData(
            'newKey',
            'someSecret',
            checkData.Data.ciphertext
        );
        Test.stopTest();
        System.assertEquals(
            result,
            EncodingUtil.base64Decode(checkData.Data.plaintext).toString(),
            'Expected the mock to return the hard coded plain text'
        );
    }

    @isTest
    static Void testValidateSecretFormatPositive() {
        SecretsVaultCustomMetadata instance = new SecretsVaultCustomMetadata(
            testKeyService
        );
        Test.startTest();
        List<String> parts = instance.validateSecretFormat('Some~String');
        Test.stopTest();
        System.assertEquals(
            parts.size(),
            2,
            'expected this to pass with two parts'
        );
    }

    @isTest
    static Void testValidateSecretFormatNegative() {
        SecretsVaultCustomMetadata instance = new SecretsVaultCustomMetadata(
            testKeyService
        );
        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            List<String> parts = instance.validateSecretFormat('SomeString');
        } catch (SecretsCustomMetadataStorageBase.SecretsStorageServiceException storageException) {
            if (
                storageException.getMessage()
                    .containsIgnoreCase('invalid format')
            ) {
                didCatchTheRightException = true;
            }
        }

        Test.stopTest();
        System.assert(
            didCatchTheRightException,
            'Expected to have caught a Secrets Storage Service Exception'
        );
    }
}
