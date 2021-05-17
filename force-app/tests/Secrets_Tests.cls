@isTest
public class Secrets_Tests {

    @isTest(SeeAllData=true)
    public static void storeSecret1_Test(){
        String keyName = 'key001';
        String secretName = 'secret1';
        String secretValue = 'secret1Value';
        Boolean result = Secrets.storeSecret(secretName, secretValue, keyName);
        System.assertEquals(true, result);
    }

    @isTest(SeeAllData=true)
    public static void fetchSecret1_Test() {
        String secretName = 'secret1';
        String secretValue = 'secret1Value';
        String result = Secrets.fetchSecret(secretName);
        System.assertEquals(secretValue, result);
    }

    @isTest(SeeAllData=true)
    public static void fetchSecret2_Test() {
        String secretName = 'secret2';
        String secretValue = 'secret1Value';
        String result = Secrets.fetchSecret(secretName);
        System.assertEquals(secretValue, result);
    }

    @isTest(SeeAllData=true)
    public static void fetchAPIKey_Test() {
        String secretName = 'foobarAPI';
        String result = Secrets.fetchSecret(secretName);
        System.assertNotEquals('', result);
    }


}