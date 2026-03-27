trigger OpportunityStageTrigger on Opportunity (before insert, before update) {
    for(Opportunity opp : Trigger.new) {
        if(opp.StageName == 'Closed Won' && opp.Probability__c != 100) {
            opp.addError('Probability must be 100% for Closed Won stage.');
        }
        if(opp.StageName == 'Closed Lost' && opp.Probability__c != 0) {
            opp.addError('Probability must be 0% for Closed Lost stage.');
        }
    }
}
