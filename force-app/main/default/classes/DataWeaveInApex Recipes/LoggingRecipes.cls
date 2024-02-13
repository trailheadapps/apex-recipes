/**
 * @description Demonstrates how to use the logger in DataWeave scripts in Apex.
 * @group DataWeaveInApex Recipes
 */
public with sharing class LoggingRecipes {
    /**
     * @description Filters 'winner' items from a list and log the filtered items
     * Uses the `dw/logFilter.dwl` DataWeave script.
     * @param jsonInput JSON string
     * @return JSON string
     */
    public static String logWithDataWeaveScript(String jsonInput) {
        DataWeave.Script script = new DataWeaveScriptResource.logFilter();
        DataWeave.Result result = script.execute(
            new Map<String, Object>{ 'payload' => jsonInput }
        );
        return result.getValueAsString();
    }
}
