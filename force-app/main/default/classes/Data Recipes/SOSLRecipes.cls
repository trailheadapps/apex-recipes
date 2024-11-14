/**
 * @description Demonstrates how to use SOSL.
 * SOSL is used for full text, and fuzzier text searching.
 *
 * More on the difference between SOQL and SOSL:
 * https://sfdc.co/soql-sosl
 *
 * @group Data Recipes
 */
public with sharing class SOSLRecipes {
    /**
     * @description Demonstrates the syntax for a SOSL search.
     *  Note: SOSL Cannot be unit tested directly - you must use
     * `Test.setFixedSearchResults()`
     *  See SOSLRecipes_Tests.cls for more information
     * @example
     * ```
     * System.debug(SOSLRecipes.basicSOSLSearch());
     * ```
     */
    public static List<List<SObject>> basicSOSLSearch() {
        String keyword = 'Kan*';
        List<List<SObject>> searchResults = [
            FIND :keyword
            IN ALL FIELDS
            RETURNING account(name), contact(lastname, account.Name)
        ];

        return searchResults;
    }

    /**
     * @description Demonstrates how to write a SOSL query that searches only
     * name fields
     * @example
     * ```
     * System.debug(SOSLRecipes.nameFieldSearch());
     * ```
     */
    public static List<List<SObject>> nameFieldSearch() {
        String keyword = 'Alaska';
        List<List<SObject>> searchResults = [
            FIND :keyword
            IN NAME FIELDS
            RETURNING account(name), contact(lastname, account.Name)
        ];
        return searchResults;
    }
}
