/**
 * @description Demonstrates various ways to apply formatting using DataWeave scripts in Apex.
 * @group DataWeaveInApex Recipes
 */
public with sharing class FormattingRecipes {
    /**
     * @description Outputs a list of contacts in JSON with properly formatted dates.
     * Uses the `dw/jsonDateFormat.dwl` DataWeave script.
     * @param contacts list of contacts to convert into JSON
     * @return JSON string
     */
    public static String formatDateInJson(List<Contact> contacts) {
        DataWeave.Script script = new DataWeaveScriptResource.jsonDateFormat();
        DataWeave.Result result = script.execute(
            new Map<String, Object>{ 'records' => contacts }
        );
        return result.getValueAsString();
    }

    /**
     * @description Uses the DataWeave `pluralize` function in a script (https://docs.mulesoft.com/dataweave/2.4/dw-strings-functions-pluralize).
     * Uses the `dw/pluralizeFunction.dwl` DataWeave script.
     * @param singularWords list of singular words as a JSON string
     * @return list of plural words as a JSON string
     */
    public static String pluralize(String singularWords) {
        DataWeave.Script script = new DataWeaveScriptResource.pluralizeFunction();
        DataWeave.Result result = script.execute(
            new Map<String, Object>{ 'inputs' => singularWords }
        );
        return result.getValueAsString();
    }

    /**
     * @description Parses a JSON input and escape properties named after Apex reserved keywords (private, object, currency...).
     * Full list of reserved keywords: https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_reserved_words.htm
     * Uses the `dw/reservedApexKeywords.dwl` DataWeave script.
     * @param jsonInput JSON string with Apex reserved keywords used as properties
     * @return JSON string without the Apex reserved keywords
     */
    public static String escapeApexReservedKeywords(String jsonInput) {
        DataWeave.Script script = new DataWeaveScriptResource.reservedApexKeywords();
        DataWeave.Result result = script.execute(
            new Map<String, Object>{ 'payload' => jsonInput }
        );
        return result.getValueAsString();
    }
}
