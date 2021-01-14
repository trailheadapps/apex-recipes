/**
 * @description Demonstrates common use cases in / with / for chatter
 */
public inherited sharing class ChatterRecipes {
    /**
     * Make a chatter Post
     * Make a comment on a post
     *
     * Make a post with:
     *  - mention
     *  - file
     *  - with code
     */

    public void makeAPost(String recordId, String postContents) {
        // chatter is not on?
        // bad id
        // null contents

        if (ConnectApi.Organization.getSettings().features.chatter) {
            ConnectApi.FeedElement newPost = ConnectApi.ChatterFeeds.postFeedElement(
                Network.getNetworkId(),
                recordId,
                ConnectApi.FeedElementType.FEEDITEM,
                postContents
            );
        }
    }

    public void commentOnPost(String postId, string comment) {
        if (ConnectApi.Organization.getSettings().features.chatter) {
            ConnectApi.Comment newComment = ConnectApi.ChatterFeeds.postCommentToFeedElement(
                'internal',
                postId,
                comment
            );
        }
    }
}
