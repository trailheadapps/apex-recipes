@isTest
class OrgShape_Tests {
    private static OrgShape orgShape;
    private static Organization orgCheck;
    static {
        orgShape = new orgShape();
        orgCheck = [SELECT FIELDS(STANDARD) FROM Organization LIMIT 1];
    }

    @isTest
    static void testOrgShapeProperties() {
        System.Assert.areEqual(
            orgCheck.isSandbox,
            orgShape.isSandbox,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
            UserInfo.isMultiCurrencyOrganization(),
            orgShape.multiCurrencyEnabled,
            'Expected the OrgShape property to match the UserInfo property'
        );
        System.Assert.areEqual(
            orgCheck.OrganizationType,
            orgShape.orgType,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
            orgCheck.isReadOnly,
            orgShape.isReadOnly,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
            orgCheck.instanceName,
            orgShape.instanceName,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
            orgCheck.instanceName,
            orgShape.podName,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
            orgCheck.fiscalYearStartMonth,
            orgShape.getFiscalYearStartMonth,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
            UserInfo.getUiThemeDisplayed().containsIgnoreCase('theme4'),
            orgShape.lightningEnabled,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
            orgCheck.id,
            orgShape.id,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
            orgCheck.languageLocaleKey,
            orgShape.locale,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
            orgCheck.timeZoneSidKey,
            orgShape.timeZoneKey,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
            orgCheck.name,
            orgShape.name,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
            orgCheck.namespacePrefix,
            orgShape.namespacePrefix,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
            String.isNotBlank(orgCheck.namespacePrefix),
            orgShape.hasNamespacePrefix,
            'Expected the OrgShape property to match the query'
        );
        System.Assert.areEqual(
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

        System.Assert.areEqual(
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
        System.Assert.isTrue(
            result,
            'We expect this to be true. But it it might fail, if you\'ve not set a default cache partition'
        );
    }

    @isTest
    static void testGetSafeDefaultCachePartitionMemoized() {
        OrgShape.safeDefaultCachePartition = Cache.Org.getPartition(
            'local.default'
        );
        Test.startTest();
        Boolean result = orgShape.isPlatformCacheEnabled();
        Test.stopTest();
        System.Assert.isTrue(
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
        System.Assert.isFalse(
            result,
            'Expected to see platform cache reported as disabled when see all data is true'
        );
    }

    @isTest(SeeAllData=true)
    @SuppressWarnings('PMD.ApexUnitTestShouldNotUseSeeAllDataTrue')
    static void testSeeAllDataPositiveWhenEnabled() {
        System.Assert.isTrue(
            orgShape.isSeeAllDataTrue(),
            'Expected see all data to be true in a test method annotated with seeAllData=true'
        );
    }

    @isTest
    static void testSeeAllDataFalseWhenDisabled() {
        System.Assert.isTrue(
            !orgShape.isSeeAllDataTrue(),
            'Expected see all data to be true in a test method annotated with seeAllData=true'
        );
    }

    @isTest
    static void testCacheIsUsedPositive() {
        Cache.OrgPartition defaultPartition = Cache.Org.getPartition(
            'local.default'
        );
        defaultPartition.remove(
            OrgShape.CachedOrgShape.class,
            'requiredButNotUsed'
        );
        System.assertEquals(
            0,
            defaultPartition.getNumKeys(),
            'Expected to no cache keys yet'
        );
        OrgShape orgShape = new OrgShape();
        // this should populate the cache.
        Boolean discard = orgShape.isReadOnly;
        Test.startTest();
        // this should use the cache.
        Boolean check = orgShape.isSandbox;
        Test.stopTest();
        System.Assert.areEqual(
            1,
            defaultPartition.getNumKeys(),
            'Expected to see 1 and only 1 cache key'
        );
        System.Assert.isTrue(
            defaultPartition.getKeys()
                .toString()
                .containsIgnoreCase('cachedorgshape'),
            'Expected the single cache key to be tied to our CachedOrgShape cacheBuilder class'
        );
    }
}
