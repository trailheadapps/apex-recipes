public with sharing class SocialMediaPostsController {
    @AuraEnabled
    public static String generateSocialMediaPosts(String experienceInstanceId) {
        return new SocialMediaService()
            .generateSocialMediaPosts(
                experienceInstanceId,
                new ConnectApiWrapper()
            );
    }
}
