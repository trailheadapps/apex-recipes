@isTest
private inherited sharing class ScheduledApexDemo_Tests {
    @isTest
    static void counterTest() {
        ScheduledApexDemo demoObj = new ScheduledApexDemo();
        Test.startTest();
        demoObj.runAtMidnight();
        Test.stopTest();

        System.assertEquals(
            demoObj.counter,
            1,
            'Expected the counter to show 1'
        );
    }
}
