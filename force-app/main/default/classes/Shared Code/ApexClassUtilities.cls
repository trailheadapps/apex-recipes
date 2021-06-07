/**
 * @description Contains reusable code dealing with ApexClass objects.
 * This is primarily used by the LWC components for displaying code
 * in an org.
 * @group Shared Code
 * @see RecipeTreeViewController, FormattedRecipeDisplayController
 */
public with sharing class ApexClassUtilities {
    /**
     * @description Extracts the @group annotation from a class' body.
     * Also demonstrates the use of Regex matchers in Apex.
     * @param klass an ApexClass object
     * @return     `String` This is the text following '@group' through
     * the end of the line.
     * @example
     * ApexClass klass = [SELECT Name, Body FROM ApexClass LIMIT 1];
     * System.debug(ApexClassUtilities.getGroupBodyFromClassBody(klass));
     */
    public static String getGroupFromClassBody(ApexClass klass) {
        Pattern patternForFindingGroupTagInHeader = Pattern.compile(
            '.*@group.(.*)'
        );
        Matcher matcher = patternForFindingGroupTagInHeader.matcher(klass.Body);
        matcher.find();
        String groupName = '';
        try {
            groupName = matcher.group(1);
        } catch (StringException matcherException) {
            System.debug(
                LoggingLevel.INFO,
                'Failed to extract group name. Class name: ' + klass.Name
            );
        }

        return groupName;
    }

    /**
     * @description Extracts the @see annotation from a class' body.
     * Also demonstrates the use of Regex matchers in Apex.
     * @param klass an ApexClass object
     * @return     `String` This is the text following '@see' through
     * the end of the line.
     * @example
     * ApexClass klass = [SELECT Name, Body FROM ApexClass LIMIT 1];
     * System.debug(ApexClassUtilities.getRelatedClassesFromClassBody(klass));
     */
    public static String getRelatedClassesFromClassBody(ApexClass klass) {
        Pattern patternForFindingSeeTagInHeader = Pattern.compile(
            '.*@see.(.*)'
        );
        Matcher matcher = patternForFindingSeeTagInHeader.matcher(klass.Body);
        matcher.find();
        String relatedClasses = '';
        try {
            relatedClasses = matcher.group(1);
            return relatedClasses;
        } catch (StringException matcherException) {
            System.debug(
                LoggingLevel.INFO,
                'Failed to extract related names. Class name: ' + klass.Name
            );
        }
        return '';
    }
}
