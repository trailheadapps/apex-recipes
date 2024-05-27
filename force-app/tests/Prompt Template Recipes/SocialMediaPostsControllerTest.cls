@isTest
private with sharing class SocialMediaPostsControllerTest {
    @isTest
    static void testInvocation() {
        // GIVEN
        ConnectApiWrapper mockInstance = (ConnectApiWrapper) Test.createStub(
            ConnectApiWrapper.class,
            new ConnectApiWrapperMock()
        );

        // WHEN
        Test.startTest();
        String response = new SocialMediaService()
            .generateSocialMediaPosts('FakeExperienceInstanceId', mockInstance);
        Test.stopTest();

        // THEN
        Assert.areEqual(
            'Fake LLM generated response for template Generate_Social_Media_Posts',
            response,
            'Expected a different response'
        );
    }
}
