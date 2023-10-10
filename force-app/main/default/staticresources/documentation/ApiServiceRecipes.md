# ApiServiceRecipes

This recipe extends the custom RestClient class and
represents a specific API service we need to interact with - in
this case a MockBin REST service. This APIService class is responsible
for serializing and deserializing the Data Transfer Objects (Model Objects)
necessary for input and output from this org to the third party system and
back.
More on MockBin here: http://mockbin.org/


**Inheritance**

[RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient)
 &gt; 
ApiServiceRecipes


**Group** Integration Recipes


**See** [RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient)


**See** [ApiServiceRecipesDataModel](https://github.com/trailheadapps/apex-recipes/wiki/ApiServiceRecipesDataModel)

## Constructors
### `public ApiServiceRecipes()`

default constructor. Sets the inherited named credential to the DEFAULTNAMEDCREDENTIAL constant above. Setting the namedCredentialName binds all the methods in this class to the specific namedCredential URL and auth.

---
## Fields

### `private DEFAULTNAMEDCREDENTIAL` → `String`

`TESTVISIBLE` 

### `private GETBINPATH` → `String`


---
## Properties

### `protected namedCredentialName` → `String`

*Inherited*
`TESTVISIBLE` 

The name of the Named Credential to use

---
## Methods
### `public List<ApiServiceRecipesDataModel> getCurrentData()`

Encapsulates a specific callout to the Named Credential URL that returns JSON into an method that transforms the raw JSON into an Apex Object.

#### Returns

|Type|Description|
|---|---|
|`List<ApiServiceRecipesDataModel>`|`List<ApiServiceRecipesDataModel>`|

#### Example
```apex
ApiServiceRecipes asr = new ApiServiceRecipes();
System.debug(asr.getCurrentData());
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
### ApiException

Internal custom exception used by this class for errors


**Inheritance**

ApiException


---
