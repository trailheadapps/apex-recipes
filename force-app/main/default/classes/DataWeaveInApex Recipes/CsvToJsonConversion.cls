/**
 * @description Demonstrates how to use DataWeave
 * in Apex to convert CSV to JSON.For more DataWeave for Apex example
 * head to https://github.com/developerforce/DataWeaveInApex
 * @group DataWeaveInApex Recipes
 */
public with sharing class CsvToJsonConversion {
    /**
     * @description Demonstrates how to use DataWeave in Apex
     * to convert a CSV to a JSON.
     * The class uses the `/dw/csvToJson.dwl` script to convert CSV to JSON
     * @param csvPayload CSV data to convert to JSON
     * @return JSON string
     */
    public static String convertCsvToJson(String csvPayload) {
        DataWeave.Script script = new DataWeaveScriptResource.csvToJson();
        DataWeave.Result result = script.execute(
            new Map<String, Object>{ 'payload' => csvPayload }
        );
        return result.getValueAsString();
    }
}
