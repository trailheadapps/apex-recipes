/**
 * @description Class contains static methods for determining if specific
 * platform features are enabled here. For example, do we have platform cache
 * enabled. You could also write similar methods for experiences.
 */
public inherited sharing class IsFeatureEnabled {
    @TestVisible
    private static Boolean disablePlatformCache = false;

    /**
     * @description Method determines if platform cache is enabled for this org
     * Note: failsafes to false.
     * Note: Allows override by setting IsFeatureEnabled.disablePlatformCache
     * equal to true. Use this in test contexts where cache is not availble like
     * when you have to use seeAllData=true
     * @return      `Boolean`
     */
    public static Boolean platformCache() {
        // guard statement, always return false (and disable cache)
        // when the developer has set this.disablePlatformCache = true;
        // In the bright shining future, replace/refactor this with an
        // automated way of determining if a test is running with @seeAllData
        // = true
        if (IsFeatureEnabled.disablePlatformCache) {
            return false;
        }

        Boolean cacheAvailable = false;
        try {
            Cache.org.getCapacity();
            cacheAvailable = true;
        } catch (Exception ex) {
            system.debug('Failed to get orgCache');
        }
        return cacheAvailable;
    }

    @TestVisible
    private static Boolean isSeeAllDataTrue() {
        Boolean seeAllData = false;
        if (!Test.isRunningTest()) {
            return seeAllData;
        }

        try {
            // this will throw an exception in a data-silo'd test.
            ConnectApi.ChatterUsers.getFollowings(
                null,
                String.valueOf(UserInfo.getUserId())
            );
            seeAllData = true;
        } catch (UnsupportedOperationException UE) {
            // this means seeAllData != true
            System.debug('Caught UnsupportedOpperationException');
        }
        return seeAllData;
    }
}
