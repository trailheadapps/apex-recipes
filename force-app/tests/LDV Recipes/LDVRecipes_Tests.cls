@isTest
private class LDVRecipes_Tests {
    @isTest
    static void testLDVRecipesQueueable() {
        StaticResource testData = [
            SELECT Id, Body, Name
            FROM StaticResource
            WHERE Name IN ('helloworld')
            LIMIT 1
        ];
        TriggerHandler.bypass('AccountTriggerHandler');
        List<Account> accounts = (List<Account>) TestFactory.createSObjectList(
            new Account(),
            20,
            true
        );
        for (Account account : accounts) {
            FilesRecipes.createFileAttachedToRecord(
                testData.Body,
                account.Id,
                'helloWorld.docx'
            );
        }

        Test.startTest();
        LDVRecipes ldvr = new LDVRecipes();
        System.enqueueJob(ldvr);
        Test.stopTest();

        System.Assert.areEqual(
            1,
            LDVRecipes.chunksExecuted,
            'Expected to find the queueable executed once.'
        );
    }
}
