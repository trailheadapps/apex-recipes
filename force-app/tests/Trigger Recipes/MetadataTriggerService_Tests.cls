@isTest
private class MetadataTriggerService_Tests {
    @isTest
    static void testGetMetadataTriggers() {
        MetadataTriggerService mts = new MetadataTriggerService(
            'Invalid_Object__c'
        );
        Test.startTest();
        List<Metadata_Driven_Trigger__mdt> triggers = mts.getMetadataTriggers();
        Test.stopTest();

        System.Assert.AreEqual(
            0,
            triggers.size(),
            'Expected to find no metadata records'
        );
    }

    @isTest
    static void testGetSObjectTypeNegative() {
        Boolean didCatchProperException = false;
        Test.startTest();
        try {
            MetadataTriggerService.getSObjectType();
        } catch (MetadataTriggerService.MetadataTriggerServiceException triggerEx) {
            if (
                triggerEx.getMessage()
                    .containsIgnoreCase(
                        'trigger.new && trigger.old are both null'
                    )
            ) {
                didCatchProperException = true;
            }
        }
        Test.stopTest();
        System.Assert.isTrue(
            didCatchProperException,
            'executing this method in a unit test should result in an exception'
        );
    }
}
