@isTest
private class DataFactoryForPackageInstalls_Tests {
    @isTest
    static void testGenerateDataPositive() {
        Test.startTest();
        DataFactoryForPackageInstalls.generateData();
        Test.stopTest();

        Junction__c[] junctionObjs = [SELECT ID FROM Junction__c];
        System.assertEquals(
            50,
            junctionObjs.size(),
            'Expected to find 50 junction objects'
        );
    }
}
