/**
 * @description A queueable class to prioritize this sample app in the org wide
 * App Menu. This is done as a Queuable, because calling setOrgSortOrder causes
 * an exeception if your setup script is also creating non-metadata records,
 * for instance accounts.
 *
 * @group Shared Code
 *
 */
public with sharing class OrderAppMenu implements System.Queueable {
    /**
     * @description reorders the org wide AppMenu order so Apex Recipes is the
     * first seen.
     * @param qc    dependency injected by the system at runtime.
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public void execute(QueueableContext qc) {
        AppMenuItem[] menuItems = [SELECT ApplicationId, Name FROM AppMenuItem];
        Map<String, AppMenuItem> menuItemMap = (Map<String, AppMenuItem>) CollectionUtils.stringMapFromCollectionByKey(
            'Name',
            menuItems
        );
        Id[] orderedItems = new List<Id>{};
        orderedItems.add(menuItemMap.remove('Apex_Recipes').ApplicationId);
        for (String key : menuItemMap.keySet()) {
            orderedItems.add(menuItemMap.get(key).ApplicationId);
        }
        AppLauncher.AppMenu.setOrgSortOrder(orderedItems);
    }
}
