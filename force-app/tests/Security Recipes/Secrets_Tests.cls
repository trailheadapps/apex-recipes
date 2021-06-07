@isTest
public class Secrets_Tests {
    private static final string KEYNAME = 'key001';
    private static final string SECRETNAME = 'secret1';
    private static final string SECRETVALUE = 'This is a secret';

    private static Secrets secretsInstance;
    private static SecretsStorageService storageService;
    private static String serializedSecret;
    private static Secrets.Secret testSecret;

    static void beforeEach() {
        storageService = new secretsStorageService();
        secretsInstance = new Secrets();
        secretsInstance.storageService = storageService;
        secretsInstance.createKey(Secrets_Tests.KEYNAME);
        testSecret = secretsInstance.createSecret(
            Secrets_Tests.SECRETNAME,
            Secrets_Tests.SECRETVALUE,
            Secrets_Tests.KEYNAME
        );
        serializedSecret = storageService.serializedSecret;
        System.assert(
            String.isNotEmpty(serializedSecret),
            'Expected to have a valid value for serializedSecret'
        );
    }

    @isTest
    public static void fetchSecretTest() {
        beforeEach();
        Secrets.Secret secret = new Secrets.Secret();
        List<String> secretData = secret.validateSecretFormat(serializedSecret);
        SecretMDT__mdt returnObj = new SecretMDT__mdt();
        returnObj.label = Secrets_Tests.SECRETNAME;
        returnObj.value__c = serializedSecret;
        SecretsStorageService checkStorageService = (SecretsStorageService) new Stub.Builder(
                SecretsStorageService.class
            )
            .mockingMethodCall('fetchExistingSecret')
            .withParameterTypes(String.class)
            .withParameterValues(Secrets_Tests.SECRETNAME)
            .returning(returnObj)
            .defineStub(true);

        Secrets instance = new Secrets(checkStorageService);

        Test.startTest();
        Secrets.Secret testSecret = instance.fetchSecret(SECRETNAME);
        Test.stopTest();

        System.assertEquals(
            SECRETVALUE,
            testSecret.decryptSecret(),
            'Expected these to be the same'
        );
    }

    @isTest
    static void testFetchDecryptedSecretPositive() {
        beforeEach();
        Secrets.Secret secret = new Secrets.Secret();
        List<String> secretData = secret.validateSecretFormat(serializedSecret);
        SecretMDT__mdt returnObj = new SecretMDT__mdt();
        returnObj.label = Secrets_Tests.SECRETNAME;
        returnObj.value__c = serializedSecret;
        SecretsStorageService checkStorageService = (SecretsStorageService) new Stub.Builder(
                SecretsStorageService.class
            )
            .mockingMethodCall('fetchExistingSecret')
            .withParameterTypes(String.class)
            .withParameterValues(Secrets_Tests.SECRETNAME)
            .returning(returnObj)
            .defineStub(true);

        Secrets instance = new Secrets(checkStorageService);

        Test.startTest();
        String testSecret = instance.fetchDecryptedSecretValue(SECRETNAME);
        Test.stopTest();

        System.assertEquals(
            SECRETVALUE,
            testSecret,
            'Expected these to be the same'
        );
    }

    @isTest
    static void testUpdateSecretPositive() {
        beforeEach();
        Test.startTest();
        testSecret.updateSecret('newValue');
        Test.stopTest();
        serializedSecret = testSecret.storageService.serializedSecret;
        Secrets.Secret secret = new Secrets.Secret();
        List<String> secretData = secret.validateSecretFormat(serializedSecret);
        SecretMDT__mdt returnObj = new SecretMDT__mdt();
        returnObj.label = Secrets_Tests.SECRETNAME;
        returnObj.value__c = serializedSecret;

        SecretsStorageService checkStorageService = (SecretsStorageService) new Stub.Builder(
                SecretsStorageService.class
            )
            .mockingMethodCall('fetchExistingSecret')
            .withParameterTypes(String.class)
            .withParameterValues(Secrets_Tests.SECRETNAME)
            .returning(returnObj)
            .defineStub(true);

        Secrets instance = new Secrets(checkStorageService);
        String checkValue = instance.fetchDecryptedSecretValue(SECRETNAME);
        System.assertEquals(
            'newValue',
            checkValue,
            'Expected these to be the same'
        );
    }

    @isTest
    static void testValidateSecretFormatNegative() {
        Secrets.Secret secret = new Secrets.Secret();
        Boolean didCatchTheRightException = false;
        Test.startTest();
        try {
            List<String> checkList = secret.validateSecretFormat('notValid');
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
        Secrets.Secret secret = new Secrets.Secret();
        Boolean didCatchTheRightException = false;
        Test.startTest();
        Boolean checkBool = secret.constantTimeCompare('notValid', 'notValid ');
        Test.stopTest();
        System.assertEquals(
            false,
            checkBool,
            'expected this method to return false when input strings are not the same size'
        );
    }

    @isTest
    static void testConstantTimeCompareDifferentLenghtInverseNegative() {
        Secrets.Secret secret = new Secrets.Secret();
        Boolean didCatchTheRightException = false;
        Test.startTest();
        Boolean checkBool = secret.constantTimeCompare(' notValid', 'notValid');
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
            SecretMDT__mdt secret = storageService.fetchExistingSecret(
                'nonExistant'
            );
        } catch (SecretsStorageService.SecretsStorageServiceException ssse) {
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
