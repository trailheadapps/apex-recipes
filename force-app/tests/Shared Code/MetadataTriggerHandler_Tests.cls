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

        System.Assert.isNull(
            mdtHandler.activeHandler,
            'Expected the activeHandler Property to be null, as no handlers were returned.'
        );
    }

    @isTest
    static void testExecutesBeforeInsertPositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'before insert'
        );
    }

    @isTest
    static void testExecutesBeforeUpdatePositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'before update'
        );
    }

    @isTest
    static void testExecutesBeforeDeletePositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'before delete'
        );
    }

    @isTest
    static void testExecutesAfterInsertPositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'after insert'
        );
    }

    @isTest
    static void testExecutesAfterUpdatePositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'after update'
        );
    }

    @isTest
    static void testExecutesAfterDeletePositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'after delete'
        );
    }

    @isTest
    static void testExecutesAfterUndeletePositive() {
        MetadataTriggerHandler_Tests.exerciseTriggerHandlerPositive(
            'after undelete'
        );
    }

    private static void exerciseTriggerHandlerPositive(String context) {
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

        mdtHandler.setTriggerContext(context, true);

        Test.startTest();
        mdtHandler.run();
        Test.stopTest();

        System.Assert.areEqual(
            'SampleHandler',
            TestHelper.getUnknownObjectType(mdtHandler.activeHandler),
            'Expected the activeHandler Property to be \'SampleHandler\'.'
        );
    }
}
