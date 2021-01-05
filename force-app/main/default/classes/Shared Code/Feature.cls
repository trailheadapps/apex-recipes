/**
 * @description Class is responsible for helping determine if specific
 * platform features are enabled in the current org
 */
public inherited sharing class Feature {
    public static Boolean platformCache() {
        Boolean cacheAvailable = false;
        try {
            Cache.org.getCapacity();
            cacheAvailable = true;
        } catch (Exception ex) {
            system.debug('Failed to get orgCache');
        }
        return cacheAvailable;
    }
}
