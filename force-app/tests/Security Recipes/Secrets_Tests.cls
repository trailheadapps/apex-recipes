@isTest
public class Secrets_Tests {
    @isTest
    static Void testConstructorPositive() {
        SecretsKeyServiceCustomSettings customSettingsKeyService = new SecretsKeyServiceCustomSettings();
        SecretsStorageServiceCustomMetadata storageService = new SecretsStorageServiceCustomMetadata(
            customSettingsKeyService
        );
        Test.startTest();
        Secrets secretsImplementation = new secrets(storageService);
        Test.stopTest();
        System.assert(
            secretsImplementation.storageService != null,
            'Constructor should have dependency injected the storage service.'
        );
    }

    @isTest
    static Void testFetchSecretPositive() {
        SecretsData returnObj = generateSecretsDataObject();
        SecretsKeyServiceCustomSettings customSettingsKeyService = new SecretsKeyServiceCustomSettings();
        SecretsStorageServiceCustomMetadata storageService = (SecretsStorageServiceCustomMetadata) new Stub.Builder(
                SecretsStorageServiceCustomMetadata.class
            )
            .mockingMethodCall('retrieve')
            .withParameterTypes(String.class)
            .withParameterValues('testSecret')
            .returning(returnObj)
            .defineStub(true);
        storageService.keyService = customSettingsKeyService;
        Test.startTest();
        Secrets secretsImplementation = new secrets(storageService);
        SecretsData secret = secretsImplementation.fetchSecret('testSecret');
        Test.stopTest();
        System.assertEquals(
            secret.clearTextValue,
            returnObj.clearTextValue,
            'Expected the stub to have routed the return object back'
        );
    }

    @isTest
    static Void testCreateSecretPositive() {
        SecretsKeyServiceCustomSettings customSettingsKeyService = new SecretsKeyServiceCustomSettings();
        SecretsStorageServiceCustomMetadata storageService = (SecretsStorageServiceCustomMetadata) new Stub.Builder(
                SecretsStorageServiceCustomMetadata.class
            )
            .mockingMethodCall('store')
            .withParameterTypes(String.class, String.class, String.class)
            .withParameterValues('defaultKey', 'testSecret', 'Sup3rS3cr3t!')
            .returning(true)
            .defineStub(true);
        Test.startTest();
        Secrets secretsImplementation = new secrets(storageService);
        Boolean didStore = secretsImplementation.createSecret(
            'testSecret',
            'Sup3rS3cr3t!',
            'defaultKey'
        );
        Test.stopTest();

        System.assert(didStore, 'Expected to receive true');
    }

    @isTest
    static Void testUpdateSecretPositive() {
        SecretsData secret = generateSecretsDataObject();
        SecretsKeyServiceCustomSettings customSettingsKeyService = new SecretsKeyServiceCustomSettings();
        SecretsStorageServiceCustomMetadata storageService = (SecretsStorageServiceCustomMetadata) new Stub.Builder(
                SecretsStorageServiceCustomMetadata.class
            )
            .mockingMethodCall('store')
            .withParameterTypes(String.class, String.class, String.class)
            .withParameterValues('defaultKey', 'testSecret', 'Sup3rS3cr3t!')
            .returning(true)
            .defineStub(true);
        Test.startTest();
        Secrets secretsImplementation = new secrets(storageService);
        Boolean returnedWithoutException = false;
        secretsImplementation.updateSecret(secret);
        returnedWithoutException = true;
        Test.stopTest();

        System.assert(returnedWithoutException, 'Expected to receive true');
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

        SecretsStorageServiceCustomMetadata storageService = (SecretsStorageServiceCustomMetadata) new Stub.Builder(
                SecretsStorageServiceCustomMetadata.class
            )
            .mockingMethodCall('createKey')
            .withParameterTypes(String.class)
            .withParameterValues('newKey')
            .returning(true)
            .defineStub(true);
        storageService.keyService = customSettingsKeyService;
        Test.startTest();
        Secrets secretsImplementation = new secrets(storageService);
        Boolean result = secretsImplementation.createKey('newKey');
        Test.stopTest();
        System.assert(result, 'Expected to receive true');
    }

    /////////////////// Helpers ///////////////////
    private static SecretsData generateSecretsDataObject() {
        SecretsData returnObj = new SecretsData();
        returnObj.name = 'testSecret';
        returnObj.keyName = 'defaultKey';
        returnObj.encryptedValue = 'Sup3rS3cr3t!';
        returnObj.clearTextValue = 'sup3rS3cr3t!';
        return returnObj;
    }
}
