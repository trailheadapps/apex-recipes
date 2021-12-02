---
layout: default
---
# InvocableMethodRecipes class

Demonstrates how to create Apex classes and methods that can be invoked from Visual Flows and Process Builder Processes This also demonstrates custom input and output inner classes allowing you to create code that accepts input from a flow/process and returns data to the flow

---
## Methods
### `findRelatedContacts(List<ContactSearchRequest> inputParams)` → `List<ContactSearchResult>`

Invocable method accepts a list of incoming ContactSearchRequest objects. The first incoming request is extracted, and the incoming records&apos; Id is used to determine the type of object. In this case, the code handles either an Account or a Task. A query is crafted specific to the incoming object, and it&apos;s type and the results of the query are converted to a Result object and returned.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`inputParams` |  A list of ContactSearchRequest objects |

#### Return

**Type**

List&lt;ContactSearchResult&gt;

**Description**

List&lt;ContactSearchResult&gt;

#### Example
```java
From Apex:
Account account = new Account(name='awesome examples ltd.');
insert account;
Contact contact = new Contact(accountId = account.id, firstName='Kevin', lastName='Awesome');
insert contact;
InvocableMethodRecipes.ContactSearchRequest csr = new InvocableMethodRecipes.ContactSearchRequest();
csr.inputs = new List<sObject>{account};
InvocableMethodRecipes.ContactSearchResult results = InvocableMethodRecipes.findRelatedContacts(csr);
System.debug(results.output);
```

---
## Inner Classes

### InvocableMethodRecipes.ContactSearchRequest class

inner class that represents an incoming search request

---
#### Properties

##### `inputs` → `List<SObject>`

---
### InvocableMethodRecipes.ContactSearchResult class

Represents the output from the invocable method

---
#### Constructors
##### `ContactSearchResult(SObject toOutput)`

Constructor building output object from SObject
###### Parameters

| Param | Description |
| ----- | ----------- |
|`toOutput` |   Object to output |

---
#### Properties

##### `output` → `SObject`

---
### InvocableMethodRecipes.InvocableMethodRecipesException class

Internal custom exception class

---
