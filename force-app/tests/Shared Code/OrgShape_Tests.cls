@isTest
class OrgShape_Tests {
    @isTest
    static void testPlatformCachePositive() {
        // Apex Recipes scratch orgs enable platform cache by default
        // If this fails and you think it should succeed, ensure you have
        // a default partition specified. We cannot ship a default partition
        // selected in metadata, so you have to do this mannually!
        Test.startTest();
        Boolean result = OrgShape.isPlatformCacheEnabled();
        Test.stopTest();
        System.assert(
            result,
            'We expect this to be true. But it it might fail, if you\'ve not set a default cache partition'
        );
    }

    @isTest
    static void testGetSafeDefaultCachePartitionMemoized() {
        OrgShape.safeDefaultCachePartition = 'foo';
        Test.startTest();
        Boolean result = OrgShape.isPlatformCacheEnabled();
        Test.stopTest();
        System.assert(
            result,
            'We expect this to be true. But it it might fail, if you\'ve not set a default cache partition'
        );
    }

    @isTest(SeeAllData=true)
    @SuppressWarnings('PMD.ApexUnitTestShouldNotUseSeeAllDataTrue')
    static void testPlatformCacheDisabledWhenSeeAllDataTrue() {
        Test.startTest();
        Boolean result = OrgShape.isPlatformCacheEnabled();
        Test.stopTest();
        System.assertEquals(
            false,
            result,
            'Expected to see platform cache reported as disabled when see all data is true'
        );
    }

    @isTest(SeeAllData=true)
    @SuppressWarnings('PMD.ApexUnitTestShouldNotUseSeeAllDataTrue')
    static void testSeeAllDataPostiveWhenEnabled() {
        System.assert(
            OrgShape.isSeeAllDataTrue(),
            'Expected see all data to be true in a test method annotated with seeAllData=true'
        );
    }

    @isTest
    static void testSeeAllDataFalseWhenDisabled() {
        System.assert(
            !OrgShape.isSeeAllDataTrue(),
            'Expected see all data to be true in a test method annotated with seeAllData=true'
        );
    }
}
