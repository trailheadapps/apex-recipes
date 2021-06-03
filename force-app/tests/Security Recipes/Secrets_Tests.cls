@isTest
public class Secrets_Tests {
    private static final string KEYNAME = 'key001';
    private static final string SECRETNAME = 'secret1';
    private static final string SECRETVALUE = 'This is a secret';

    private static Secrets secretsInstance;
    private static String serializedSecret;

    @TestSetup
    static void createKeyAndSecret() {
        SecretsStorageService storageService = new secretsStorageService();
        secretsInstance = new Secrets();
        secretsInstance.storageService = storageService;
        secretsInstance.createKey(Secrets_Tests.KEYNAME);
        Boolean result = secretsInstance.createSecret(
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
        SecretsStorageService storageService = (SecretsStorageService) new Stub.Builder(
                SecretsStorageService.class
            )
            .mockingMethodCall('fetchExistingSecret')
            .withParameterTypes(String.class)
            .withParameterValues(Secrets_Tests.SECRETNAME)
            .returning(serializedSecret)
            .defineStub(true);

        Secrets instance = new Secrets(storageService);

        Test.startTest();
        Secrets.Secret testSecret = instance.fetchSecret(SECRETNAME);
        Test.stopTest();

        System.assertEquals(
            testSecret.clearTextValue,
            SECRETVALUE,
            'Expected these to be the same'
        );
    }

    // @isTest
    // public static void fetchSecret1Test() {
    //     Test.startTest();
    //     String result = Secrets.fetchSecret(Secrets_Tests.SECRETNAME);
    //     Test.stopTest();
    //     System.assertEquals(
    //         Secrets_Tests.SECRETVALUE,
    //         result,
    //         'Expected to be able to retrieve a secret'
    //     );
    // }

    // @isTest
    // public static void fetchSecret2Test() {
    //     String secretName = 'secret2';
    //     String secretValue = 'secret1Value';
    //     String result = Secrets.fetchSecret(secretName);
    //     System.assertEquals(secretValue, result);
    // }

    // @isTest
    // public static void fetchAPIKeyTest() {
    //     String secretName = 'foobarAPI';
    //     String result = Secrets.fetchSecret(secretName);
    //     System.assertNotEquals('', result);
    // }
}
