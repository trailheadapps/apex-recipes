/**
 * @description Demonstrates how to use DataWeave
 * in Apex to convert CSV to JSON.
 * @group DataWeaveInApex Recipes
 */
public with sharing class CsvToJsonConversionRecipes {
    /**
     * @description Converts CSV to JSON.
     * Uses the `dw/csvToJsonBasic.dwl` DataWeave script.
     * @param csvPayload CSV data to convert to JSON
     * @return JSON string
     */
    public static String convertCsvToJson(String csvPayload) {
        DataWeave.Script script = new DataWeaveScriptResource.csvToJsonBasic();
        DataWeave.Result result = script.execute(
            new Map<String, Object>{ 'payload' => csvPayload }
        );
        return result.getValueAsString();
    }

    /**
     * @description Converts CSV to JSON while renaming object fields.
     * Uses the `dw/csvToJsonWithFieldRenaming.dwl` DataWeave script.
     * @param csvPayload CSV data to convert to JSON
     * @return JSON string
     */
    public static String convertCsvToJsonWithFieldRenaming(String csvPayload) {
        DataWeave.Script script = new DataWeaveScriptResource.csvToJsonWithFieldRenaming();
        DataWeave.Result result = script.execute(
            new Map<String, Object>{ 'payload' => csvPayload }
        );
        return result.getValueAsString();
    }

    /**
     * @description Converts CSV to JSON with a custom `;` CSV separator.
     * Uses the `dw/csvSeparatorToJson.dwl` DataWeave script.
     * Notice that the script input MIME type specifies `separator=';'`.
     * @param csvPayload CSV data to convert to JSON
     * @return JSON string
     */
    public static String convertCsvWithCustomSeparatorToJson(
        String csvPayload
    ) {
        DataWeave.Script script = new DataWeaveScriptResource.csvSeparatorToJson();
        DataWeave.Result result = script.execute(
            new Map<String, Object>{ 'payload' => csvPayload }
        );
        return result.getValueAsString();
    }
}
