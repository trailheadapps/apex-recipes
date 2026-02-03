trigger AccountAgeTrigger on Account (before insert, before update) {
    for(Account acc : Trigger.new) {
        if(acc.Age__c != null && (acc.Age__c < 0 || acc.Age__c > 150)) {
            acc.addError('Please enter a valid Account age between 0 and 150.');
        }
    }
}
