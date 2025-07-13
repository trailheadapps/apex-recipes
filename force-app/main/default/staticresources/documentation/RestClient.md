# RestClient Class
`virtual`

This class provides an example of an intelligent abstraction for 
making REST callouts to external endpoints. It utilizes NamedCredentials 
for security. This class is designated as Virtual so that 
API Service classes can extend it, and make use of it&#x27;s methods easily. 
See the CovidTrackerAPI class for an example of how an API service class 
can extend RestClient. 
 
This class also provides static methods - so that the abstractions 
provided can be used in a one-off or ad-hoc manner for situations 
where a full API Service class isn&#x27;t needed. 
 
More on Named Credentials: 
https://sfdc.co/named-credentials

**Group** Shared Code

**See** [AtFutureRecipes](https://github.com/trailheadapps/apex-recipes/wiki/AtFutureRecipes)

**See** [QueueableWithCalloutRecipes](https://github.com/trailheadapps/apex-recipes/wiki/QueueableWithCalloutRecipes)

**See** [ApiServiceRecipes](https://github.com/trailheadapps/apex-recipes/wiki/ApiServiceRecipes)

**See** [CalloutRecipes](https://github.com/trailheadapps/apex-recipes/wiki/CalloutRecipes)

## Fields
### `defaultHeaders`

`TESTVISIBLE`

These two properties are not public - which means that in 
order to manipulate them during a Unit test, we have to 
mark them

**TestVisible** 

The namedCredentialName also demonstrates how to auto 
create a getter/setter for a property with the 
{get;set;} syntax

#### Signature
```apex
private static defaultHeaders
```

#### Type
Map&lt;String,String&gt;

## Properties
### `namedCredentialName`

`TESTVISIBLE`

The name of the Named Credential to use

#### Signature
```apex
protected namedCredentialName
```

#### Type
String

## Constructors
### `RestClient(namedCredential)`

Constructor that sets Named Credential

#### Signature
```apex
public RestClient(String namedCredential)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| namedCredential | String | name of the Named Credential to use |

---

### `RestClient()`

`SUPPRESSWARNINGS`

This constructor isn&#x27;t intended for use, which is why it&#x27;s 
access modifier is &#x27;Protected&#x27;. However, any child class extending 
this class will either have to implement constructors matching the one 
above, or this constructor must exist. In order to make this abstraction 
as useful as possible, we&#x27;ve elected to leave this constructor here, 
but unavailable to anything but inner classes and classes that 
extend this one.

#### Signature
```apex
protected RestClient()
```

## Methods
### `makeApiCall(method, path, query, body, headers)`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Omnibus callout method. This is the primary method for 
making a REST callout. Most of the other methods in this class serve 
as convient, syntactic sugar on this method.

#### Signature
```apex
protected HttpResponse makeApiCall(HttpVerb method, String path, String query, String body, Map<String,String> headers)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| method | HttpVerb | Enum HTTP verb to use. i.e. GET |
| path | String | patch component of the callout url i.e. `/services/data/v39.0/SObjects` |
| query | String | Query portion of the URL i.e. `?q=SELECT Id FROM Account` |
| body | String | JSON string representing the body of the callout in post/patch situations |
| headers | Map&lt;String,String&gt; | A map&lt;String,String&gt; of headers to use while making this callout |

#### Return Type
**HttpResponse**

---

### `makeApiCall(method, path, query, body)`

`TESTVISIBLE`
`SUPPRESSWARNINGS`

Makes an HTTP Callout to an api resource. 
Convienence method that assumes the Default Headers.

#### Signature
```apex
protected HttpResponse makeApiCall(HttpVerb method, String path, String query, String body)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| method | HttpVerb | HTTPVerb to use. See the enum above. |
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar` |
| body | String | Body to send with this call. |

#### Return Type
**HttpResponse**

---

### `makeApiCall(method, path, query)`

`TESTVISIBLE`

convenience version of makeApiCall without body param. 
Invokes omnibus version above, with blank body param and default headers.

#### Signature
```apex
protected HttpResponse makeApiCall(HttpVerb method, String path, String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| method | HttpVerb | HTTPVerb to use. See the enum above. |
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar` |

#### Return Type
**HttpResponse**

---

### `makeApiCall(method, path)`

`TESTVISIBLE`

convenience version of makeApiCall without body or query 
params. 
Invokes omnibus version above, with blank body and query params

#### Signature
```apex
protected HttpResponse makeApiCall(HttpVerb method, String path)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| method | HttpVerb | HTTPVerb to use. See the enum above. |
| path | String | Http path component of the URL. ie: `/path/to/resource` |

#### Return Type
**HttpResponse**

---

### `get(path)`

`TESTVISIBLE`

convenience method for a GET Call that only requires a path

#### Signature
```apex
protected HttpResponse get(String path)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| path | String | Http path component of the URL. ie: `/path/to/resource` |

#### Return Type
**HttpResponse**

---

### `get(path, query)`

`TESTVISIBLE`

convenience method for a GET Call that only requires a path 
and query

#### Signature
```apex
protected HttpResponse get(String path, String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar` |

#### Return Type
**HttpResponse**

---

### `del(path)`

`TESTVISIBLE`

convenience method for deleteing a resource based only on 
path

#### Signature
```apex
protected HttpResponse del(String path)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| path | String | Http path component of the URL. ie: `/path/to/resource` |

#### Return Type
**HttpResponse**

---

### `del(path, query)`

`TESTVISIBLE`

convenience method for a Delete Call that only requires a 
path and query

#### Signature
```apex
protected HttpResponse del(String path, String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar` |

#### Return Type
**HttpResponse**

---

### `post(path, body)`

`TESTVISIBLE`

convenience method for a POST Call that only requires a path 
and body

#### Signature
```apex
protected HttpResponse post(String path, String body)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| body | String | JSON string to post |

#### Return Type
**HttpResponse**

---

### `post(path, query, body)`

`TESTVISIBLE`

convenience method for a POST Call that only requires a 
path, query and body

#### Signature
```apex
protected HttpResponse post(String path, String query, String body)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar` |
| body | String | JSON string to post |

#### Return Type
**HttpResponse**

---

### `put(path, body)`

`TESTVISIBLE`

convenience method for a PUT Call that only requires a path 
and body

#### Signature
```apex
protected HttpResponse put(String path, String body)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| body | String | JSON string to post |

#### Return Type
**HttpResponse**

---

### `put(path, query, body)`

`TESTVISIBLE`

convenience method for a PUT Call that only requires a path, 
query and body

#### Signature
```apex
protected HttpResponse put(String path, String query, String body)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar` |
| body | String | JSON string to post |

#### Return Type
**HttpResponse**

---

### `patch(path, body)`

`TESTVISIBLE`

convenience method for a PATCH Call that only requires a 
path, query and body

#### Signature
```apex
protected HttpResponse patch(String path, String body)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| body | String | JSON string to post |

#### Return Type
**HttpResponse**

---

### `patch(path, query, body)`

`TESTVISIBLE`

convenience method for a PATCH Call that only requires a 
path, query and body

#### Signature
```apex
protected HttpResponse patch(String path, String query, String body)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar` |
| body | String | JSON string to post |

#### Return Type
**HttpResponse**

---

### `ensureStringEndsInSlash(resource)`

`TESTVISIBLE`

Ensures that the inputted string ends in a `/` 
makes callouts more robust.

#### Signature
```apex
protected String ensureStringEndsInSlash(String resource)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| resource | String | string to ensure ends in `/` |

#### Return Type
**String**

inputted string with ,[object Object], if it didn&#x27;t already end in one.

---

### `makeApiCall(namedCredential, method, path, query, body, headers)`

`SUPPRESSWARNINGS`

A static wrapper for the main makeApiCall method

#### Signature
```apex
public static HttpResponse makeApiCall(String namedCredential, HttpVerb method, String path, String query, String body, Map<String,String> headers)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| namedCredential | String | The named credential to use |
| method | HttpVerb | HTTPVerb enum value. See Enum above |
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar` |
| body | String | JSON string to post |
| headers | Map&lt;String,String&gt; | Map&lt;String,String&gt; representing outgoing Request 
headers |

#### Return Type
**HttpResponse**

#### Example
```apex
System.Debug(RestClient.makeApiCall('GoogleBooksAPI',
                                     RestClient.HttpVerb.GET,
                                     'volumes',
                                     'q=salesforce',
                                     '',
                                     new Map<String,String>()));
```

---

### `makeApiCall(namedCredential, method, path, query)`

`SUPPRESSWARNINGS`

A static wrapper for the main makeApiCall method 
that assumes default headers.

#### Signature
```apex
public static HttpResponse makeApiCall(String namedCredential, HttpVerb method, String path, String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| namedCredential | String | The named credential to use |
| method | HttpVerb | HTTPVerb enum value. See Enum above |
| path | String | Http path component of the URL. ie: `/path/to/resource` |
| query | String | Query component of the URL ie: after `?foo=bar` |

#### Return Type
**HttpResponse**

#### Example
```apex
System.Debug(RestClient.makeApiCall('GoogleBooksAPI',
                                     RestClient.HttpVerb.GET,
                                     'volumes',
                                     'q=salesforce'));
```

---

### `makeApiCall(namedCredential, method, path)`

A static wrapper for the main makeApiCall method 
where you only need the path

#### Signature
```apex
public static HttpResponse makeApiCall(String namedCredential, HttpVerb method, String path)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| namedCredential | String | The named credential to use |
| method | HttpVerb | HTTPVerb enum value. See Enum above |
| path | String | Http path component of the URL. ie: `/path/to/resource` |

#### Return Type
**HttpResponse**

#### Example
```apex
System.Debug(RestClient.makeApiCall('GoogleBooksAPI',
                                     RestClient.HttpVerb.GET,
                                     'volumes'));
```

## Enums
### HttpVerb Enum

This ENUM lists possible HTTP Verbs. Note: &#x27;Delete&#x27; is an Apex Keyword (DML) 
and as a result, the ENUM value &#x27;DEL&#x27; is used for delete.

#### Values
| Value | Description |
|-------|-------------|
| GET |  |
| POST |  |
| PATCH |  |
| PUT |  |
| HEAD |  |
| DEL |  |