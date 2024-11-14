# CalloutRecipes Class

Demonstrates how to make an opinionated REST callout. 
This class utilizes the custom RestClient from the Shared Code group.

**Group** Integration Recipes

**See** [RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient)

**Inheritance**

[RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient)

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
### `CalloutRecipes(namedCredential)`

Constructor accepting a named credential.

#### Signature
```apex
public CalloutRecipes(String namedCredential)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| namedCredential | String | name of the Named Credential to use |

## Methods
### `rawCallout()`

Demonstrates how to make a raw HTTP request. This method 
demonstrates how to use the Http, HttpRequest and HttpResponse objects to 
construct a single get request. The other methods in this class 
demonstrate the use of an intelligent abstraction layer - `RestClient.cls` 
- to make sending Http Requests easier, easier to test, and less error 
prone.

#### Signature
```apex
public static String rawCallout()
```

#### Return Type
**String**

Response body as a string

#### Example
```apex
System.debug(CalloutRecipes.rawCallout());
```

---

### `httpGetCalloutToSecondOrg()`

Demonstrates a GET request to a second Salesforce org. A Get 
request is used to retrieve data from a target endpoint, We will be using 
the `performRestCallout` method to make the callout. In this example, we 
will be requesting a list of Accounts from our second org. We will pass 
the endpoint our named credential, the url path to our integration-service 
custom REST endpoint, a null body and the GET method. We will then 
deserialize the JSON into a known object, in this case, a list of 
Accounts.

#### Signature
```apex
public List<Account> httpGetCalloutToSecondOrg()
```

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
System.debug(CalloutRecipes.httpGetCalloutToSecondOrg());
```

---

### `httpDeleteCalloutToSecondOrg(contactId)`

Demonstrates a DELETE request to a second Salesforce org - A 
DELETE request is used to delete data from the target endpoint. 
In this example, we will be deleting a contact from another Salesforce 
org. We will store the parameters in the urlPath which can then be 
accessed through the .getParams() method in the org receiving the delete 
request.

#### Signature
```apex
public Integer httpDeleteCalloutToSecondOrg(Id contactId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| contactId | Id | the Id of the contact that you would like to delete in 
the second org. |

#### Return Type
**Integer**

#### Example
```apex
Id contactId = [SELECT Id FROM Contact LIMIT 1].id;
System.debug(CalloutRecipes.httpDeleteCalloutToSecondOrg(contactId));
```

---

### `httpPostCalloutToSecondOrg(contactRecords)`

Demonstrates a POST request to a second Salesforce org a 
POST request is used to send data to a target endpoint and insert it. 
In this example, we will be sending a list of contact records to a second 
Salesforce org. 
We will serilaize the list and POST it in body of the callout.

#### Signature
```apex
public Integer httpPostCalloutToSecondOrg(List<Contact> contactRecords)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| contactRecords | List&lt;Contact&gt; | a list of contact records to be inserted in the 
second salesforce org |

#### Return Type
**Integer**

#### Example
```apex
List<Contact> contacts = [SELECT id, firstName, lastName FROM Contact LIMIT 5];
System.debug(CalloutRecipes.httpPostCalloutToSecondOrg(contacts));
```

---

### `httpPutCalloutToSecondOrg(contactRecords)`

Demonstrates a PUT request to a second Salesforce org a PUT 
request is used to send data to a target endpoint and upsert it. In this 
example, we will be sending a list of contact records to a second org.

#### Signature
```apex
public Integer httpPutCalloutToSecondOrg(List<Contact> contactRecords)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| contactRecords | List&lt;Contact&gt; | a list of contact records to be upsert in the 
second salesforce org |

#### Return Type
**Integer**

#### Example
```apex
List<Contact> contacts = [SELECT id, firstName, lastName FROM Contact LIMIT 5];
System.debug(CalloutRecipes.httpPutCalloutToSecondOrg(contacts));
```

---

### `httpPatchCalloutToSecondOrg(accountRecords)`

Demonstrates a PATCH request to a second Salesforce org a 
PATCH request is used to send data to a target endpoint and update 
already existing data. In this example, we will be sending a list of 
Account records to a second salesforce org for updating.

#### Signature
```apex
public Integer httpPatchCalloutToSecondOrg(List<Account> accountRecords)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accountRecords | List&lt;Account&gt; | a list of account records to be updated in the 
second salesforce org |

#### Return Type
**Integer**

The status of the callout

#### Example
```apex
List<Contact> contacts = [SELECT id, firstName, lastName FROM Contact LIMIT 5];
System.debug(CalloutRecipes.httpPatchCalloutToSecondOrg(contacts));
```

---

### `httpCalloutWithUntypedResponse()`

Now that we have demonstrated how to callout to an endpoint, 
lets take a look at what else we can do with the response. When calling 
out to an external endpoint, the data may not always be in a format that 
can be directly deserialised into a Salesforce Object. If your callout 
returns untyped JSON, you can deserialize this into a Map&lt;String, Object&gt; 
by using a deserializeUntyped method to convert the string.

#### Signature
```apex
public Map<String,Object> httpCalloutWithUntypedResponse()
```

#### Return Type
**Map&lt;String,Object&gt;**

#### Example
```apex
System.debug(CalloutRecipes.httpCalloutWithUntypedResponse());
```

---

### `insertAccountAndContactsFromUntypedResponse(untypedResponse)`

As seen in the httpCalloutWithUntypedResponse method, we 
don&#x27;t always get a perfect datastructure back from our callout. In this 
case, we have received and account and it&#x27;s contacts that need to be 
inserted into Salesforce. Check out the Test class for an example of an 
untyped data structure.

#### Signature
```apex
public void insertAccountAndContactsFromUntypedResponse(String untypedResponse)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| untypedResponse | String | the untyped JSON response that we received from 
our previous callout |

#### Return Type
**void**

#### Example
```apex
CalloutRecipes.insertAccountAndContactsFromUntypedResponse(CalloutRecipes_Tests.goodUntypedJSON)
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
### CalloutRecipesException Class

Internal custom exception class