trigger OpportunityDiscountTrigger on Opportunity (before insert, before update) {
    for(Opportunity opp : Trigger.new) {
        if(opp.Discount__c != null && opp.Discount__c > 50) {
            opp.addError('Discount cannot be more than 50%');
        }
    }
}
