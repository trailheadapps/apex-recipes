/**
 * @description Provides the necessary data to populate a lightning-tree base
 * component with recipe and group information
 * @group Shared Code
 * @see ApexClassUtilities
 */
public with sharing class RecipeTreeViewController {
    private static Map<String, List<String>> groupToListOfNames;

    /**
     * @description The String here represents a relatively unique tag that
     * Apex Recipe uses to help group related classes.
     */
    private static final String GROUP_TAG = '* @group';

    /**
     * @description Used to marshall data between Apex and the LWC component
     * that uses this data
     */
    public class RecipeTreeData implements Comparable {
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String name;
        @AuraEnabled
        public Boolean expanded = false;
        @AuraEnabled
        public RecipeTreeData[] items;

        /**
         * @description Required by the Comparable interface, this method,
         * once implemented allows us to sort of this object type.
         * @param compareTo A RecipeTreeData object to compare this instance against.
         * @return sort index
         */
        public Integer compareTo(Object compareTo) {
            RecipeTreeData compare = (RecipeTreeData) compareTo;
            if (name == compare?.name) {
                return 0;
            }
            if (name > compare?.name) {
                return 1;
            }
            return -1;
        }
    }

    /**
     * @description Generates a recursive list of RecipeTreeData objects
     * to feed to a Lightning-tree-view component. Importantly, the returning
     * array has two RecipeTreeData objects - One for Recipes, the other
     * for our supporting, shared code.
     * @return list of RecipeTreeData objects
     * @example
     * ```
     * System.debug(RecipeTreeViewController.generateTreeData());
     * ```
     */
    @AuraEnabled(cacheable=true)
    public static List<RecipeTreeData> generateTreeData() {
        List<RecipeTreeData> treeData = new List<RecipeTreeData>();
        RecipeTreeData recipes = new RecipeTreeData();
        recipes.label = 'Recipes';
        recipes.name = 'Recipes';
        recipes.expanded = true;
        recipes.items = new List<RecipeTreeData>();
        RecipeTreeData sharedCode = new RecipeTreeData();
        groupToListOfNames = generateMapOfGroupToListOfNames();
        List<String> sortedGroupNames = new List<String>();
        sortedGroupNames.addAll(groupToListOfNames.keySet());
        sortedGroupNames.sort();
        for (String groupName : sortedGroupNames) {
            groupName = groupName.trim();
            RecipeTreeData groupLevel = new RecipeTreeData();
            groupLevel.label = groupName;
            groupLevel.name = groupName;
            groupLevel.items = new List<RecipeTreeData>();
            for (String className : groupToListOfNames.get(groupName)) {
                className = className.trim();
                RecipeTreeData classLevel = new RecipeTreeData();
                classLevel.label = className;
                classLevel.name = className;
                classLevel.items = new List<RecipeTreeData>();
                groupLevel.items.add(classLevel);
                groupLevel.items.sort();
            }
            if (groupName.equalsIgnoreCase('shared code')) {
                sharedCode = groupLevel;
            } else {
                recipes.items.add(groupLevel);
                recipes.items.sort();
            }
        }
        treeData.add(recipes);
        treeData.add(sharedCode);

        return treeData;
    }

    /**
     * @description Generates a map containing Group names as the Keys tied to
     * a List of class names.
     *
     * Note: this method contains a false-positive PMD violation.
     * Normally, we'd want to check for FLS/CRUD here, but for ApexClass
     * a system level object that Admins and users cannot really change
     * we're ok.
     *
     * @return map containing Group names as the Keys tied to a List of class names.
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    private static Map<String, List<String>> generateMapOfGroupToListOfNames() {
        Map<String, List<String>> returnMap = new Map<String, List<String>>();
        List<List<SObject>> searchResults = [
            FIND :GROUP_TAG
            IN ALL FIELDS
            RETURNING ApexClass(Name, Body)
        ];
        ApexClass[] classes = searchResults[0];

        for (ApexClass klass : classes) {
            if (!klass.Body.contains('@group')) {
                continue;
            }
            String groupName = ApexClassUtilities.getGroupFromClassBody(klass);
            if (returnMap.keySet().contains(groupName)) {
                returnMap.get(groupName).add(klass.Name);
            } else {
                returnMap.put(groupName, new List<String>{ klass.Name });
            }
        }
        return returnMap;
    }
}
