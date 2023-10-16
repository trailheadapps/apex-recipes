# CalloutRecipes

Demonstrates how to make an opinionated REST callout.
This class utilizes the custom RestClient from the Shared Code group.


**Inheritance**

[RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient)
 &gt; 
CalloutRecipes


**Group** Integration Recipes


**See** [RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient)

## Constructors
### `public CalloutRecipes(String namedCredential)`

Constructor accepting a named credential.

#### Parameters

|Param|Description|
|---|---|
|`namedCredential`|name of the Named Credential to use|

---
## Properties

### `protected namedCredentialName` → `String`

*Inherited*
`TESTVISIBLE` 

The name of the Named Credential to use

---
## Methods
### `public static String rawCallout()`

Demonstrates how to make a raw HTTP request. This method demonstrates how to use the Http, HttpRequest and HttpResponse objects to construct a single get request. The other methods in this class demonstrate the use of an intelligent abstraction layer - `RestClient.cls` - to make sending Http Requests easier, easier to test, and less error prone.

#### Returns

|Type|Description|
|---|---|
|`String`|Response body as a string|

#### Example
```apex
System.debug(CalloutRecipes.rawCallout());
```


### `public List<Account> httpGetCalloutToSecondOrg()`

Demonstrates a GET request to a second Salesforce org. A Get request is used to retrieve data from a target endpoint, We will be using the `performRestCallout` method to make the callout. In this example, we will be requesting a list of Accounts from our second org. We will pass the endpoint our named credential, the url path to our integration-service custom REST endpoint, a null body and the GET method. We will then deserialize the JSON into a known object, in this case, a list of Accounts.

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List<Account>|

#### Example
```apex
System.debug(CalloutRecipes.httpGetCalloutToSecondOrg());
```


### `public Integer httpDeleteCalloutToSecondOrg(Id contactId)`

Demonstrates a DELETE request to a second Salesforce org - A DELETE request is used to delete data from the target endpoint. In this example, we will be deleting a contact from another Salesforce org. We will store the parameters in the urlPath which can then be accessed through the .getParams() method in the org receiving the delete request.

#### Parameters

|Param|Description|
|---|---|
|`contactId`|the Id of the contact that you would like to delete in the second org.|

#### Returns

|Type|Description|
|---|---|
|`Integer`|String|

#### Example
```apex
Id contactId = [SELECT Id FROM Contact LIMIT 1].id;
System.debug(CalloutRecipes.httpDeleteCalloutToSecondOrg(contactId));
```


### `public Integer httpPostCalloutToSecondOrg(List<Contact> contactRecords)`

Demonstrates a POST request to a second Salesforce org a POST request is used to send data to a target endpoint and insert it. In this example, we will be sending a list of contact records to a second Salesforce org. We will serilaize the list and POST it in body of the callout.

#### Parameters

|Param|Description|
|---|---|
|`contactRecords`|a list of contact records to be inserted in the second salesforce org|

#### Returns

|Type|Description|
|---|---|
|`Integer`|String|

#### Example
```apex
List<Contact> contacts = [SELECT id, firstName, lastName FROM Contact LIMIT 5];
System.debug(CalloutRecipes.httpPostCalloutToSecondOrg(contacts));
```


### `public Integer httpPutCalloutToSecondOrg(List<Contact> contactRecords)`

Demonstrates a PUT request to a second Salesforce org a PUT request is used to send data to a target endpoint and upsert it. In this example, we will be sending a list of contact records to a second org.

#### Parameters

|Param|Description|
|---|---|
|`contactRecords`|a list of contact records to be upsert in the second salesforce org|

#### Returns

|Type|Description|
|---|---|
|`Integer`|String|

#### Example
```apex
List<Contact> contacts = [SELECT id, firstName, lastName FROM Contact LIMIT 5];
System.debug(CalloutRecipes.httpPutCalloutToSecondOrg(contacts));
```


### `public Integer httpPatchCalloutToSecondOrg(List<Account> accountRecords)`

Demonstrates a PATCH request to a second Salesforce org a PATCH request is used to send data to a target endpoint and update already existing data. In this example, we will be sending a list of Account records to a second salesforce org for updating.

#### Parameters

|Param|Description|
|---|---|
|`accountRecords`|a list of account records to be updated in the second salesforce org|

#### Returns

|Type|Description|
|---|---|
|`Integer`|String The status of the callout|

#### Example
```apex
List<Contact> contacts = [SELECT id, firstName, lastName FROM Contact LIMIT 5];
System.debug(CalloutRecipes.httpPatchCalloutToSecondOrg(contacts));
```


### `public Map<String,Object> httpCalloutWithUntypedResponse()`

Now that we have demonstrated how to callout to an endpoint, lets take a look at what else we can do with the response. When calling out to an external endpoint, the data may not always be in a format that can be directly deserialised into a Salesforce Object. If your callout returns untyped JSON, you can deserialize this into a Map&lt;String, Object&gt; by using a deserializeUntyped method to convert the string.

#### Returns

|Type|Description|
|---|---|
|`Map<String,Object>`|Map<String, Object>|

#### Example
```apex
System.debug(CalloutRecipes.httpCalloutWithUntypedResponse());
```


### `public void insertAccountAndContactsFromUntypedResponse(String untypedResponse)`

As seen in the httpCalloutWithUntypedResponse method, we don't always get a perfect datastructure back from our callout. In this case, we have received and account and it's contacts that need to be inserted into Salesforce. Check out the Test class for an example of an untyped data structure.

#### Parameters

|Param|Description|
|---|---|
|`untypedResponse`|the untyped JSON response that we received from our previous callout|

#### Example
```apex
CalloutRecipes.insertAccountAndContactsFromUntypedResponse(CalloutRecipes_Tests.goodUntypedJSON)
```


### `protected HttpResponse makeApiCall(HttpVerb method, String path, String query, String body, Map<String,String> headers)`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Omnibus callout method. This is the primary method for making a REST callout. Most of the other methods in this class serve as convient, syntactic sugar on this method.

#### Parameters

|Param|Description|
|---|---|
|`method`|Enum HTTP verb to use. i.e. GET|
|`path`|patch component of the callout url i.e. `/services/data/v39.0/SObjects`|
|`query`|Query portion of the URL i.e. `?q=SELECT Id FROM Account`|
|`body`|JSON string representing the body of the callout in post/patch situations|
|`headers`|A map<String,String> of headers to use while making this callout|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|HttpResponse  HttpResponse Obj|

### `protected HttpResponse makeApiCall(HttpVerb method, String path, String query, String body)`

*Inherited*


`TESTVISIBLE`

`SUPPRESSWARNINGS`

Makes an HTTP Callout to an api resource. Convienence method that assumes the Default Headers.

#### Parameters

|Param|Description|
|---|---|
|`method`|HTTPVerb to use. See the enum above.|
|`path`|Http path component of the URL. ie: `/path/to/resource`|
|`query`|Query component of the URL ie: after `?foo=bar`|
|`body`|Body to send with this call.|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HttpResponse`|

### `protected HttpResponse makeApiCall(HttpVerb method, String path, String query)`

*Inherited*


`TESTVISIBLE`

convenience version of makeApiCall without body param. Invokes omnibus version above, with blank body param and default headers.

#### Parameters

|Param|Description|
|---|---|
|`method`|HTTPVerb to use. See the enum above.|
|`path`|Http path component of the URL. ie: `/path/to/resource`|
|`query`|Query component of the URL ie: after `?foo=bar`|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

### `protected HttpResponse makeApiCall(HttpVerb method, String path)`

*Inherited*


`TESTVISIBLE`

convenience version of makeApiCall without body or query params. Invokes omnibus version above, with blank body and query params

#### Parameters

|Param|Description|
|---|---|
|`method`|HTTPVerb to use. See the enum above.|
|`path`|Http path component of the URL. ie: `/path/to/resource`|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

### `protected HttpResponse get(String path)`

*Inherited*


`TESTVISIBLE`

convenience method for a GET Call that only requires a path

#### Parameters

|Param|Description|
|---|---|
|`path`|Http path component of the URL. ie: `/path/to/resource`|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

### `protected HttpResponse get(String path, String query)`

*Inherited*


`TESTVISIBLE`

convenience method for a GET Call that only requires a path and query

#### Parameters

|Param|Description|
|---|---|
|`path`|Http path component of the URL. ie: `/path/to/resource`|
|`query`|Query component of the URL ie: after `?foo=bar`|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

### `protected HttpResponse del(String path)`

*Inherited*


`TESTVISIBLE`

convenience method for deleteing a resource based only on path

#### Parameters

|Param|Description|
|---|---|
|`path`|Http path component of the URL. ie: `/path/to/resource`|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

### `protected HttpResponse del(String path, String query)`

*Inherited*


`TESTVISIBLE`

convenience method for a Delete Call that only requires a path and query

#### Parameters

|Param|Description|
|---|---|
|`path`|Http path component of the URL. ie: `/path/to/resource`|
|`query`|Query component of the URL ie: after `?foo=bar`|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

### `protected HttpResponse post(String path, String body)`

*Inherited*


`TESTVISIBLE`

convenience method for a POST Call that only requires a path and body

#### Parameters

|Param|Description|
|---|---|
|`path`|Http path component of the URL. ie: `/path/to/resource`|
|`body`|JSON string to post|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

### `protected HttpResponse post(String path, String query, String body)`

*Inherited*


`TESTVISIBLE`

convenience method for a POST Call that only requires a path, query and body

#### Parameters

|Param|Description|
|---|---|
|`path`|Http path component of the URL. ie: `/path/to/resource`|
|`query`|Query component of the URL ie: after `?foo=bar`|
|`body`|JSON string to post|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

### `protected HttpResponse put(String path, String body)`

*Inherited*


`TESTVISIBLE`

convenience method for a PUT Call that only requires a path and body

#### Parameters

|Param|Description|
|---|---|
|`path`|Http path component of the URL. ie: `/path/to/resource`|
|`body`|JSON string to post|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

### `protected HttpResponse put(String path, String query, String body)`

*Inherited*


`TESTVISIBLE`

convenience method for a PUT Call that only requires a path, query and body

#### Parameters

|Param|Description|
|---|---|
|`path`|Http path component of the URL. ie: `/path/to/resource`|
|`query`|Query component of the URL ie: after `?foo=bar`|
|`body`|JSON string to post|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

### `protected HttpResponse patch(String path, String body)`

*Inherited*


`TESTVISIBLE`

convenience method for a PATCH Call that only requires a path, query and body

#### Parameters

|Param|Description|
|---|---|
|`path`|Http path component of the URL. ie: `/path/to/resource`|
|`body`|JSON string to post|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

### `protected HttpResponse patch(String path, String query, String body)`

*Inherited*


`TESTVISIBLE`

convenience method for a PATCH Call that only requires a path, query and body

#### Parameters

|Param|Description|
|---|---|
|`path`|Http path component of the URL. ie: `/path/to/resource`|
|`query`|Query component of the URL ie: after `?foo=bar`|
|`body`|JSON string to post|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

### `protected String ensureStringEndsInSlash(String resource)`

*Inherited*


`TESTVISIBLE`

Ensures that the inputted string ends in a `/` makes callouts more robust.

#### Parameters

|Param|Description|
|---|---|
|`resource`|string to ensure ends in `/`|

#### Returns

|Type|Description|
|---|---|
|`String`|inputted string with `/` if it didn't already end in one.|

### `public static HttpResponse makeApiCall(String namedCredential, HttpVerb method, String path, String query, String body, Map<String,String> headers)`

*Inherited*


`SUPPRESSWARNINGS`

A static wrapper for the main makeApiCall method

#### Parameters

|Param|Description|
|---|---|
|`namedCredential`|The named credential to use|
|`method`|HTTPVerb enum value. See Enum above|
|`path`|Http path component of the URL. ie: `/path/to/resource`|
|`query`|Query component of the URL ie: after `?foo=bar`|
|`body`|JSON string to post|
|`headers`|Map<String,String> representing outgoing Request headers|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

#### Example
```apex
System.Debug(RestClient.makeApiCall('MockBin',
                                     RestClient.HttpVerb.GET,
                                     '4cb453a6-a23b-42ea-a6ba-9be1c1f17050',
                                     '',
                                     '',
                                     new Map<String,String>()));
```


### `public static HttpResponse makeApiCall(String namedCredential, HttpVerb method, String path, String query)`

*Inherited*


`SUPPRESSWARNINGS`

A static wrapper for the main makeApiCall method that assumes default headers.

#### Parameters

|Param|Description|
|---|---|
|`namedCredential`|The named credential to use|
|`method`|HTTPVerb enum value. See Enum above|
|`path`|Http path component of the URL. ie: `/path/to/resource`|
|`query`|Query component of the URL ie: after `?foo=bar`|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

#### Example
```apex
System.Debug(RestClient.makeApiCall('MockBin',
                                     RestClient.HttpVerb.GET,
                                     '4cb453a6-a23b-42ea-a6ba-9be1c1f17050',
                                     ''));
```


### `public static HttpResponse makeApiCall(String namedCredential, HttpVerb method, String path)`

*Inherited*


A static wrapper for the main makeApiCall method where you only need the path

#### Parameters

|Param|Description|
|---|---|
|`namedCredential`|The named credential to use|
|`method`|HTTPVerb enum value. See Enum above|
|`path`|Http path component of the URL. ie: `/path/to/resource`|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|`HTTPResponse`|

#### Example
```apex
System.Debug(RestClient.makeApiCall('MockBin',
                                     RestClient.HttpVerb.GET,
                                     '4cb453a6-a23b-42ea-a6ba-9be1c1f17050'));
```


---
## Classes
### CalloutRecipesException

Internal custom exception class


**Inheritance**

CalloutRecipesException


---
