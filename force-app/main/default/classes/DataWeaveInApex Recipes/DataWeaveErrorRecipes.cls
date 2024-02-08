/**
 * @description Demonstrates how to handle DataWeave script errors in Apex.
 * @group DataWeaveInApex Recipes
 */
public with sharing class DataWeaveErrorRecipes {
    /**
     * @description Runs a DataWeave script that triggers a runtime error on pupose.
     * Uses the `dw/error.dwl` DataWeave script.
     */
    public static void runtimeError() {
        DataWeave.Script script = new DataWeaveScriptResource.error();
        script.execute(new Map<String, Object>());
    }

    /**
     * @description Attempts to output records as Excel.
     * This always results in an error as the Excel format is not supported in DataWeave in Apex.
     * Uses the `dw/excelOutputError.dwl` DataWeave script.
     * @param contacts list of contacts
     * @return DataWeave script result (never used as a `DataWeaveScriptException` is thrown)
     */
    public static DataWeave.Result convertContactsToExcel(
        List<Contact> contacts
    ) {
        DataWeave.Script script = new DataWeaveScriptResource.excelOutputError();
        DataWeave.Result result = script.execute(
            new Map<String, Object>{ 'records' => contacts }
        );
        return result;
    }
}
