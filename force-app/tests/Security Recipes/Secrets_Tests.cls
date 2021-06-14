@isTest
public class Secrets_Tests {
    private static final string KEYNAME = 'key001';
    private static final string SECRETNAME = 'secret1';
    private static final string SECRETVALUE = 'This is a secret';

    private static Secrets secretsInstance;
    private static SecretsKeyStorageService keyService;
    private static SecretsStorageServiceCustomMetadata storageService;
    private static SecretsData storedSecretData;

    static void beforeEach() {
        keyService = new SecretsKeyServiceCustomSettings();
        storageService = new SecretsStorageServiceCustomMetadata(keyService);
        secretsInstance = new Secrets(storageService);
        secretsInstance.createKey(Secrets_Tests.KEYNAME);
        secretsInstance.createSecret(
            Secrets_Tests.SECRETNAME,
            Secrets_Tests.SECRETVALUE,
            Secrets_Tests.KEYNAME
        );
        storedSecretData = secretsInstance.fetchSecret(
            Secrets_Tests.SECRETNAME
        );
        System.assert(
            String.isNotEmpty(storedSecretData.encryptedValue),
            'Expected to have a valid value for storedSecretData.encryptedValue'
        );
    }

    @isTest(SeeAllData=true)
    public static void fetchSecretTest() {
        beforeEach();
        List<String> secretData = storageService.validateSecretFormat(
            storedSecretData.encryptedValue
        );
        SecretsData returnObj = new SecretsData();
        returnObj.name = storedSecretData.name;
        returnObj.keyName = storedSecretData.keyName;
        returnObj.clearTextValue = storedSecretData.clearTextValue;
        returnObj.encryptedValue = storedSecretData.encryptedValue;
        SecretsStorageServiceCustomMetadata checkStorageService = (SecretsStorageServiceCustomMetadata) new Stub.Builder(
                SecretsStorageServiceCustomMetadata.class
            )
            .mockingMethodCall('retrieve')
            .withParameterTypes(String.class)
            .withParameterValues(Secrets_Tests.SECRETNAME)
            .returning(returnObj)
            .defineStub(true);

        Secrets instance = new Secrets(checkStorageService);

        Test.startTest();
        SecretsData testSecretData = instance.fetchSecret(SECRETNAME);
        Test.stopTest();

        System.assertEquals(
            SECRETVALUE,
            testSecretData.clearTextValue,
            'Expected these to be the same'
        );
    }

    @isTest
    static void testFetchDecryptedSecretPositive() {
        beforeEach();
        List<String> secretData = storageService.validateSecretFormat(
            storedSecretData.encryptedValue
        );
        SecretsData returnObj = new SecretsData();
        returnObj.name = storedSecretData.name;
        returnObj.keyName = storedSecretData.keyName;
        returnObj.clearTextValue = storedSecretData.clearTextValue;
        returnObj.encryptedValue = storedSecretData.encryptedValue;
        SecretsStorageServiceCustomMetadata checkStorageService = (SecretsStorageServiceCustomMetadata) new Stub.Builder(
                SecretsStorageServiceCustomMetadata.class
            )
            .mockingMethodCall('retrieve')
            .withParameterTypes(String.class)
            .withParameterValues(Secrets_Tests.SECRETNAME)
            .returning(returnObj)
            .defineStub(true);

        Secrets instance = new Secrets(checkStorageService);

        Test.startTest();
        SecretsData testSecretData = instance.fetchSecret(SECRETNAME);
        Test.stopTest();

        System.assertEquals(
            SECRETVALUE,
            testSecretData.clearTextValue,
            'Expected these to be the same'
        );
    }

    @isTest
    static void testUpdateSecretPositive() {
        beforeEach();
        storedSecretData.clearTextValue = 'newValue';
        Test.startTest();
        secretsInstance.updateSecret(storedSecretData);
        Test.stopTest();
        SecretsData returnObj = new SecretsData();
        returnObj.name = storedSecretData.name;
        returnObj.keyName = storedSecretData.keyName;
        returnObj.clearTextValue = storedSecretData.clearTextValue;
        returnObj.encryptedValue = storedSecretData.encryptedValue;

        SecretsStorageServiceCustomMetadata checkStorageService = (SecretsStorageServiceCustomMetadata) new Stub.Builder(
                SecretsStorageServiceCustomMetadata.class
            )
            .mockingMethodCall('retrieve')
            .withParameterTypes(String.class)
            .withParameterValues(Secrets_Tests.SECRETNAME)
            .returning(returnObj)
            .defineStub(true);

        Secrets instance = new Secrets(checkStorageService);
        SecretsData checkValue = instance.fetchSecret(SECRETNAME);
        System.assertEquals(
            'newValue',
            checkValue.clearTextValue,
            'Expected these to be the same'
        );
    }

    @isTest
    static void testValidateSecretFormatNegative() {
        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            List<String> checkList = storageService.validateSecretFormat(
                'notValid'
            );
        } catch (Secrets.SecretException se) {
            if (se.getMessage().containsIgnoreCase('has invalid format')) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();
        System.assert(
            didCatchTheRightException,
            'expected this method to have thrown a SecretException with an invalid input string.'
        );
    }

    @isTest
    static void testConstantTimeCompareDifferentLenghtNegative() {
        Boolean didCatchTheRightException = false;
        Test.startTest();
        Boolean checkBool = storageService.constantTimeCompare(
            'notValid',
            'notValid '
        );
        Test.stopTest();
        System.assertEquals(
            false,
            checkBool,
            'expected this method to return false when input strings are not the same size'
        );
    }

    @isTest
    static void testConstantTimeCompareDifferentLenghtInverseNegative() {
        Boolean didCatchTheRightException = false;
        Test.startTest();
        Boolean checkBool = storageService.constantTimeCompare(
            ' notValid',
            'notValid'
        );
        Test.stopTest();
        System.assertEquals(
            false,
            checkBool,
            'expected this method to return false when input strings are not the same size'
        );
    }

    @isTest
    static void testStorageServiceFetchNonExistingMDTRecord() {
        beforeEach();
        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            SecretsData secret = storageService.retrieve('nonExistant');
        } catch (SecretsStorageServiceCustomMetadata.SecretsStorageServiceException ssse) {
            if (
                ssse.getMessage()
                    .containsIgnoreCase('could not be found. have you deployed')
            ) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();
        System.assert(
            didCatchTheRightException,
            'Expected to have caught a SecretsStorageServiceExecption'
        );
    }
}
