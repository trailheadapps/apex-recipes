/**
 * @description Demonstrates how use multiple input parameters in a DataWeave script in Apex.
 * @group DataWeaveInApex Recipes
 */
public with sharing class MultipleInputRecipes {
    /**
     * @description Converts the information of a shopping basket into another currency.
     * Uses the `/dw/multipleInputs.dwl` DataWeave script.
     * @param products list of products in the form of a JSON string
     * @param attributes list of product attributes used as a filters in the form of a JSON string
     * @param exchangeRates list of currency exchange rates in the form of a JSON string
     * @return script output as an XML string
     */
    public static String runScriptWithMultipleInputs(
        String products,
        String attributes,
        String exchangeRates
    ) {
        DataWeave.Script script = new DataWeaveScriptResource.multipleInputs();
        DataWeave.Result dwResult = script.execute(
            new Map<String, Object>{
                'products' => products,
                'attributes' => attributes,
                'exchangeRates' => exchangeRates
            }
        );
        return dwResult.getValueAsString();
    }
}
