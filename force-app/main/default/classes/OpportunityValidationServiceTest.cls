@isTest
private class OpportunityValidationServiceTest {

    @isTest
    static void testInvalidStageProbability() {
        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            StageName = 'Closed Won',
            Probability = 80,
            CloseDate = Date.today()
        );

        Test.startTest();
        Database.SaveResult sr = Database.insert(opp, false);
        Test.stopTest();

        System.assert(!sr.isSuccess());
    }

    @isTest
    static void testInvalidDiscount() {
        Opportunity opp = new Opportunity(
            Name = 'Discount Test',
            StageName = 'Prospecting',
            Probability = 10,
            Discount__c = 60,
            CloseDate = Date.today()
        );

        Test.startTest();
        Database.SaveResult sr = Database.insert(opp, false);
        Test.stopTest();

        System.assert(!sr.isSuccess());
    }

    @isTest
    static void testValidOpportunity() {
        Opportunity opp = new Opportunity(
            Name = 'Valid Opp',
            StageName = 'Prospecting',
            Probability = 10,
            Discount__c = 20,
            CloseDate = Date.today()
        );

        Test.startTest();
        insert opp;
        Test.stopTest();

        System.assertNotEquals(null, opp.Id);
    }
}
