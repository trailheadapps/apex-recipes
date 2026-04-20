public with sharing class OpportunityTriggerHandler {

    public static void run(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        if (Trigger.isBefore) {
            OpportunityValidationService.validateStageProbability(newList);
            OpportunityValidationService.validateDiscount(newList);
        }
    }
}
