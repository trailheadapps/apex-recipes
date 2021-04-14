@isTest
private class MetadataTriggerHandler_Tests {
    @isTest
    static void testMetadataTriggerHandlerNoOppWithoutRecordsPositive() {
        TestDouble stub = new TestDouble(MetadataTriggerService.class);
        TestDouble.Method stubbedGetMetatdataRecords = new TestDouble.Method(
                'getMetadataTriggers'
            )
            .returning(new List<Metadata_Driven_Trigger__mdt>());

        stub.track(stubbedGetMetatdataRecords);

        MetadataTriggerHandler mdtHandler = new MetadataTriggerHandler(
            (MetadataTriggerService) stub.generate()
        );

        mdtHandler.setTriggerContext('after update', true);

        Test.startTest();
        mdtHandler.run();
        Test.stopTest();

        System.assertEquals(
            null,
            mdtHandler.activeHandler,
            'Expected the activeHandler Property to be null, as no handlers were returned.'
        );
    }

    @isTest
    static void testExecutesSampleHandlerWhenMdtIsReturnedPositive() {
        Metadata_Driven_Trigger__mdt sampleHandler = new Metadata_Driven_Trigger__mdt();
        sampleHandler.class__c = 'sampleHandler';
        sampleHandler.enabled__c = true;
        sampleHandler.execution_Order__c = 1;
        sampleHandler.object__c = 'contact';

        TestDouble stub = new TestDouble(MetadataTriggerService.class);
        TestDouble.Method stubbedGetMetatdataRecords = new TestDouble.Method(
                'getMetadataTriggers'
            )
            .returning(new List<Metadata_Driven_Trigger__mdt>{ sampleHandler });

        stub.track(stubbedGetMetatdataRecords);

        MetadataTriggerHandler mdtHandler = new MetadataTriggerHandler(
            (MetadataTriggerService) stub.generate()
        );

        mdtHandler.setTriggerContext('after update', true);

        Test.startTest();
        mdtHandler.run();
        Test.stopTest();

        System.assertEquals(
            'SampleHandler',
            TestHelper.getUnkownObjectType(mdtHandler.activeHandler),
            'Expected the activeHandler Property to be \'SampleHandler\'.'
        );
    }
}
