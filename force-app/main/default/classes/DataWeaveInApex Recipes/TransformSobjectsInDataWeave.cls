/**
 * @description Demonstrates how to transform data in CSV/JSON file format
 * to Salesforce Sobjects using a DataWeave script in Apex.
 * For more DataWeave for Apex example head to https://github.com/developerforce/DataWeaveInApex
 * @group DataWeaveInApex Recipes
 */
public with sharing class TransformSobjectsInDataWeave {
    /**
     * @description Demonstrates how to transform data in CSV format to the Salesforce
     * contact records using a DataWeave script in Apex.
     * The class uses the `/dw/csvToContacts.dwl` script to convert CSV
     * to list of contact records.Notice that in the `csvToContacts.dwl` the
     * output MIME type is `application/apex`
     * @param inputCsv CSV data to tranform to Salesforce contact records
     * @return List of contact records
     */

    public static List<Contact> convertCsvToContacts(String inputCsv) {
        DataWeave.Script script = new DataWeaveScriptResource.csvToContacts();
        DataWeave.Result dwresult = script.execute(
            new Map<String, Object>{ 'records' => inputCsv }
        );
        List<Contact> results = (List<Contact>) dwresult.getValue();
        return results;
    }

    /**
     * @description Demonstrates how to transform data in JSON format to Salesforce
     * contact records using a DataWeave script in Apex.
     * The class uses the `/dw/jsonToContacts.dwl` script to convert JSON string
     * to a list of Salesforce contact records.Notice that in the `jsonToContacts.dwl` the
     * output MIME type is `application/apex`
     * @param inputJson JSON data to tranform to Salesforce contact records
     * @return List of contact records
     */

    public static List<Contact> convertJsonToContacts(String inputJson) {
        DataWeave.Script script = new DataWeaveScriptResource.jsonToContacts();
        DataWeave.Result dwresult = script.execute(
            new Map<String, Object>{ 'records' => inputJson }
        );
        List<Contact> results = (List<Contact>) dwresult.getValue();
        return results;
    }
}
