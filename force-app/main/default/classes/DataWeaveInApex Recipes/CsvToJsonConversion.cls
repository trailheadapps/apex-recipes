/**
 * @description Demonstrates how to use DataWeave
 * in Apex to convert CSV to JSON.For more DataWeave for Apex example
 * head to https://github.com/developerforce/DataWeaveInApex
 * @group DataWeaveInApex Recipes
 */
public with sharing class CsvToJsonConversion {
    /**
     * @description Demonstrates how to use DataWeave in Apex
     * to convert a CSV to a basic JSON.
     * The class uses the `/dw/csvToJsonBasic.dwl` script to convert CSV to JSON
     * @param csvPayload CSV data to convert to JSON
     * @return JSON string
     */
    public static String convertCsvToJsonBasic(String csvPayload) {
        DataWeave.Script script = new DataWeaveScriptResource.csvToJsonBasic();
        DataWeave.Result result = script.execute(
            new Map<String, Object>{ 'payload' => csvPayload }
        );
        return result.getValueAsString();
    }

    /**
     * @description Demonstrates how to use DataWeave script in Apex
     * to convert a CSV to first JSON and then deserialize it to a list of Salesforce contact records
     * The class uses the `/dw/csvToJson.dwl` script to convert CSV to JSON
     * @param data CSV data to convert to Salesforce contact records
     * @return List of contacts
     */
    public static List<Contact> convertCsvToJsonContacts(String data) {
        DataWeave.Script script = new DataWeaveScriptResource.csvToJson();

        DataWeave.Result result = script.execute(
            new Map<String, Object>{ 'data' => data }
        );
        String jsonResult = result.getValueAsString();

        List<Contact> contacts = (List<Contact>) JSON.deserialize(
            jsonResult,
            List<Contact>.class
        );

        return contacts;
    }
}
