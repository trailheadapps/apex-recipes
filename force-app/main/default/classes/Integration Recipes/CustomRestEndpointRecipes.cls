/**
 * @description An Apex class can be used to generate a custom REST endpoint
 * that can be exposed to the Salesforce API. In order to achieve this, we can
 * annotate the class with `@RestResource` and then provide a URL mapping. In
 * this example we are using `/integration-service/*` to expose the class. It can
 * then be accessed at by performing a callout to
 * `<INSTANCEURL>/services/apexrest/integration-service`. Once the class has been
 * designated as a REST resource, we can then annoate our apex methods with
 * `@HttpGet`, `@HttpDelete`, `@HttpPut`, `@HttpPost`, and `@HttpPatch` to enable access
 * via it's relative Http Method.
 *
 * Note: The examples in this class are not Apex code, but rather cURL commands.
 * cURL is a command line utiltiy for Windows, Mac and Linux that allows you to
 * interact with Rest Resources and URLs to exchange data. Please excute these
 * examples in your terminal application of choice.  You might also consider a
 * third party UI based tool like Postman to ease things like authentication.
 *
 * Note: There is a `@suppressWarnings` annotation on this class for Cyclomatic
 * Complexity. You can read more about what Cyclomatic Complexity is here:
 * https://en.wikipedia.org/wiki/Cyclomatic_complexity Classes with a high
 * Cyclomatic Compelexity score are harder to test, and more prone to bugs
 * because of the sheer number of branching logic paths available. This class
 * is made up of a number of small methods, each of whom does CRUD/FLS Checks
 * and therefor every method includes at least one branching path - but not
 * much else. Other classes in this repository do not have such a high
 * Cyclomatic Complexity because the ratio of logic to if/else statments is much
 * lower.
 *
 * See CalloutRecipes for examples on how to call the custom REST endpoint.
 * @group Integration Recipes
 * @see CanTheUser
 */
@SuppressWarnings('PMD.CyclomaticComplexity')
@RestResource(urlmapping='/integration-service/*')
global inherited sharing class CustomRestEndpointRecipes {
    /**
     * @description private, test visible circiut breaker boolean.
     */
    @TestVisible
    private static Exception circuitBreaker;

    /**
     * @description `@HttpGet` exposes a method to a GET request when the custom
     * REST endpoint is called. A GET request allows us to return data from
     * Salesforce. In this example, we're going to query a list of Accounts that
     * were created and return them to the application that called the endpoint.
     * When creating a response we can use the RestResponse class to specify
     * certain fields of the payload that is sent. We are manually setting the
     * statusCode as 200 for a successful get and 400 on error. In any other
     * case, Salesforce will supply the error code.
     *
     * Note: This method has a false-positive PMD warning. Our Query
     * includes the keyword `WITH USER_MODE` which prevents this
     * Query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     *
     * The return statement is atomically serialized and returned in the
     * responseBody.
     * @return JSON string holding the list of Accounts or the exception message
     * @example
     * ```sh
     * curl -H "Authorization: Bearer <SessionID>" "https://<Org Base URL>/services/apexrest/integration-service"
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    @HttpGet
    global static String getRecordsToReturn() {
        // Instantiate the RestResponse
        RestResponse response = RestContext.response;
        try {
            List<Account> accounts = [
                SELECT Id, Name, Phone, Website
                FROM Account
                WITH USER_MODE
            ];
            if (
                Test.isRunningTest() &&
                CustomRestEndpointRecipes.circuitBreaker != null
            ) {
                throw CustomRestEndpointRecipes.circuitBreaker;
            }
            // Manually set the status code
            response.statusCode = 200;
            String serializedAccounts = JSON.serialize(accounts);
            // We will return the body of the response and salesforce will add
            // in the REST of the response.
            return serializedAccounts;
        } catch (QueryException qe) {
            // If we have an issue querying the Accounts we can catch the Query
            // exception
            // We are unable to test this for code coverage as we can't trigger
            // the query exception without changing user permissions
            System.debug(
                LoggingLevel.INFO,
                'Failed to query a list of Accounts. Error is: ' +
                qe.getMessage()
            );
            response.statusCode = 400;
            return qe.getMessage();
        }
    }

    /**
     * @description `@HttpDelete` exposes the method to a DELETE request when the
     * custom REST endpoint is called. A DELETE request allows us to delete data
     * in Salesforce. In this Example, we're going to take a record Id that was
     * sent in the RestRequest and delete the record from Salesforce. We will
     * take the RestRequest Parameters and get the `ExternalSalesforceId__c` param
     * from the request.
     * Note: This method has a false-positive PMD warning. Our Query
     * includes the keyword `WITH USER_MODE` which prevents this
     * Query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     * @return JSON string holding a success message or the exception message
     * @example
     * ```sh
     * curl —X DELETE -H "Authorization: Bearer <SessionID>" "https://<Org Base URL>/services/apexrest/integration-service"
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    @HttpDelete
    global static String deleteSingleContact() {
        // Get the details of the RestRequest from the RestContext
        RestRequest request = RestContext.request;
        // We can get the Id of the contact from the URL params by isolating the
        // requestUri from the RestRequest
        String recordId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/') + 1
        );
        RestResponse response = RestContext.response;
        if (!CanTheUser.destroy(new Contact())) {
            response.statusCode = 500;
            return 'User does not have permission to delete contacts';
        }
        try {
            if (
                Test.isRunningTest() &&
                CustomRestEndpointRecipes.circuitBreaker != null
            ) {
                throw CustomRestEndpointRecipes.circuitBreaker;
            }
            // We can query the Contact against the Id sent in the request and
            // check that it was found
            List<Contact> contacts = [
                SELECT Id
                FROM Contact
                WHERE Id = :recordId
                WITH USER_MODE
                LIMIT 1
            ];
            Contact contact = (contacts.size() == 1) ? contacts.get(0) : null;
            delete contact;
            response.statusCode = 200;
            return 'Successful Delete';
        } catch (QueryException qe) {
            // If we have an issue querying the Contact we can catch the Query
            // exception
            // We are unable to test this for code coverage as we can't trigger
            // the query exception without changing user permissions
            System.debug(
                LoggingLevel.INFO,
                'Failed to query the Contact. Error is: ' + qe.getMessage()
            );
            response.statusCode = 400;
            return qe.getMessage();
        } catch (DmlException dmle) {
            // If we have an issue deleting the Contact we can catch the DML
            // exception
            // We are unable to test this for code coverage as we can't trigger
            // the DML exception without changing user permissions
            System.debug(
                LoggingLevel.INFO,
                'Failed to delete the Contact: ' + dmle.getMessage()
            );
            response.statusCode = 400;
            return dmle.getMessage();
        } catch (Exception e) {
            // Fallback to catch any other exceptions that may occur, for
            // instance, a null pointer see test
            response.statusCode = 400;
            return e.getMessage();
        }
    }

    /**
     * @description `@HttpPost` exposes the method to a POST request when the
     * custom REST endpoint is called. A POST request allows us to insert data
     * into Salesforce. In this Example, we're going take the list of Contacts
     * that was sent in the request and insert them into Salesforce.
     *
     * Note: This method has a false-positive PMD warning. PMD isn't aware of
     * the purpose or functionality of `CanTheUser.*` so it doesn't undersatnd
     * that we are, in fact, checking for Crud / FLS permissions prior to querying.
     *
     * @return JSON string holding a success message or the exception message
     * @example
     * Create file with the following JSON, named `newContact.json`
     * ```json
     * {
     *   "firstName" : "Apex",
     *   "lastName": "Recipes",
     *   "phone" : "919-867-5309",
     * }
     * ```
     * ```sh
     * curl -H "Authorization: Bearer <SessionID>" -H "Content-Type: application/json" -d @newContact.json "https://<Org Base URL>/services/apexrest/integration-service"
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    @HttpPost
    global static String parseAndCreateNewContacts() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        try {
            if (
                Test.isRunningTest() &&
                CustomRestEndpointRecipes.circuitBreaker != null
            ) {
                throw CustomRestEndpointRecipes.circuitBreaker;
            }
            String requestBody = request.requestBody.toString();
            // Deseralize the requestBody into a list of Contacts
            List<Contact> contactRecords = (List<Contact>) JSON.deserialize(
                requestBody,
                List<Contact>.class
            );
            // insert the requsts Contacts
            if (CanTheUser.create(contactRecords[0])) {
                insert contactRecords;
                response.statusCode = 200;
                return 'Successful Insert';
            } else {
                response.statusCode = 500;
                return 'User does not have permission to create Contacts';
            }
        } catch (JSONException je) {
            // If we have an issue deserializing the Contacts we can catch the
            // JSON exception
            System.debug(
                LoggingLevel.INFO,
                'Failed to deserialize the list of Contacts. Error is: ' +
                je.getMessage()
            );
            response.statusCode = 400;
            return je.getMessage();
        } catch (DmlException dmle) {
            // If we have an issue inserting the Contacts we can catch the DML
            // exception
            // We are unable to test this for code coverage as we can't trigger
            // the DML exception without changing user permissions
            System.debug(
                LoggingLevel.INFO,
                'Failed to insert the Contacts: ' + dmle.getMessage()
            );
            response.statusCode = 400;
            return dmle.getMessage();
        } catch (Exception e) {
            // Fallback to catch any other exceptions that may occur
            response.statusCode = 400;
            return e.getMessage();
        }
    }

    /**
     * @description `@HttpPut` exposes the method to a PUT request when the custom
     * REST endpoint is called.  A PUT request allows us to Upsert data into
     * Salesforce. In this Example, we're going take the list of Contacts that
     * was sent in the request and upsert them into Salesforce.
     *
     * This method has a false-positive PMD warning. PMD isn't aware of
     * the purpose or functionality of `CanTheUser.*` so it doesn't undersatnd
     * that we are, in fact, checking for Crud / FLS permissions prior to
     * querying.
     *
     * @return JSON string holding a success message or the exception message
     * @example
     * Create file with the following JSON, named `newContact.json`
     * ```json
     * {
     *   "firstName" : "Apex",
     *   "lastName": "Recipes",
     *   "phone" : "919-867-5309",
     *   "ExternalSalesforceId__c": "
     * }
     * ```
     * ```sh
     * curl -H "Authorization: Bearer <SessionID>" -H "Content-Type: application/json" -d @newContact.json "https://<Org Base URL>/services/apexrest/integration-service"
     * ```
     * Then, modify the first name of your `newContact.json` file so it says `Apex2` and run
     * ```sh
     * curl —X PUT -H "Authorization: Bearer <SessionID>" -H "Content-Type: application/json" -d @newContact.json "https://<Org Base URL>/services/apexrest/integration-service"
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    @HttpPut
    global static String upsertContactRecords() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        try {
            if (
                Test.isRunningTest() &&
                CustomRestEndpointRecipes.circuitBreaker != null
            ) {
                throw CustomRestEndpointRecipes.circuitBreaker;
            }
            String requestBody = request.requestBody.toString();
            // Deserialize the requestBody into a list of Contacts
            List<Contact> contactRecords = (List<Contact>) JSON.deserialize(
                requestBody,
                List<Contact>.class
            );

            if (
                CanTheUser.create(contactRecords[0]) &&
                CanTheUser.edit(contactRecords[0])
            ) {
                // upsert the Contacts by their ExternalId__c
                upsert contactRecords ExternalSalesforceId__c;
                response.statusCode = 200;
                return 'Successful Upsert';
            } else {
                response.statusCode = 500;
                return 'User does not have create or edit permissions';
            }
        } catch (JSONException je) {
            // If we have an issue deserializing the Contacts we can catch the
            // JSON exception
            System.debug(
                LoggingLevel.INFO,
                'Failed to deserialize the list of Contacts. Error is: ' +
                je.getMessage()
            );
            response.statusCode = 400;
            return je.getMessage();
        } catch (DmlException dmle) {
            // If we have an issue upserting the Contacts we can catch the DML
            // exception
            System.debug(
                LoggingLevel.INFO,
                'Failed to upsert the Contacts: ' + dmle.getMessage()
            );
            response.statusCode = 400;
            return dmle.getMessage();
        } catch (Exception e) {
            // Fallback to catch any other exceptions that may occur
            response.statusCode = 400;
            return e.getMessage();
        }
    }

    /**
     * @description `@HttpPatch` exposes the method to a PATCH request when the
     * custom REST endpoint is called. A PATCH request allows us to Update
     * data in Salesforce. In this Example, we're going take the list of
     * Accounts that was sent in the request and update in Salesforce.
     *
     * Note: This method has a false-positive PMD warning. PMD isn't aware of
     * the purpose or functionality of `CanTheUser.*` so it doesn't undersatnd
     * that we are, in fact, checking for CRUD / FLS permissions prior to
     * querying.
     *
     * @return A JSON string holding a success message or the exception message
     * @example
     * Create file with the following JSON, named `newContact.json`
     * ```json
     * {
     *   "firstName" : "Apex",
     *   "lastName": "Recipes",
     *   "phone" : "919-867-5309",
     *   "ExternalSalesforceId__c": "
     * }
     * ```
     * ```sh
     * curl -H "Authorization: Bearer <SessionID>" -H "Content-Type: application/json" -d @newContact.json "https://<Org Base URL>/services/apexrest/integration-service"
     * ```
     * Then, modify the first name of your `newContact.json` file so it says `Apex2` and run
     * ```sh
     * curl —X PATCH -H "Authorization: Bearer <SessionID>" -H "Content-Type: application/json" -d @newContact.json "https://<Org Base URL>/services/apexrest/integration-service"
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    @HttpPatch
    global static String updateAccountRecords() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        try {
            if (
                Test.isRunningTest() &&
                CustomRestEndpointRecipes.circuitBreaker != null
            ) {
                throw CustomRestEndpointRecipes.circuitBreaker;
            }
            String requestBody = request.requestBody.toString();
            // Deseralize the requestBody into a list of Accounts
            List<Account> accountRecords = (List<Account>) JSON.deserialize(
                requestBody,
                List<Account>.class
            );

            if (!CanTheUser.edit(accountRecords[0])) {
                response.statusCode = 500;
                return 'User has no edit access to Accounts';
            }

            // Loop through the list of Accounts and reassign the ExternalId__c
            // to the Account Id for matching
            for (Account account : accountRecords) {
                account.Id = account.ExternalSalesforceId__c;
                account.Name = account.Name;
                account.Website = account.Website;
            }
            // Update the account records
            update accountRecords;
            response.statusCode = 200;
            return 'Successful Update';
        } catch (JSONException je) {
            // If we have an issue deserializing the Accounts we can catch the
            // JSON exception
            System.debug(
                LoggingLevel.INFO,
                'Failed to deserialize the list of Accounts. Error is: ' +
                je.getMessage()
            );
            response.statusCode = 400;
            return je.getMessage();
        } catch (DmlException dmle) {
            // If we have an issue updating the Accounts we can catch the DML
            // exception
            System.debug(
                LoggingLevel.INFO,
                'Failed to update the accounts: ' + dmle.getMessage()
            );
            response.statusCode = 400;
            return dmle.getMessage();
        } catch (Exception e) {
            // Fallback to catch any other exceptions that may occur
            response.statusCode = 400;
            return e.getMessage();
        }
    }
}
