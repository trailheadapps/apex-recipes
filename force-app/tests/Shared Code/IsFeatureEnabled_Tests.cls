@isTest
class IsFeatureEnabled_Tests {
    @isTest
    static void testPlatformCachePositive() {
        // Apex Recipes scratch orgs enable platform cache by default
        // If this fails and you think it should succeed, ensure you have
        // a default partition specified. We cannot ship a default partition
        // selected in metadata, so you have to do this mannually!
        Test.startTest();
        Boolean result = IsFeatureEnabled.platformCache();
        Test.stopTest();
        System.assert(
            result,
            'We expect this to be true. But it it might fail, if you\'ve not set a default cache partition'
        );
    }

    @isTest
    static void testPlatformCachePositiveNoCache() {
        IsFeatureEnabled.disablePlatformCache = true;
        Test.startTest();
        Boolean result = IsFeatureEnabled.platformCache();
        Test.stopTest();
        System.assert(
            !result,
            'Expected the @testVisible private static variable to override the presence of Org Cache'
        );
    }

    @isTest(SeeAllData=true)
    static void testSeeAllDataPostiveWhenEnabled() {
        System.assert(
            IsFeatureEnabled.isSeeAllDataTrue(),
            'Expected see all data to be true in a test method annotated with seeAllData=true'
        );
    }

    @isTest
    static void testSeeAllDataFalseWhenDisabled() {
        System.assert(
            !IsFeatureEnabled.isSeeAllDataTrue(),
            'Expected see all data to be true in a test method annotated with seeAllData=true'
        );
    }
}
