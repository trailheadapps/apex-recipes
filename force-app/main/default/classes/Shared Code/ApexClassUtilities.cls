/**
 * @description Contains reusable code dealing with ApexClass objects.
 * This is primarily used by the LWC components for displaying code
 * in an org.
 * @group Shared Code
 * @see RecipeTreeViewController
 * @see FormattedRecipeDisplayController
 */
public with sharing class ApexClassUtilities {
    /**
     * @description Extracts the `@group` annotation from a class' body.
     * Also demonstrates the use of Regex matchers in Apex.
     * @param klass an ApexClass object
     * @return Text following `@group` through the end of the line.
     * @example
     * ```
     * ApexClass klass = [SELECT Name, Body FROM ApexClass LIMIT 1];
     * System.debug(ApexClassUtilities.getGroupFromClassBody(klass));
     * ```
     */
    public static String getGroupFromClassBody(ApexClass klass) {
        Pattern patternForFindingGroupTagInHeader = Pattern.compile(
            '\\s*\\*\\s+@group\\s+(.*)'
        );
        Matcher matcher = patternForFindingGroupTagInHeader.matcher(klass.Body);
        matcher.find();
        String groupName = '';
        try {
            groupName = matcher.group(1)?.trim();
        } catch (StringException matcherException) {
            System.debug(
                LoggingLevel.INFO,
                'Failed to extract group name. Class name: ' + klass.Name
            );
        }
        return groupName;
    }

    /**
     * @description Extracts the `@see` annotations from a class' body.
     * Also demonstrates the use of Regex matchers in Apex.
     * @param klass an ApexClass object
     * @return Values following `@see` annotations
     * @example
     * ```
     * ApexClass klass = [SELECT Name, Body FROM ApexClass LIMIT 1];
     * System.debug(ApexClassUtilities.getRelatedClassesFromClassBody(klass));
     * ```
     */
    public static List<String> getRelatedClassesFromClassBody(ApexClass klass) {
        Pattern patternForFindingSeeTagInHeader = Pattern.compile(
            '\\s*\\*\\s+@see\\s+(.*)'
        );
        Matcher matcher = patternForFindingSeeTagInHeader.matcher(klass.Body);
        List<String> relatedClasses = new List<String>();
        try {
            while (matcher.find()) {
                relatedClasses.add(matcher.group(1)?.trim());
            }
        } catch (StringException matcherException) {
            System.debug(
                LoggingLevel.INFO,
                'Failed to extract related names. Class name: ' + klass.Name
            );
        }
        return relatedClasses;
    }
}
