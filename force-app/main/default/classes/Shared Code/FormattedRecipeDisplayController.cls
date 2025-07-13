/**
 * @description this is the server side controller for the Formatted Recipe
 * Display component. It has one method that delivers a class, and it's matching
 * test class to the UI for display. The component is reponsible for formatting
 * and syntax highlighting
 * @group Shared Code
 * @see ApexClassUtilities
 */
public with sharing class FormattedRecipeDisplayController {
    /**
     * @description Data transfer object for marshalling information form this
     * class to the LWC that consumes it
     */
    public class ClassData {
        @AuraEnabled
        public String name;
        @AuraEnabled
        public Decimal apiVersion;
        @AuraEnabled
        public String body;
        @AuraEnabled
        public Integer lengthWithoutComments;
        @AuraEnabled
        public String groupName;

        /**
         * @description constructor for ClassData that accepts an ApexClass
         * object
         * @param klass An ApexClass object to build this object from.
         */
        public ClassData(ApexClass klass) {
            this.name = klass.Name;
            this.apiVersion = klass.ApiVersion;
            this.body = klass.Body;
            this.lengthWithoutComments = klass.LengthWithoutComments;
            // Some of the Test classes cause a Limits error on
            // `Regex too complicated`
            // Until this is sorted, we'll explicitly bypass this on Test
            // classes
            if (!this.name.endsWith('_Tests')) {
                this.groupName = ApexClassUtilities.getGroupFromClassBody(
                    klass
                );
            } else {
                this.groupName = 'Tests';
            }
        }
    }

    /**
     * @description      AuraEnabled, and cached read-only method for
     * grabbing the body of a given Apex Class
     *
     * Note: this method contains a false-positive PMD violation.
     * Normally, we'd want to check for FLS/CRUD here, but for ApexClass
     * a system level object that Admins and users cannot really change
     * we're ok.
     *
     * @param recipeName Name of the Class to return
     * @example
     * ```
     * System.debug(FormattedRecipeDisplayController.getRecipeCode('FormattedRecipeDisplayController'));
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    @AuraEnabled(cacheable=true)
    public static ClassData getRecipeCode(String recipeName) {
        ApexClass klass = [
            SELECT Id, Name, ApiVersion, Body, LengthWithoutComments
            FROM ApexClass
            WHERE Name LIKE :recipeName.trim()
            LIMIT 1
        ];
        return new ClassData(klass);
    }
}
