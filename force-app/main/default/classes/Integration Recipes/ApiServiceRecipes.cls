/**
 * @description This recipe extends the custom RestClient class and
 * represents a specific API service we need to interact with - in
 * this case a MockBin REST service. This APIService class is responsible
 * for serializing and deserializing the Data Transfer Objects (Model Objects)
 * necessary for input and output from this org to the third party system and
 * back.
 *
 * More on MockBin here: http://mockbin.org/
 *
 * @group Integration Recipes
 * @see RestClient, ApiServiceRecipesDataModel
 */
public with sharing class ApiServiceRecipes extends RestClient {
    @testVisible
    private static final String DEFAULTNAMEDCREDENTIAL = 'MockBin';
    private static final String GETBINPATH = '4cb453a6-a23b-42ea-a6ba-9be1c1f17050';

    /**
     * @description Internal custom exception used by this class for errors
     */
    public class ApiException extends Exception {
    }

    /**
     * @description default constructor. Sets the inherited named credential
     * to the DEFAULTNAMEDCREDENTIAL constant above.
     * Setting the namedCredentialName binds all the methods in this class
     * to the specific namedCredential URL and auth.
     */
    public ApiServiceRecipes() {
        namedCredentialName = DEFAULTNAMEDCREDENTIAL;
    }

    /**
     * @description Encapsulates a specific callout to the Named Credential
     * URL that returns JSON into an method that transforms the raw JSON
     * into an Apex Object.
     * @return     `List<ApiServiceRecipesDataModel>`
     * @example
     * ApiServiceRecipes asr = new ApiServiceRecipes();
     * System.debug(asr.getCurrentData());
     */
    public List<ApiServiceRecipesDataModel> getCurrentData() {
        /**
         * This next line calls the get() method inherrited from
         * the RestClient class. Because this class extends RestClient
         * all the instance methods defined there are available here.
         *
         * Inheriting this method allows us to focus on the api's
         * endpoints and data, rather than the mechanics of making
         * an http callout with the proper headers etc.
         */
        HttpResponse response = get(GETBINPATH);

        // Since we're doing a GET request, we don't need to handle for
        // 201, other 'created' responses.
        switch on response.getStatusCode() {
            when 200 {
                try {
                    return ApiServiceRecipesDataModel.parse(response.getBody());
                } catch (System.JSONException jse) {
                    throw new ApiServiceRecipes.ApiException(jse.getMessage());
                }
            }
            // you probably want to handle other response codes like 30x as well
            when 404 {
                throw new ApiServiceRecipes.ApiException('404 error!');
            }
            when else {
                throw new ApiServiceRecipes.ApiException(
                    'Unexpected Response code: ' + response.getStatusCode()
                );
            }
        }
    }
}
