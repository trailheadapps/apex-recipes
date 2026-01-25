trigger OpportunityTrigger on Opportunity (before insert, before update) {
    OpportunityTriggerHandler.run(Trigger.new, Trigger.oldMap);
}
