@IsTest
public class OpportunityDiscountTriggerTest {
    @IsTest
    static void testDiscountTrigger() {
        Opportunity opp = new Opportunity(Name='Test Opp', StageName='Prospecting', CloseDate=Date.today(), Discount__c=60);
        Test.startTest();
        try {
            insert opp;
        } catch(Exception e) {
            System.assert(e.getMessage().contains('Discount cannot be more than 50%'));
        }
        Test.stopTest();
    }
}

