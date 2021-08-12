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

    /**
     * @description        Method creates a chatter post attached to the feed of the
     * record specified by the recordId containing the specified postContents while at
     * mentioning the list of users passed in.
     * @param recordId     Id of the record to post this chatter message to
     * @param postContents  Contents of the post
     * @param toMention    List of users to @mention in the post
     */
    public void makeAPostWithMentions(
        String recordId,
        String postContents,
        List<User> toMention
    ) {
        if (ConnectApi.Organization.getSettings().features.chatter) {
            ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput(); // the feed item we're building
            feedItemInput.subjectId = recordId;
            ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput(); // body of the message
            ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput(); // the text of our message

            messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();

            textSegmentInput.text = postContents;
            messageBodyInput.messageSegments.add(textSegmentInput);
            feedItemInput.body = messageBodyInput;

            for (User u : toMention) {
                ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput();
                mentionSegmentInput.id = u.id;
                messageBodyInput.messageSegments.add(mentionSegmentInput);
            }

            ConnectApi.ChatterFeeds.postFeedElement(
                Network.getNetworkId(),
                feedItemInput
            );
        }
    }
}
