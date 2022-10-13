@isTest
private inherited sharing class FilesRecipes_Tests {
    @TestSetup
    static void makeData() {
        Account acct = (Account) TestFactory.createSObject(
            new Account(name = 'Test Account'),
            true
        );

        StaticResource[] testData = [
            SELECT Id, Body, Name
            FROM StaticResource
            WHERE Name IN ('helloaudio', 'helloworld', 'logo')
        ];

        for (StaticResource resource : testData) {
            String fileName = '';
            if (resource.Name.equalsIgnoreCase('logo')) {
                fileName = resource.Name + '.png';
            } else if (resource.Name.equalsIgnoreCase('helloworld')) {
                fileName = resource.Name + '.docx';
            } else {
                filename = resource.Name + '.m4a';
            }
            FilesRecipes.createFileAttachedToRecord(
                resource.Body,
                acct.Id,
                fileName
            );
        }
    }

    @isTest
    static void testPublishContent() {
        Account acct = [SELECT Id FROM Account LIMIT 1];
        String text = 'Hello Good Friends, enjoy the stream!';
        FilesRecipes.createFileFromStringAttachedToRecord(text, acct.Id);
        ContentDocumentLink cdl = [
            SELECT Id, LinkedEntityId, ContentDocument.LatestPublishedVersionId
            FROM ContentDocumentLink
            WHERE LinkedEntityId = :acct.Id
            LIMIT 1
        ];

        Test.startTest();
        FilesRecipes.publishContent(cdl);
        Test.stopTest();

        ContentDistribution dist = [
            SELECT Id, ContentDownloadUrl
            FROM ContentDistribution
            WHERE RelatedRecordId = :acct.Id
            LIMIT 1
        ];
        System.Assert.isTrue(
            String.isNotBlank(dist.ContentDownloadUrl),
            'Expected to find a download url'
        );
    }

    @isTest
    static void testUploadFileFromText() {
        Account acct = [SELECT Id FROM Account LIMIT 1];
        String text = 'Hello Good Friends, enjoy the stream!';

        Test.startTest();
        FilesRecipes.createFileFromStringAttachedToRecord(text, acct.Id);
        Test.stopTest();

        ContentVersion[] results = [
            SELECT Id, FirstPublishLocationId, Title, PathOnClient
            FROM ContentVersion
            WHERE FirstPublishLocationId = :acct.Id AND title = 'AwesomeFile1'
        ];

        System.Assert.areEqual(1, results.size(), 'Expected to find one file');
    }

    @isTest
    static void testGetFilteredAttachmentsForRecords() {
        Id attachedRecordId = [SELECT Id FROM Account LIMIT 1].Id;

        Test.startTest();
        List<ContentVersion> audioFiles = FilesRecipes.getFilteredAttachmentsForRecord(
            FilesRecipes.genericFileType.AUDIO,
            attachedRecordId
        );
        List<ContentVersion> imageFiles = FilesRecipes.getFilteredAttachmentsForRecord(
            FilesRecipes.genericFileType.IMAGE,
            attachedRecordId
        );
        List<ContentVersion> docFiles = FilesRecipes.getFilteredAttachmentsForRecord(
            FilesRecipes.genericFileType.DOCUMENT,
            attachedRecordId
        );
        List<ContentVersion> all = FilesRecipes.getFilteredAttachmentsForRecord(
            FilesRecipes.genericFileType.ALL,
            attachedRecordId
        );
        Test.stopTest();

        System.Assert.areEqual(
            1,
            audioFiles.size(),
            'Expected to find 1 audio file'
        );
        System.Assert.areEqual(
            1,
            imageFiles.size(),
            'Expected to find 1 image file'
        );
        System.Assert.areEqual(
            1,
            docFiles.size(),
            'Expected to find 1 document file'
        );

        System.Assert.areEqual(3, all.size(), 'Expected to find 3 total files');
    }
}
