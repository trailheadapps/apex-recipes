@isTest
private class PlatformCacheBuilderRecipes_Tests {
    static Cache.Partition defaultOrgPartition = PlatformCacheRecipes.getDefaultPartition(
        PlatformCacheRecipes.PartitionType.ORG
    );

    @isTest
    static void testPlatformCacheBuilderRecipesPositiveColdCache() {
        Account[] accts = (Account[]) TestFactory.createSObjectList(
            new Account(),
            5,
            true
        );
        Test.startTest();
        Account[] results = (Account[]) defaultOrgPartition.get(
            PlatformCacheBuilderRecipes.class,
            'Account'
        );
        Test.stopTest();
        System.Assert.areEqual(
            accts.size(),
            results.size(),
            'Expected to pull the same accounts'
        );
    }
}
