/**
 * @description Demonstrates how to convert data in CSV or JSON format
 * into Salesforce sObjects and Apex objects using DataWeave scripts in Apex.
 * Notice that all script output MIME types are set to `application/apex`.
 * @group DataWeaveInApex Recipes
 */
public with sharing class ObjectConversionRecipes {
    /**
     * @description Converts CSV data into a list of contact records.
     * Uses the `/dw/csvToContacts.dwl` DataWeave script.
     * @param inputCsv CSV data to tranform
     * @return List of contact records
     */
    public static List<Contact> convertCsvToContacts(String inputCsv) {
        DataWeave.Script script = new DataWeaveScriptResource.csvToContacts();
        DataWeave.Result dwResult = script.execute(
            new Map<String, Object>{ 'records' => inputCsv }
        );
        List<Contact> results = (List<Contact>) dwResult.getValue();
        return results;
    }

    /**
     * @description Converts JSON data into a list of contact records.
     * Uses the `/dw/jsonToContacts.dwl` DataWeave script.
     * @param inputJson JSON data to tranform
     * @return List of contact records
     */
    public static List<Contact> convertJsonToContacts(String inputJson) {
        DataWeave.Script script = new DataWeaveScriptResource.jsonToContacts();
        DataWeave.Result dwResult = script.execute(
            new Map<String, Object>{ 'records' => inputJson }
        );
        List<Contact> results = (List<Contact>) dwResult.getValue();
        return results;
    }

    /**
     * @description Converts CSV data into a list of Apex objects.
     * Uses the `/dw/csvToApexObject.dwl` DataWeave script.
     * @param inputCsv CSV data to tranform
     * @return List of Apex `CsvData` objects
     */
    public static List<CsvData> convertCsvToApexObject(String inputCsv) {
        DataWeave.Script script = new DataWeaveScriptResource.csvToApexObject();
        DataWeave.Result dwResult = script.execute(
            new Map<String, Object>{ 'records' => inputCsv }
        );
        List<CsvData> results = (List<CsvData>) dwResult.getValue();
        return results;
    }
}
