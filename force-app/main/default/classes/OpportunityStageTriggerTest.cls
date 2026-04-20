@IsTest
public class OpportunityStageTriggerTest {
    @IsTest
    static void testStageValidation() {
        Opportunity opp = new Opportunity(
            Name='Test Opp',
            StageName='Closed Won',
            CloseDate=Date.today(),
            Probability__c=50
        );
        Test.startTest();
        try {
            insert opp;
        } catch(Exception e) {
            System.assert(e.getMessage().contains('Probability must be 100% for Closed Won stage'));
        }
        Test.stopTest();
    }
}
