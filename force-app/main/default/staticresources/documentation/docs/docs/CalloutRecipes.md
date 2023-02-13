---
layout: default
---
# CalloutRecipes class

Demonstrates how to make an opinionated REST callout. This class utilizes the custom RestClient from the Shared Code group.

## Related

[RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient.md)

---
## Constructors
### `CalloutRecipes(String namedCredential)`

Constructor accepting a named credential.
#### Parameters

| Param | Description |
| ----- | ----------- |
|`namedCredential` |  name of the Named Credential to use |

---
## Methods
### `httpCalloutWithUntypedResponse()` → `Map<String, Object>`

Now that we have demonstrated how to callout to an endpoint, lets take a look at what else we can do with the response. When calling out to an external endpoint, the data may not always be in a format that can be directly deserialised into a Salesforce Object. If your callout returns untyped JSON, you can deserialize this into a Map&lt;String, Object&gt; by using a deserializeUntyped method to convert the string.

#### Return

**Type**

Map&lt;String, Object&gt;

**Description**

Map&lt;String, Object&gt;

#### Example
```java
System.debug(CalloutRecipes.httpCalloutWithUntypedResponse());
```

### `httpDeleteCalloutToSecondOrg(Id contactId)` → `Integer`

Demonstrates a DELETE request to a second Salesforce org - A DELETE request is used to delete data from the target endpoint. In this example, we will be deleting a contact from another Salesforce org. We will store the parameters in the urlPath which can then be accessed through the .getParams() method in the org receiving the delete request.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`contactId` |  the Id of the contact that you would like to delete in |

#### Return

**Type**

Integer

**Description**

String

#### Example
```java
Id contactId = [SELECT id FROM Contact LIMIT 1].id;
System.debug(CalloutRecipes.httpDeleteCalloutToSecondOrg(contactId));
```

### `httpGetCalloutToSecondOrg()` → `List<Account>`

Demonstrates a GET request to a second Salesforce org. A Get request is used to retrieve data from a target endpoint, We will be using the performRestCallout method to make the callout. In this example, we will be requesting a list of Accounts from our second org. We will pass the endpoint our named credential, the url path to our integration-service custom REST endpoint, a null body and the GET method. We will then deserialize the JSON into a known object, in this case, a list of Accounts.

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;

#### Example
```java
System.debug(CalloutRecipes.httpGetCalloutToSecondOrg());
```

### `httpPatchCalloutToSecondOrg(List<Account> accountRecords)` → `Integer`

Demonstrates a PATCH request to a second Salesforce org a PATCH request is used to send data to a target endpoint and update already existing data. In this example, we will be sending a list of Account records to a second salesforce org for updating.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accountRecords` |  a list of account records to be updated in the |

#### Return

**Type**

Integer

**Description**

String The status of the callout

#### Example
```java
List<Contact> contacts = [SELECT id, firstName, lastName FROM Contact LIMIT 5];
System.debug(CalloutRecipes.httpPatchCalloutToSecondOrg(contacts));
```

### `httpPostCalloutToSecondOrg(List<Contact> contactRecords)` → `Integer`

Demonstrates a POST request to a second Salesforce org a POST request is used to send data to a target endpoint and insert it. In this example, we will be sending a list of contact records to a second Salesforce org. We will serilaize the list and POST it in body of the callout.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`contactRecords` |  a list of contact records to be inserted in the |

#### Return

**Type**

Integer

**Description**

String

#### Example
```java
List<Contact> contacts = [SELECT id, firstName, lastName FROM Contact LIMIT 5];
System.debug(CalloutRecipes.httpPostCalloutToSecondOrg(contacts));
```

### `httpPutCalloutToSecondOrg(List<Contact> contactRecords)` → `Integer`

Demonstrates a PUT request to a second Salesforce org a PUT request is used to send data to a target endpoint and upsert it. In this example, we will be sending a list of contact records to a second org.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`contactRecords` |  a list of contact records to be upsert in the |

#### Return

**Type**

Integer

**Description**

String

#### Example
```java
List<Contact> contacts = [SELECT id, firstName, lastName FROM Contact LIMIT 5];
System.debug(CalloutRecipes.httpPutCalloutToSecondOrg(contacts));
```

### `insertAccountAndContactsFromUntypedResponse(String untypedResponse)` → `void`

As seen in the httpCalloutWithUntypedResponse method, we don&apos;t always get a perfect datastructure back from our callout. In this case, we have received and account and it&apos;s contacts that need to be inserted into Salesforce. Check out the Test class for an example of an untyped data structure.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`untypedResponse` |  the untyped JSON response that we received from |

#### Example
```java
CalloutRecipes.insertAccountAndContactsFromUntypedResponse(CalloutRecipes_Tests.goodUntypedJSON)
```

### `rawCallout()` → `String`

Demonstrates how to make a raw HTTP request. This method demonstrates how to use the Http, HttpRequest and HttpResponse objects to construct a single get reuqest. The other methods in this class demonstrate the use of an intelligent abstraction layer - RestClient.cls - to make sending Http Requests easier, easier to test, and less error prone.

#### Return

**Type**

String

**Description**

String

#### Example
```java
System.debug(CalloutRecipes.rawCallout());
```

---
## Inner Classes

### CalloutRecipes.CalloutRecipesException class

Internal custom exception class

---
