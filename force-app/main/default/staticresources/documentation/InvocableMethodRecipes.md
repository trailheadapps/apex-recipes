# InvocableMethodRecipes Class

Demonstrates how to create Apex classes and methods that 
can be invoked from Visual Flows and Process Builder Processes 
This also demonstrates custom input and output inner classes allowing 
you to create code that accepts input from a flow/process and 
returns data to the flow

**Group** Invocable Recipes

## Methods
### `findRelatedContacts(inputParams)`

`INVOCABLEMETHOD`

Invocable method accepts a list of incoming 
ContactSearchRequest objects. The first incoming request is extracted, 
and the incoming records&#x27; Id is used to determine the type of object. 
In this case, the code handles either an Account or a Task. A query is 
crafted specific to the incoming object, and it&#x27;s type and the results 
of the query are converted to a Result object and returned.

#### Signature
```apex
public static List<ContactSearchResult> findRelatedContacts(List<ContactSearchRequest> inputParams)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| inputParams | List&lt;ContactSearchRequest&gt; | A list of ContactSearchRequest objects |

#### Return Type
**List&lt;ContactSearchResult&gt;**

#### Example
From Apex: 
```apex
Account account = new Account(name='awesome examples ltd.');
insert account;
Contact contact = new Contact(accountId = account.id, firstName='Kevin', lastName='Awesome');
insert contact;
InvocableMethodRecipes.ContactSearchRequest csr = new InvocableMethodRecipes.ContactSearchRequest();
csr.inputs = new List<sObject>{account};
InvocableMethodRecipes.ContactSearchResult results = InvocableMethodRecipes.findRelatedContacts(csr);
System.debug(results.output);
```

## Classes
### InvocableMethodRecipesException Class

Internal custom exception class

### ContactSearchRequest Class

inner class that represents an incoming search request

#### Fields
##### `inputs`

`INVOCABLEVARIABLE`

###### Signature
```apex
public inputs
```

###### Type
List&lt;SObject&gt;

### ContactSearchResult Class

Represents the output from the invocable method

#### Fields
##### `output`

`INVOCABLEVARIABLE`

###### Signature
```apex
public output
```

###### Type
SObject

#### Constructors
##### `ContactSearchResult(toOutput)`

Constructor building output object from SObject

###### Signature
```apex
public ContactSearchResult(SObject toOutput)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| toOutput | SObject | Object to output |