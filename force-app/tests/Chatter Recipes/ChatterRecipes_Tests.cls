/**
 * @description DO NOT USE USE SEE ALL DATA = true unless
 * TESTING CHATTER
 */
@isTest(SeeAllData=true)
private class ChatterRecipes_Tests {
    private static ChatterRecipes cr = new ChatterRecipes();

    @isTest
    /**
     * @description Tests making a chatter post
     * @TODO: Refactor to create an account when
     * platform cache work is merged and we can
     * disable the use of platform cache in CanTheUser
     * during testing
     */
    static void testMakeAPost_Postive() {
        Account acct = [SELECT id FROM Account LIMIT 1];
        Test.startTest();
        cr.makeAPost(acct.Id, 'TestContents');
        Test.stopTest();
        List<AccountFeed> accountFeed = [
            SELECT Title, Body
            FROM AccountFeed
            WHERE parentId = :acct.id
        ];
        System.assertEquals(
            1,
            accountFeed.size(),
            'Expected to find one chatter post associated with this account'
        );
    }

    @isTest
    static void testMakeACommentOnAPost_Postive() {
        Account acct = [SELECT id FROM Account LIMIT 1];
        Test.startTest();
        cr.makeAPost(acct.Id, 'TestContents');
        Test.stopTest();
        List<AccountFeed> accountFeed = [
            SELECT Title, Body
            FROM AccountFeed
            WHERE parentId = :acct.id
        ];
        System.assertEquals(
            1,
            accountFeed.size(),
            'Expected to find one chatter post associated with this account'
        );

        cr.commentOnPost(accountFeed[0].Id, 'hey look it\'s a comment. W00t.');
        List<FeedComment> accountFeedWithComment = [
            SELECT Id
            FROM FeedComment
            WHERE feedItemId = :accountFeed[0].id
        ];
        System.assertEquals(
            1,
            accountFeedWithComment.size(),
            'Expected to find one chatter post and one comment associated with this account'
        );
    }
}
