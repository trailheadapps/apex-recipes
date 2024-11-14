# IterableApiClient Class

Demonstrates an interable REST API client that loads paginated records (strings) thanks to an iterator

**Inheritance**

[RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient)

**Implements**

Iterable&lt;RecordPage&gt;

## Fields
### `RESPONSE_PAGE_SIZE`

#### Signature
```apex
private static final RESPONSE_PAGE_SIZE
```

#### Type
Integer

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
### `IterableApiClient(namedCredential)`

Constructor accepting a named credential.

#### Signature
```apex
public IterableApiClient(String namedCredential)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| namedCredential | String | name of the Named Credential to use |

## Methods
### `iterator()`

Returns an iterator on RecordPage 
(as required by the Iterable interface)

#### Signature
```apex
public Iterator<RecordPage> iterator()
```

#### Return Type
**Iterator&lt;RecordPage&gt;**

---

### `getRecordPage(pageIndex)`

Internal method that issues a REST request to read a record page

#### Signature
```apex
private RecordPage getRecordPage(Integer pageIndex)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| pageIndex | Integer |  |

#### Return Type
**RecordPage**

A page with a list of records

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
### IterableApiException Class

Public custom exception class

### RecordPageIterator Class

Custom Iterator used to navigate IterableApiClient responses as RecordPage. 
The iterator keeps track on the iteration state with currentPageIndex and totalRecordCount. 
It uses IterableApiClient to perform REST requests to load the record pages.

**Implements**

Iterator&lt;RecordPage&gt;

#### Fields
##### `client`

###### Signature
```apex
private client
```

###### Type
[IterableApiClient](IterableApiClient.md)

---

##### `currentPageIndex`

###### Signature
```apex
private currentPageIndex
```

###### Type
Integer

---

##### `totalRecordCount`

###### Signature
```apex
private totalRecordCount
```

###### Type
Integer

#### Constructors
##### `RecordPageIterator(client)`

###### Signature
```apex
private RecordPageIterator(IterableApiClient client)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| client | [IterableApiClient](IterableApiClient.md) |  |

#### Methods
##### `hasNext()`

###### Signature
```apex
public Boolean hasNext()
```

###### Return Type
**Boolean**

---

##### `next()`

###### Signature
```apex
public RecordPage next()
```

###### Return Type
**RecordPage**

### RecordPage Class

Public class used for JSON deserialization of record page response

#### Fields
##### `records`

###### Signature
```apex
private records
```

###### Type
List&lt;String&gt;

---

##### `totalRecordCount`

###### Signature
```apex
private totalRecordCount
```

###### Type
Integer

#### Methods
##### `getRecords()`

###### Signature
```apex
public List<String> getRecords()
```

###### Return Type
**List&lt;String&gt;**