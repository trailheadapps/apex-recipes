/**
 * @description Apex server side controller for discovering other classes
 * related to the one being viewed
 * @group Shared Code
 * @see ApexClassUtilities
 */
public with sharing class RelatedCodeTabsController {
    /**
     * @description Inspects the ApexClass body definition for a `@see`
     * tag in the opening class level doc block. It then parses the
     * comma separated list and returns it as a list of strings
     *
     * Note: this method contains a false-positive PMD violation.
     * Normally, we'd want to check for FLS/CRUD here, but for ApexClass
     * a system level object that Admins and users cannot really change
     * we're ok.
     *
     * @param mainClassName The name of the class to inspect
     * @example
     * ```
     * System.debug(RelatedCodeTabsController.getRelatedClasses('RelatedCodeTabsController'));
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    @AuraEnabled(cacheable=true)
    public static List<String> getRelatedClasses(String mainClassName) {
        List<String> relatedClasses = new List<String>();
        if (String.isNotBlank(mainClassName)) {
            ApexClass klass = [
                SELECT Name, Body
                FROM ApexClass
                WHERE Name LIKE :mainClassName
            ];
            return ApexClassUtilities.getRelatedClassesFromClassBody(klass);
        }
        return relatedClasses;
    }
}
