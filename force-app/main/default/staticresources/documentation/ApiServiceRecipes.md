# ApiServiceRecipes Class

This recipe extends the custom RestClient class and 
represents a specific REST API service we need to interact with - in 
this case the Google Books API. This class is responsible 
for serializing and deserializing the Data Transfer Objects (Model Objects) 
necessary for input and output from this org to the third party system and 
back. 
 
More on the Google Books API here: https://developers.google.com/books/docs/v1/reference/volumes

**Group** Integration Recipes

**See** [RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient)

**See** [ApiServiceRecipesDataModel](ApiServiceRecipesDataModel.md)

**Inheritance**

[RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient)

## Fields
### `DEFAULT_NAMED_CREDENTIAL`

`TESTVISIBLE`

#### Signature
```apex
private static final DEFAULT_NAMED_CREDENTIAL
```

#### Type
String

## Properties
### `namedCredentialName`

*Inherited*

`TESTVISIBLE`

The name of the Named Credential to use

#### Signature
```apex
protected namedCredentialName
```

#### Type
String

## Constructors
### `ApiServiceRecipes()`

default constructor. Sets the inherited named credential 
to the DEFAULTNAMEDCREDENTIAL constant above. 
Setting the namedCredentialName binds all the methods in this class 
to the specific namedCredential URL and auth.

#### Signature
```apex
public ApiServiceRecipes()
```

## Methods
### `getCurrentData()`

Encapsulates a specific callout to the Named Credential 
URL that returns JSON into an method that transforms the raw JSON 
into an Apex Object.

#### Signature
```apex
public List<ApiServiceRecipesDataModel> getCurrentData()
```

#### Return Type
**List&lt;ApiServiceRecipesDataModel&gt;**

#### Example
```apex
ApiServiceRecipes asr = new ApiServiceRecipes();
System.debug(asr.getCurrentData());
```

---

### `makeApiCall(method, path, query, body, headers)`

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

*Inherited*

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

## Classes
### ApiException Class

Internal custom exception used by this class for errors