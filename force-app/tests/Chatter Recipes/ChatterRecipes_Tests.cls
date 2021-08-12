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
    static void testMakeAPostPostive() {
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
    static void testMakeACommentOnAPostPostive() {
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

    @isTest
    /**
     * @description Tests making a chatter post
     * @TODO: Refactor to create an account when
     * platform cache work is merged and we can
     * disable the use of platform cache in CanTheUser
     * during testing
     */
    static void testMakeAPostWithMentionsPostive() {
        Account acct = [SELECT id FROM Account LIMIT 1];
        // need Users to mention
        User atMentioned = TestFactory.createTestUser(true, 'Standard User');
        Test.startTest();
        cr.makeAPostWithMentions(
            acct.Id,
            'TestContents',
            new List<User>{ atMentioned }
        );
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

        System.assert(
            accountFeed[0].Body.containsIgnoreCase(atMentioned.LastName),
            'Expected message body to contain the @ mention of the test users\' last name'
        );
    }
}
