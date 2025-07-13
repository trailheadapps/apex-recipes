/**
 * @description Illustrates how to programatically use the Platform Cache
 * feature of Salesforce. Many of these recipes are, taken together, not very
 * DRY (don't repeat yourself). However, they're intentionally listed here as a
 * way of repeatedly demonstrating Platform Cache functionality
 *
 * @group Platform Cache Recipes
 */
public with sharing class PlatformCacheRecipes {
    /**
     * @description Defines the default cache partition for use in this class.
     */
    private static final String DEFAULT_PARTITION = 'local.default';

    /**
     * @description internal custom exception class.
     */
    public class CacheException extends Exception {
    }

    /**
     * Enum for partition type.
     */
    public enum PartitionType {
        SESSION,
        ORG
    }

    /**
     * These methods are for the Session Cache
     * Max TTL for Session partion is 8 hours.
     */

    /**
     * @description   Stores a value in the Session cache with a default
     * timeout of 3600 seconds (1hr)
     * @param key   key under which the value is saved.
     * @param value value to store in the cache.
     */
    public static void storeValueInSessionCache(String key, String value) {
        PlatformCacheRecipes.storeValueInSessionCache(key, value, 3600);
    }

    /**
     * @description   Stores a value in the Session cache with a custom timeout.
     * @param key     key under which the value is saved.
     * @param value   value to store in the cache
     * @param ttl     Time To Live (ttl) is the number of seconds this
     * item will remain in cache.
     */
    public static void storeValueInSessionCache(
        String key,
        String value,
        Integer ttl
    ) {
        getDefaultPartition(PartitionType.SESSION).put(key, value, ttl);
    }

    /**
     * @description Retrieves a value from the cache identified by key
     * @param key   key of which value to retrieve.
     * @return      the value
     */
    public static String getValueFromSessionCache(String key) {
        Cache.Partition defPartition = getDefaultPartition(
            PartitionType.SESSION
        );
        if (defPartition.contains(key)) {
            return (String) defPartition.get(key);
        }
        return 'Cache Miss';
    }

    /**
     * @description removes a key/value from the cache manually
     * @param key   key to remove
     * @exception   CacheException custom exception when key not found.
     */
    public static void removeKeyFromSessionCache(String key) {
        Cache.Partition defPartition = getDefaultPartition(
            PartitionType.SESSION
        );
        if (defPartition.contains(key)) {
            defPartition.remove(key);
        } else {
            throw new CacheException('key not found');
        }
    }

    /**
     * These methods relate to the ORG cache
     * Max TTL for Org Cache is 48 hours.
     */

    /**
     * @description   Stores a value in the Org cache with a default
     * timeout of 3600 seconds (1hr)
     * @param key     key under which the value is saved.
     * @param value   value to store in the cache.
     */
    public static void storeValueInOrgCache(String key, String value) {
        storeValueInOrgCache(key, value, 3600);
    }
    /**
     * @description   Stores a value in the Org cache with a custom timeout.
     * @param key   key under which the value is saved.
     * @param value value to store in the cache.
     * @param ttl   Time To Live (ttl) is the number of seconds this
     * item will remain in cache.
     */
    public static void storeValueInOrgCache(
        String key,
        String value,
        Integer ttl
    ) {
        getDefaultPartition(PartitionType.ORG).put(key, value, ttl);
    }

    /**
     * @description Retrieves a value from the cache identified by key
     * @param key key of which value to retrieve.
     * @return the value associated with the supplied key
     */
    public static String getValueFromOrgCache(String key) {
        Cache.Partition defPartition = getDefaultPartition(PartitionType.ORG);
        if (defPartition.contains(key)) {
            return (String) defPartition.get(key);
        }
        return 'Cache Miss';
    }

    /**
     * @description removes a key/value from the cache manually
     * @param key   key to remove
     * @exception   CacheException custom exception when key not found.
     */
    public static void removeKeyFromOrgCache(String key) {
        Cache.Partition defPartition = getDefaultPartition(PartitionType.ORG);
        if (defPartition.contains(key)) {
            defPartition.remove(key);
        } else {
            throw new CacheException('key not found');
        }
    }

    /**
     * @description returns a partition for a given name, and type
     * @param type the partition type
     * @return the partition
     */
    public static Cache.Partition getDefaultPartition(PartitionType type) {
        switch on type {
            when SESSION {
                return Cache.Session.getPartition(DEFAULT_PARTITION);
            }
            when else {
                return Cache.Org.getPartition(DEFAULT_PARTITION);
            }
        }
    }
}
