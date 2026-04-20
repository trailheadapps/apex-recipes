public with sharing class OpportunityValidationService {

    public static void validateStageProbability(List<Opportunity> opps) {
        for (Opportunity opp : opps) {
            if (opp.StageName == 'Closed Won' && opp.Probability < 100) {
                opp.addError('Probability must be 100% when Stage is Closed Won.');
            }
        }
    }

    public static void validateDiscount(List<Opportunity> opps) {
        for (Opportunity opp : opps) {
            if (opp.Discount__c != null && opp.Discount__c > 50) {
                opp.addError('Discount cannot exceed 50%.');
            }
        }
    }
}
