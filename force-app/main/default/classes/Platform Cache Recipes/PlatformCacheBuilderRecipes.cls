/**
 * @description demonstrates how to use the Cache.CacheBuilder Interface
 */
public with sharing class PlatformCacheBuilderRecipes implements Cache.CacheBuilder {
    /**
     * @description The doLoad method is required by the CacheBuilder interface
     * This method needs to return an Object - and that's the key to the Cache
     * builder interface - You must have this method return a single Object that
     * is either calculated by this method, or returned from the Cache by the
     * key
     * @param key   String used to help generate the Cache Key
     * @return     Oject that should be casted at the call location
     * @group Platform Cache Recipes
     * @see CanTheUser
     * @example Account[] accounts = (Account[]) Cache.Session.get(PlatformCacheBuilderRecipes.class, 'myAccounts')
     */
    public Object doLoad(String key) {
        Account[] accounts = [SELECT Id, Name FROM Account WITH USER_MODE];
        return accounts;
    }
}
