---
layout: default
---
# CustomRestEndpointRecipes

`SUPPRESSWARNINGS`

`RESTRESOURCE`

An Apex class can be used to generate a custom REST endpoint
that can be exposed to the Salesforce API. In order to achieve this, we can
annotate the class with &commat;RestResource and then provide a URL mapping. In
this example we are using /integration-service/* to expose the class. It can
then be accessed at by performing a callout to
&lt;INSTANCEURL&gt;/services/apexrest/integration-service. Once the class has been
designated as a REST resource, we can then annoate our apex methods with
&commat;HttpGet, &commat;HttpDelete, &commat;HttpPut, &commat;HttpPost, and &commat;HttpPatch to enable access
via it's relative Http Method.
Note: The examples in this class are not Apex code, but rather cURL commands.
cURL is a command line utiltiy for Windows, Mac and Linux that allows you to
interact with Rest Resources and URLs to exchange data. Please excute these
examples in your terminal application of choice.  You might also consider a
third party UI based tool like Postman to ease things like authentication.
Note: There is a &commat;suppressWarnings annotation on this class for Cyclomatic
Complexity. You can read more about what Cyclomatic Complexity is here:
https://en.wikipedia.org/wiki/Cyclomatic_complexity Classes with a high
Cyclomatic Compelexity score are harder to test, and more prone to bugs
because of the sheer number of branching logic paths available. This class
is made up of a number of small methods, each of whom does CRUD/FLS Checks
and therefor every method includes at least one branching path - but not
much else. Other classes in this repository do not have such a high
Cyclomatic Complexity because the ratio of logic to if/else statments is much
lower.
See CalloutRecipes for examples on how to call the custom REST endpoint.


**Group** Integration Recipes


**See** [CanTheUser](../Security-Recipes/CanTheUser.md)

## Fields

### `private circuitBreaker` → `Exception`

`TESTVISIBLE` 

private, test visible circiut breaker boolean.

---
## Methods
### `global static getRecordsToReturn()`

`SUPPRESSWARNINGS`

`HTTPGET`

&commat;HttpGet exposes a method to a GET request when the custom REST endpoint is called. A GET request allows us to return data from Salesforce. In this example, we're going to query a list of Accounts that were created and return them to the application that called the endpoint. When creating a response we can use the RestResponse class to specify certain fields of the payload that is sent. We are manually setting the statusCode as 200 for a successful get and 400 on error. In any other case, Salesforce will supply the error code. Note: This method has a false-positive PMD warning. Our Query includes the keyword 'WITH USER_MODE' which prevents this Query from accessing fields and objects that they don't have permission to access. This is a form of inline CRUD/FLS Check. The return statement is atomically serialized and returned in the responseBody.

#### Returns

|Type|Description|
|---|---|
|String|RestResponse  A list of Accounts or the exception message|

#### Example
```apex
curl -H "Authorization: Bearer <SessionID>" "https://<Org Base URL>/services/apexrest/integration-service"
```


### `global static deleteSingleContact()`

`SUPPRESSWARNINGS`

`HTTPDELETE`

&commat;HttpDelete exposes the method to a DELETE request when the custom REST endpoint is called. A DELETE request allows us to delete data in Salesforce. In this Example, we're going to take a record Id that was sent in the RestRequest and delete the record from Salesforce. We will take the RestRequest Parameters and get the ExternalSalesforceId__c param from the request. Note: This method has a false-positive PMD warning. Our Query includes the keyword 'WITH USER_MODE' which prevents this Query from accessing fields and objects that they don't have permission to access. This is a form of inline CRUD/FLS Check.

#### Returns

|Type|Description|
|---|---|
|String|RestResponse A success message or the exception message|

#### Example
```apex
curl —X DELETE -H "Authorization: Bearer <SessionID>" "https://<Org Base URL>/services/apexrest/integration-service"
```


### `global static parseAndCreateNewContacts()`

`SUPPRESSWARNINGS`

`HTTPPOST`

&commat;HttpPost exposes the method to a POST request when the custom REST endpoint is called. A POST request allows us to insert data into Salesforce. In this Example, we're going take the list of Contacts that was sent in the request and insert them into Salesforce. Note: This method has a false-positive PMD warning. PMD isn't aware of the purpose or functionality of CanTheUser.* so it doesn't undersatnd that we are, in fact, checking for Crud / FLS permissions prior to querying.

#### Returns

|Type|Description|
|---|---|
|String|RestResponse A success message or the exception message|

#### Example
```apex
Create file with the following JSON, named newContact.json
    {
      "firstName" : "Apex",
      "lastName": "Recipes",
      "phone" : "919-867-5309",
    }
curl -H "Authorization: Bearer <SessionID>" -H "Content-Type: application/json" -d &commat;newContact.json "https://<Org Base URL>/services/apexrest/integration-service"
```


### `global static upsertContactRecords()`

`SUPPRESSWARNINGS`

`HTTPPUT`

&commat;HttpPut exposes the method to a PUT request when the custom REST endpoint is called.  A PUT request allows us to Upsert data into Salesforce. In this Example, we're going take the list of Contacts that was sent in the request and upsert them into Salesforce. This method has a false-positive PMD warning. PMD isn't aware of the purpose or functionality of CanTheUser.* so it doesn't undersatnd that we are, in fact, checking for Crud / FLS permissions prior to querying.

#### Returns

|Type|Description|
|---|---|
|String|RestResponse A success message or the exception message|

#### Example
```apex
Create file with the following JSON, named newContact.json
    {
      "firstName" : "Apex",
      "lastName": "Recipes",
      "phone" : "919-867-5309",
      "ExternalSalesforceId__c": "
    }
curl -H "Authorization: Bearer <SessionID>" -H "Content-Type: application/json" -d &commat;newContact.json "https://<Org Base URL>/services/apexrest/integration-service"
Then, Modify the first name of your newContact.json file so it says "Apex2" and run
curl —X PUT -H "Authorization: Bearer <SessionID>" -H "Content-Type: application/json" -d &commat;newContact.json "https://<Org Base URL>/services/apexrest/integration-service"
```


### `global static updateAccountRecords()`

`SUPPRESSWARNINGS`

`HTTPPATCH`

&commat;HttpPatch exposes the method to a PATCH request when the custom REST endpoint is called. A PATCH request allows us to Update data in Salesforce. In this Example, we're going take the list of Accounts that was sent in the request and update in Salesforce. Note: This method has a false-positive PMD warning. PMD isn't aware of the purpose or functionality of CanTheUser.* so it doesn't undersatnd that we are, in fact, checking for CRUD / FLS permissions prior to querying.

#### Returns

|Type|Description|
|---|---|
|String|RestResponse A success message or the exception message|

#### Example
```apex
Create file with the following JSON, named newContact.json
    {
      "firstName" : "Apex",
      "lastName": "Recipes",
      "phone" : "919-867-5309",
      "ExternalSalesforceId__c": "
    }
curl -H "Authorization: Bearer <SessionID>" -H "Content-Type: application/json" -d &commat;newContact.json "https://<Org Base URL>/services/apexrest/integration-service"
Then, Modify the first name of your newContact.json file so it says "Apex2" and run
curl —X PATCH -H "Authorization: Bearer <SessionID>" -H "Content-Type: application/json" -d &commat;newContact.json "https://<Org Base URL>/services/apexrest/integration-service"
```


---
