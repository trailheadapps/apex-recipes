# RestClient

This class provides an exmaple of an intelligent abstraction for
making REST callouts to external endpoints. It utilizes NamedCredentials
for security. This class is designated as Virtual so that
API Service classes can extend it, and make use of it's methods easily.
See the CovidTrackerAPI class for an example of how an API service class
can extend RestClient.
This class also provides static methods - so that the abstractions
provided can be used in a one-off or ad-hoc manner for situations
where a full API Service class isn't needed.
More on Named Credentials:
https://sfdc.co/named-credentials


**Group** Shared Code


**See** [AtFutureRecipes](https://github.com/trailheadapps/apex-recipes/wiki/AtFutureRecipes)


**See** [QueueableWithCalloutRecipes](https://github.com/trailheadapps/apex-recipes/wiki/QueueableWithCalloutRecipes)


**See** [ApiServiceRecipes](https://github.com/trailheadapps/apex-recipes/wiki/ApiServiceRecipes)


**See** [CalloutRecipes](https://github.com/trailheadapps/apex-recipes/wiki/CalloutRecipes)

## Constructors
### `public RestClient(String namedCredential)`

Constructor that sets Named Credential

#### Parameters

|Param|Description|
|---|---|
|`namedCredential`|name of the Named Credential to use|

### `protected RestClient()`

`SUPPRESSWARNINGS`

This constructor isn't intended for use, which is why it's access modifier is 'Protected'. However, any child class extending this class will either have to implement constructors matching the one above, or this constructor must exist. In order to make this abstraction as useful as possible, we've elected to leave this constructor here, but unavailable to anything but inner classes and classes that extend this one.

---
## Fields

### `private defaultHeaders` → `Map<String,String>`

`TESTVISIBLE` 

These two properties are not public - which means that in order to manipulate them during a Unit test, we have to mark them

---
## Properties

### `protected namedCredentialName` → `String`

`TESTVISIBLE` 

The name of the Named Credential to use

---
## Methods
### `protected HttpResponse makeApiCall(HttpVerb method, String path, String query, String body, Map<String,String> headers)`

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
## Enums
### HttpVerb

This ENUM lists possible HTTP Verbs. Note: 'Delete' is an Apex Keyword (DML)
and as a result, the ENUM value 'DEL' is used for delete.


---
