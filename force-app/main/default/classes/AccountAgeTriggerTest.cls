@IsTest
public class AccountAgeTriggerTest {
    @IsTest
    static void testAccountAgeTrigger() {
        Account acc = new Account(Name='Test Account', Age__c=-5);
        Test.startTest();
        try {
            insert acc;
        } catch(Exception e) {
            System.assert(e.getMessage().contains('Please enter a valid Account age'));
        }
        Test.stopTest();
    }
}
