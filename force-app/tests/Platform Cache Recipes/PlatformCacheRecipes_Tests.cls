@isTest
/**
 * @description This test class exists not only to test the Platform Cache
 * Recipes class, but also to illustrate a key principle of unit testing:
 * Each test should test one, specific thing. Not a number of things, not a
 * multitude of methods, but one specific thing. It would have been trivial
 * to write this test class with test methods that tested session and org
 * cache functionality in the same method. However, doing so could potentially
 * confuse the results when, say, only ORG cache methods were failing.
 */
private class PlatformCacheRecipes_Tests {
    @isTest
    static void testStoreValueInSessionCachePositive() {
        Test.startTest();
        PlatformCacheRecipes.storeValueInSessionCache(
            'Account',
            'This is a test'
        );
        Test.stopTest();

        System.Assert.isTrue(
            PlatformCacheRecipes.getDefaultPartition(
                    PlatformCacheRecipes.PartitionType.SESSION
                )
                .getKeys()
                .contains('Account'),
            'Expected to see Account as a key'
        );
        System.Assert.areEqual(
            'This is a test',
            PlatformCacheRecipes.getDefaultPartition(
                    PlatformCacheRecipes.PartitionType.SESSION
                )
                .get('Account'),
            'expected Account key to hold \'this is a test\''
        );
    }

    @isTest
    static void testStoreValueInSessionCacheWithTTLPositive() {
        Test.startTest();
        PlatformCacheRecipes.storeValueInSessionCache(
            'Account',
            'This is a test',
            4800
        );
        Test.stopTest();

        System.Assert.isTrue(
            PlatformCacheRecipes.getDefaultPartition(
                    PlatformCacheRecipes.PartitionType.SESSION
                )
                .getKeys()
                .contains('Account'),
            'Expected to see Account as a key'
        );
        System.Assert.areEqual(
            'This is a test',
            PlatformCacheRecipes.getDefaultPartition(
                    PlatformCacheRecipes.PartitionType.SESSION
                )
                .get('Account'),
            'expected Account key to hold \'this is a test\''
        );
    }

    @isTest
    static void testGetValueFromSessionCachePositive() {
        PlatformCacheRecipes.storeValueInSessionCache(
            'Account',
            'This is a test'
        );
        Test.startTest();
        String results = PlatformCacheRecipes.getValueFromSessionCache(
            'Account'
        );
        Test.stopTest();
        System.Assert.areEqual(
            'This is a test',
            results,
            'Expect retrieval of cache item to result in the cached string being returned'
        );
    }

    @isTest
    static void testGetValueFromSessionCacheNegativeNoValueForKey() {
        Test.startTest();
        String results = PlatformCacheRecipes.getValueFromSessionCache(
            'Account'
        );
        Test.stopTest();
        System.Assert.areEqual(
            'Cache Miss',
            results,
            'Expect retrieval of non-existant cache key to result in a \'Cache Miss\' result '
        );
    }

    @isTest
    static void testRemoveKeyFromSessionCachePositive() {
        PlatformCacheRecipes.storeValueInSessionCache(
            'Account',
            'This is a test'
        );
        Test.startTest();
        PlatformCacheRecipes.removeKeyFromSessionCache('Account');
        Test.stopTest();
        System.Assert.isFalse(
            PlatformCacheRecipes.getDefaultPartition(
                    PlatformCacheRecipes.PartitionType.SESSION
                )
                .getKeys()
                .contains('Account'),
            'Expected the session cache keyset to not include Account'
        );
    }

    @isTest
    static void testRemoveKeyFromSessionCacheNegativeNoKey() {
        Boolean didCatchProperException = false;
        Test.startTest();
        try {
            PlatformCacheRecipes.removeKeyFromSessionCache('fakekey');
        } catch (PlatformCacheRecipes.CacheException ce) {
            if (ce.getMessage().containsIgnoreCase('key not found')) {
                didCatchProperException = true;
            }
        }
        Test.stopTest();
        System.Assert.isTrue(
            didCatchProperException,
            'Expected to have caught a cacheException'
        );
    }

    // ORG partition
    @isTest
    static void testStoreValueInOrgCachePositive() {
        Test.startTest();
        PlatformCacheRecipes.storeValueInOrgCache('Account', 'This is a test');
        Test.stopTest();

        System.Assert.isTrue(
            PlatformCacheRecipes.getDefaultPartition(
                    PlatformCacheRecipes.PartitionType.ORG
                )
                .getKeys()
                .contains('Account'),
            'Expected to see Account as a key'
        );
        System.Assert.areEqual(
            'This is a test',
            PlatformCacheRecipes.getDefaultPartition(
                    PlatformCacheRecipes.PartitionType.ORG
                )
                .get('Account'),
            'expected Account key to hold \'this is a test\''
        );
    }

    @isTest
    static void testStoreValueInOrgCacheWithTTLPositive() {
        Test.startTest();
        PlatformCacheRecipes.storeValueInOrgCache(
            'Account',
            'This is a test',
            4800
        );
        Test.stopTest();

        System.Assert.isTrue(
            PlatformCacheRecipes.getDefaultPartition(
                    PlatformCacheRecipes.PartitionType.ORG
                )
                .getKeys()
                .contains('Account'),
            'Expected to see Account as a key'
        );
        System.Assert.areEqual(
            'This is a test',
            PlatformCacheRecipes.getDefaultPartition(
                    PlatformCacheRecipes.PartitionType.ORG
                )
                .get('Account'),
            'expected Account key to hold \'this is a test\''
        );
    }

    @isTest
    static void testGetValueFromOrgCachePositive() {
        PlatformCacheRecipes.storeValueInOrgCache('Contact', 'This is a test');
        Test.startTest();
        String results = PlatformCacheRecipes.getValueFromOrgCache('Contact');
        Test.stopTest();
        System.Assert.areEqual(
            'This is a test',
            results,
            'Expect retrieval of cache item to result in the cached string being returned'
        );
    }

    @isTest
    static void testGetValueFromOrgCacheNegativeNoValueForKey() {
        Test.startTest();
        String results = PlatformCacheRecipes.getValueFromOrgCache('Account');
        Test.stopTest();
        System.Assert.areEqual(
            'Cache Miss',
            results,
            'Expect retrieval of non-existant cache key to result in a \'Cache Miss\' result '
        );
    }

    @isTest
    static void testRemoveKeyFromOrgCachePositive() {
        PlatformCacheRecipes.storeValueInOrgCache('Account', 'This is a test');
        Test.startTest();
        PlatformCacheRecipes.removeKeyFromOrgCache('Account');
        Test.stopTest();
        System.Assert.isFalse(
            PlatformCacheRecipes.getDefaultPartition(
                    PlatformCacheRecipes.PartitionType.ORG
                )
                .getKeys()
                .contains('Account'),
            'Expected the Org cache keyset to not include Account'
        );
    }

    @isTest
    static void testRemoveKeyFromOrgCacheNegativeNoKey() {
        Boolean didCatchProperException = false;
        Test.startTest();
        try {
            PlatformCacheRecipes.removeKeyFromOrgCache('fakekey');
        } catch (PlatformCacheRecipes.CacheException ce) {
            if (ce.getMessage().containsIgnoreCase('key not found')) {
                didCatchProperException = true;
            }
        }
        Test.stopTest();
        System.Assert.isTrue(
            didCatchProperException,
            'Expected to have caught a cacheException'
        );
    }
}
