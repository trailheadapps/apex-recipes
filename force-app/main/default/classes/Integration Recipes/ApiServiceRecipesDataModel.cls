/**
 * @description This class contains the 'data transfer object' details.
 * Data transfer objects are used to serialize Apex objects to JSON and
 * web service response JSON to Apex objects.
 * @group Integration Recipes
 * @see ApiServiceRecipes
 */
public with sharing class ApiServiceRecipesDataModel {
    /**
     * These properties represent the JSON keys that we need
     * to send or receive.
     */
    public List<Integer> exampleArray;
    public Boolean exampleBoolean;
    public String exampleColor;
    public String exampleCouldBeNull;
    public Integer exampleNumber;
    public ExampleObject exampleObject;
    public String exampleString;

    /**
     * @description example of how to model a nested JSON object
     */
    public class ExampleObject {
        public String a;
        public String c;
    }

    /**
     * @description Parses the provided JSON string into a list of
     * ApiServiceRecipesDataModel objects
     * @param json  Incoming JSON string. Often from an api call's results.
     * @example
     * ```
     * System.debug(ApiServiceRecipesDataModel.parse(ApiServiceRecipesDataModel_Tests.testJSON));
     * ```
     */
    public static List<ApiServiceRecipesDataModel> parse(String json) {
        return (List<ApiServiceRecipesDataModel>) System.JSON.deserialize(
            json,
            List<ApiServiceRecipesDataModel>.class
        );
    }
}
