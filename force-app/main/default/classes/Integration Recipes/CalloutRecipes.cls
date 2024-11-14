/**
 * @description Demonstrates how to make an opinionated REST callout.
 * This class utilizes the custom RestClient from the Shared Code group.
 * @group Integration Recipes
 * @see RestClient
 */
public with sharing class CalloutRecipes extends RestClient {
    /**
     * @description Internal custom exception class
     */
    public class CalloutRecipesException extends Exception {
    }

    /**
     * @description Constructor accepting a named credential.
     * @param namedCredential name of the Named Credential to use
     */
    public CalloutRecipes(String namedCredential) {
        super(namedCredential);
    }

    /**
     * @description Demonstrates how to make a raw HTTP request. This method
     * demonstrates how to use the Http, HttpRequest and HttpResponse objects to
     * construct a single get request. The other methods in this class
     * demonstrate the use of an intelligent abstraction layer - `RestClient.cls`
     * - to make sending Http Requests easier, easier to test, and less error
     * prone.
     * @return Response body as a string
     * @example
     * ```
     * System.debug(CalloutRecipes.rawCallout());
     * ```
     */
    public static String rawCallout() {
        // Configure request. Calling a third party domain requires that
        // you specify a Remote Site or a Named Credential first.
        HttpRequest request = new HttpRequest();
        request.setEndpoint(
            'https://www.googleapis.com/books/v1/volumes?q=salesforce'
        );
        request.setMethod('GET');

        // Send request
        Http http = new Http();
        HttpResponse response = http.send(request);

        // Check for a success HTTP response code
        if (response.getStatusCode() >= 200 && response.getStatusCode() < 300) {
            return response.getBody();
        }
        // Assume that the we received an HTTP error code
        throw new CalloutRecipesException(
            'Did not get a success response from the callout. Status Code: ' +
                response.getStatusCode() +
                ' status message: ' +
                response.getStatus()
        );
    }

    /**
     * @description Demonstrates a GET request to a second Salesforce org. A Get
     * request is used to retrieve data from a target endpoint, We will be using
     * the `performRestCallout` method to make the callout. In this example, we
     * will be requesting a list of Accounts from our second org. We will pass
     * the endpoint our named credential, the url path to our integration-service
     * custom REST endpoint, a null body and the GET method. We will then
     * deserialize the JSON into a known object, in this case, a list of
     * Accounts.
     * @example
     * ```
     * System.debug(CalloutRecipes.httpGetCalloutToSecondOrg());
     * ```
     */
    public List<Account> httpGetCalloutToSecondOrg() {
        // Perform a REST callout to our custom REST endpoint
        // `integration-service` using our named credential.
        // this callout uses the default named credential that's set when this
        // class was instantiated.
        HttpResponse response = get('services/apexrest/integration-service');
        // Get the body from our HttpResponse
        String responseBody = response.getBody();
        try {
            // Attempt to deserialize our response body into a list of Accounts
            List<Account> accountRecords = (List<Account>) JSON.deserialize(
                responseBody,
                List<Account>.class
            );
            return accountRecords;
        } catch (JSONException e) {
            // If the deserialization fails, we can debug it using a JSON Exception
            System.debug(
                LoggingLevel.INFO,
                'Failed to deserialize the body. Error is: ' + e.getMessage()
            );
        }
        // return null to the method that initiated the callout
        return null;
    }

    /**
     * @description Demonstrates a DELETE request to a second Salesforce org - A
     * DELETE request is used to delete data from the target endpoint.
     * In this example, we will be deleting a contact from another Salesforce
     * org. We will store the parameters in the urlPath which can then be
     * accessed through the .getParams() method in the org receiving the delete
     * request.
     * @param contactId the Id of the contact that you would like to delete in
     * the second org.
     * @example
     * ```
     * Id contactId = [SELECT Id FROM Contact LIMIT 1].id;
     * System.debug(CalloutRecipes.httpDeleteCalloutToSecondOrg(contactId));
     * ```
     */
    public Integer httpDeleteCalloutToSecondOrg(Id contactId) {
        // Construct the URL path to include the contact Id that has been passed
        // in the methods params.
        String query = '?contactId=' + contactId;
        // Perform a REST callout to our custom REST endpoint
        // 'integration-service' using our named credential.
        HttpResponse response = del(
            'services/apexrest/integration-service/',
            query
        );
        Integer statusCode = response.getStatusCode();
        // We don't need to try/catch this as we are only returning the
        // response.
        return statusCode;
    }

    /**
     * @description Demonstrates a POST request to a second Salesforce org a
     * POST request is used to send data to a target endpoint and insert it.
     * In this example, we will be sending a list of contact records to a second
     * Salesforce org.
     * We will serilaize the list and POST it in body of the callout.
     * @param contactRecords a list of contact records to be inserted in the
     * second salesforce org
     * @example
     * ```
     * List<Contact> contacts = [SELECT id, firstName, lastName FROM Contact LIMIT 5];
     * System.debug(CalloutRecipes.httpPostCalloutToSecondOrg(contacts));
     * ```
     */
    public Integer httpPostCalloutToSecondOrg(List<Contact> contactRecords) {
        // We will wrap code in a try catch as we are going to attempt to
        // serialize the request body
        try {
            // Attempt to serialize the request body to send in the POST Request
            String requestBody = JSON.serialize(contactRecords);
            // Perform a REST callout to our custom REST endpoint
            // 'integration-service' using our named credential.
            HttpResponse response = post(
                'services/apexrest/integration-service/',
                requestBody
            );
            Integer statusCode = response.getStatusCode();
            return statusCode;
        } catch (JSONException e) {
            // If the deseralization fails, we can debug it using a JSON
            // Exception
            System.debug(
                LoggingLevel.INFO,
                'Failed to serialize the body. Error is: ' + e.getMessage()
            );
            // return null to the method that initiated the callout
            return null;
        }
    }

    /**
     * @description Demonstrates a PUT request to a second Salesforce org a PUT
     * request is used to send data to a target endpoint and upsert it. In this
     * example, we will be sending a list of contact records to a second org.
     * @param contactRecords a list of contact records to be upsert in the
     * second salesforce org
     * @example
     * ```
     * List<Contact> contacts = [SELECT id, firstName, lastName FROM Contact LIMIT 5];
     * System.debug(CalloutRecipes.httpPutCalloutToSecondOrg(contacts));
     * ```
     */
    public Integer httpPutCalloutToSecondOrg(List<Contact> contactRecords) {
        // We will wrap code in a try catch as we are going to attempt to
        // serialize the request body
        try {
            // Attempt to serialize the request body to send in the PUT Request
            String requestBody = JSON.serialize(contactRecords);
            // This recipe demonstrates an alternate form of using the
            // RestClient statically.
            // This form doesn't require instantiating a class that extends
            // RestClient but it is more verbose. Perform a REST callout to our
            // custom REST endpoint 'integration-service' using our named
            // credential.
            HttpResponse response = RestClient.makeApiCall(
                'Second_Org',
                RestClient.HttpVerb.PUT,
                'services/apexrest/integration-service/',
                '',
                requestBody,
                null
            );
            Integer statusCode = response.getStatusCode();
            return statusCode;
        } catch (JSONException e) {
            // If the deseralization fails, we can debug it using a JSON
            // Exception
            System.debug(
                LoggingLevel.INFO,
                'Failed to serialize the body. Error is: ' + e.getMessage()
            );
            // return null to the method that initiated the callout
            return null;
        }
    }

    /**
     * @description Demonstrates a PATCH request to a second Salesforce org a
     * PATCH request is used to send data to a target endpoint and update
     * already existing data. In this example, we will be sending a list of
     * Account records to a second salesforce org for updating.
     * @param accountRecords a list of account records to be updated in the
     * second salesforce org
     * @return The status of the callout
     * @example
     * ```
     * List<Contact> contacts = [SELECT id, firstName, lastName FROM Contact LIMIT 5];
     * System.debug(CalloutRecipes.httpPatchCalloutToSecondOrg(contacts));
     * ```
     */
    public Integer httpPatchCalloutToSecondOrg(List<Account> accountRecords) {
        // We will wrap code in a try catch as we are going to attempt to
        // serialize the request body
        try {
            // Attempt to serialize the request body to send in the PATCH
            // Request
            String requestBody = JSON.serialize(accountRecords);
            // Perform a REST callout to our custom REST endpoint
            // 'integration-service' using our named credential.
            HttpResponse response = patch(
                'services/apexrest/integration-service/',
                '',
                requestBody
            );
            Integer statusCode = response.getStatusCode();
            return statusCode;
        } catch (JSONException e) {
            // If the deseralization fails, we can debug it using a JSON
            // Exception
            System.debug(
                LoggingLevel.INFO,
                'Failed to serialize the body. Error is: ' + e.getMessage()
            );
            // return null to the method that initiated the callout
            return null;
        }
    }

    /**
     * @description Now that we have demonstrated how to callout to an endpoint,
     * lets take a look at what else we can do with the response. When calling
     * out to an external endpoint, the data may not always be in a format that
     * can be directly deserialised into a Salesforce Object. If your callout
     * returns untyped JSON, you can deserialize this into a Map<String, Object>
     * by using a deserializeUntyped method to convert the string.
     * @example
     * ```
     * System.debug(CalloutRecipes.httpCalloutWithUntypedResponse());
     * ```
     */
    public Map<String, Object> httpCalloutWithUntypedResponse() {
        // This Recipe also demonstrates how to do a one-off override of the
        // Named Credential It stores the original named credential name,
        // resets the active named credential and before returning, ensures the
        // named credential is reset.
        String originalNamedCredential = namedCredentialName;
        namedCredentialName = 'ExternalEndpoint';
        HttpResponse response = get('fakeEndpoint/');
        try {
            String responseBody = response.getBody();
            // Attempt to deserialize the untyped response into a
            // Map<String,Object>
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(
                responseBody
            );
            // Reset the named credential for this class back to the original
            namedCredentialName = originalNamedCredential;
            return responseMap;
        } catch (JSONException e) {
            // If the deseralization fails, we can debug it using a JSON
            // Exception
            System.debug(
                LoggingLevel.INFO,
                'Failed to serialize the body. Error is: ' + e.getMessage()
            );
            // Reset the named credential for this class back to the original
            namedCredentialName = originalNamedCredential;
            // return null to the method that initiated the callout
            return null;
        }
    }

    /**
     * @description As seen in the httpCalloutWithUntypedResponse method, we
     * don't always get a perfect datastructure back from our callout. In this
     * case, we have received and account and it's contacts that need to be
     * inserted into Salesforce. Check out the Test class for an example of an
     * untyped data structure.
     * @param untypedResponse the untyped JSON response that we received from
     * our previous callout
     * @example
     * ```
     * CalloutRecipes.insertAccountAndContactsFromUntypedResponse(CalloutRecipes_Tests.goodUntypedJSON)
     * ```
     */
    public void insertAccountAndContactsFromUntypedResponse(
        String untypedResponse
    ) {
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(
            untypedResponse
        );
        // Instantiate a List<SObject> to hold our data
        List<SObject> dataToInsert = new List<SObject>();
        // Create an temporary reference to associate the contacts and accounts,
        // here we will use an ExternalId__c field
        Account accountReference = new Account();
        // We can use a .get('fieldName') to extract data from the map
        accountReference.ExternalSalesforceId__c = responseMap.get('Id')
            .toString();
        // We can then instantiate a new Account and populate it with data using
        // the .get('fieldName') again
        Account newAccount = new Account();
        newAccount.ExternalSalesforceId__c = responseMap.get('Id').toString();
        newAccount.Name = responseMap.get('Name').toString();
        newAccount.Website = responseMap.get('Website').toString();
        // Add the account to our List<SObject> for us to insert
        dataToInsert.add(newAccount);
        // We can now create a list of contact from our response body
        List<Object> contactList = (List<Object>) responseMap.get('Contacts');
        // Because we may have multiple contacts per account, we can loop
        // through the list and assign the values from the map
        for (Integer i = 0; i < contactList.size(); i++) {
            Map<String, Object> singleContact = (Map<String, Object>) contactList[
                i
            ];
            Contact newContact = new Contact();
            newContact.FirstName = singleContact.get('FirstName').toString();
            newContact.LastName = singleContact.get('LastName').toString();
            newContact.Email = singleContact.get('Email').toString();
            // Assign the account referene to the Contact.Account field using
            // our external Id that we set earlier
            newContact.Account = accountReference;
            // We can add the contact to our List<SObject> along with the
            // account
            dataToInsert.add(newContact);
        }
        // Now that our data is populated into the dataToInsert variable, we can
        // use a Database.insert to insert the generaic SObject list.
        // This will preserve the contacts relationship to the accounts.
        List<Database.SaveResult> saveResults = Database.insert(dataToInsert);
        // Create a list of Success & Failures for verification of the result
        List<Id> successes = new List<Id>();
        List<Id> failures = new List<Id>();
        for (Database.SaveResult sr : saveResults) {
            if (sr.isSuccess()) {
                successes.add(sr.id);
            } else {
                failures.add(sr.id);
            }
        }
        System.debug(LoggingLevel.INFO, 'Successes: ' + successes);
        System.debug(LoggingLevel.INFO, 'Failures: ' + failures);
    }
}
