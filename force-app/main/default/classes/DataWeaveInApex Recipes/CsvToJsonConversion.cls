/**
 * @description Demonstrates how to use DataWeave scripts
 * in apex to convert CSV to JSON
 * @group DataWeaveInApex Recipes
 */
public with sharing class CsvToJsonConversion {
    /**
     * @description Demonstrates how to use DataWeave script in Apex
     * to convert a CSV to a JSON
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
     * to convert a CSV to list of Salesforce contact records
     * @param data CSV data to convert to JSON and then to Salesforce contact records
     * @param apexType Wrapper Apex class for deserializing JSON to Salesforce contact records
     * @return List of contacts
     */
    public static List<Contact> convertCsvToJsonContacts(
        String data,
        System.Type apexType
    ) {
        DataWeave.Script script = new DataWeaveScriptResource.csvToJson();

        DataWeave.Result result = script.execute(
            new Map<String, Object>{ 'data' => data }
        );
        String jsonResult = result.getValueAsString();

        List<Contact> contacts = (List<Contact>) JSON.deserialize(
            jsonResult,
            apexType
        );

        return contacts;
    }
}
