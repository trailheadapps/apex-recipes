# InvocableMethodRecipes

Demonstrates how to create Apex classes and methods that
can be invoked from Visual Flows and Process Builder Processes
This also demonstrates custom input and output inner classes allowing
you to create code that accepts input from a flow/process and
returns data to the flow


**Group** Invocable Recipes

## Methods
### `public static List<ContactSearchResult> findRelatedContacts(List<ContactSearchRequest> inputParams)`

`INVOCABLEMETHOD`

Invocable method accepts a list of incoming ContactSearchRequest objects. The first incoming request is extracted, and the incoming records' Id is used to determine the type of object. In this case, the code handles either an Account or a Task. A query is crafted specific to the incoming object, and it's type and the results of the query are converted to a Result object and returned.

#### Parameters

|Param|Description|
|---|---|
|`inputParams`|A list of ContactSearchRequest objects|

#### Returns

|Type|Description|
|---|---|
|`List<ContactSearchResult>`|List<ContactSearchResult>|

#### Example
```apex
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
## Classes
### ContactSearchRequest

inner class that represents an incoming search request

#### Fields

##### `public inputs` → `List&lt;SObject&gt;`

`INVOCABLEVARIABLE` 

---

### ContactSearchResult

Represents the output from the invocable method

#### Constructors
##### `public ContactSearchResult(SObject toOutput)`

Constructor building output object from SObject

###### Parameters

|Param|Description|
|---|---|
|`toOutput`|Object to output|

---
#### Fields

##### `public output` → `SObject`

`INVOCABLEVARIABLE` 

---

### InvocableMethodRecipesException

Internal custom exception class


**Inheritance**

InvocableMethodRecipesException


---
