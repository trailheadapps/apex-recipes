@isTest
class OrgShape_Tests {
    private static OrgShape orgShape;
    private static Organization orgCheck;
    static {
        orgShape = new orgShape();
        orgCheck = [SELECT FIELDS(STANDARD) FROM Organization LIMIT 1];
    }

    @isTest
    static void testProperties() {
        System.assertEquals(
            orgCheck.isSandbox,
            orgShape.isSandbox,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            UserInfo.isMultiCurrencyOrganization(),
            orgShape.multiCurrencyEnabled,
            'Expected the OrgShape property to match the UserInfo property'
        );
        System.assertEquals(
            orgCheck.OrganizationType,
            orgShape.orgType,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.isReadOnly,
            orgShape.isReadOnly,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.instanceName,
            orgShape.instanceName,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.instanceName,
            orgShape.podName,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.fiscalYearStartMonth,
            orgShape.getFiscalYearStartMonth,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            UserInfo.getUiThemeDisplayed().containsIgnoreCase('theme4'),
            orgShape.lightningEnabled,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.id,
            orgShape.id,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.languageLocaleKey,
            orgShape.locale,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.timeZoneSidKey,
            orgShape.timeZoneKey,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.name,
            orgShape.name,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.namespacePrefix,
            orgShape.namespacePrefix,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            String.isNotBlank(orgCheck.namespacePrefix),
            orgShape.hasNamespacePrefix,
            'Expected the OrgShape property to match the query'
        );
        System.assertEquals(
            orgCheck.id,
            orgShape.id,
            'expected these to be equal'
        );
    }

    @isTest
    static void testAdvancedMultiCurrencyManagement() {
        Boolean datedConversionRateObjectExists = false;
        try {
            Database.query('SELECT Id FROM DatedConversionRate LIMIT 1').size();
            datedConversionRateObjectExists = true;
        } catch (Exception e) {
            // no op, as we default to false;
        }
        Test.startTest();
        Boolean checkValue = new OrgShape()
            .isAdvancedMultiCurrencyManagementEnabled();
        Test.stopTest();

        system.assertEquals(
            datedConversionRateObjectExists,
            checkValue,
            'Expected the check value to equal the dated'
        );
    }

    @isTest
    static void testPlatformCachePositive() {
        // Apex Recipes scratch org enable platform cache by default
        // If this fails and you think it should succeed, ensure you have
        // a default partition specified. We cannot ship a default partition
        // selected in metadata, so you have to do this manually!
        Test.startTest();
        Boolean result = orgShape.isPlatformCacheEnabled();
        Test.stopTest();
        System.assert(
            result,
            'We expect this to be true. But it it might fail, if you\'ve not set a default cache partition'
        );
    }

    @isTest
    static void testGetSafeDefaultCachePartitionMemoized() {
        orgShape.safeDefaultCachePartition = 'OrgShapeDefault';
        Test.startTest();
        Boolean result = orgShape.isPlatformCacheEnabled();
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
        Boolean result = orgShape.isPlatformCacheEnabled();
        Test.stopTest();
        System.assertEquals(
            false,
            result,
            'Expected to see platform cache reported as disabled when see all data is true'
        );
    }

    @isTest(SeeAllData=true)
    @SuppressWarnings('PMD.ApexUnitTestShouldNotUseSeeAllDataTrue')
    static void testSeeAllDataPositiveWhenEnabled() {
        System.assert(
            orgShape.isSeeAllDataTrue(),
            'Expected see all data to be true in a test method annotated with seeAllData=true'
        );
    }

    @isTest
    static void testSeeAllDataFalseWhenDisabled() {
        System.assert(
            !orgShape.isSeeAllDataTrue(),
            'Expected see all data to be true in a test method annotated with seeAllData=true'
        );
    }

    @isTest
    static void testCacheIsUsedPositive() {
        OrgShape orgShape = new OrgShape();
        // this should populate the cache.
        Boolean discard = orgShape.isReadOnly;
        Test.startTest();
        // this should use the cache.
        Boolean check = orgShape.isSandbox;
        Test.stopTest();
        System.assertEquals(
            1,
            Cache.Org.getNumKeys(),
            'Expected to see 1 and only 1 cache key'
        );
        System.assert(
            Cache.Org.getKeys().toString().containsIgnoreCase('cachedorgshape'),
            'Expected the single cache key to be tied to our CachedOrgShape cacheBuilder class'
        );
        System.assert(
            Cache.Org.getMissRate() <= 0.25,
            'Expected a cache miss rate no higher than .25'
        );
    }
}
