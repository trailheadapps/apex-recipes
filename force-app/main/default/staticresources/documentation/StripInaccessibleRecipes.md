# StripInaccessibleRecipes

Demonstrates the use of Security.stripInaccessible()
and the SObjectAccessDecision object. This helps developers write
secure code that prevents users from seeing and accessing fields
they cannot access.


**Group** Security Recipes

## Methods
### `public static List<Campaign> stripInaccessibleFromQuery()`

Demonstrates how to use stripInaccessible to remove fields and objects from a queries results.

#### Returns

|Type|Description|
|---|---|
|`List<Campaign>`|List<Campaign>|

#### Example
```apex
System.debug(StripInaccessibleRecipes.stripInaccessibleFromQuery());
```


### `public static List<Account> stripInaccessibleFromSubquery()`

Demonstrates how to use stripInaccessible to remove fields and objects not only from the primary object in this case account but also from related child objects that are queried in this case contacts.

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List<Account>|

#### Example
```apex
System.debug(StripInaccessibleRecipes.stripInaccessibleFromSubquery());
```


### `public static void stripInaccessibleBeforeDML(List<Contact> contacts)`

Demonstrates how to use stripInacessible in a pre-DML context. This prevents a user from persisting changes to fields and objects the do not have access to.

#### Parameters

|Param|Description|
|---|---|
|`contacts`|A list of Contacts|

#### Example
```apex
Contact[] contacts = new Contact[]();
for(Integer i = 0, i < 5; i++){
     contacts.add(new Contact(lastName='example last name' + i));
}
stripInaccessibleRecipes.stripInaccessibleBeforeDML(contacts);
System.debug([SELECT Id, lastName FROM Contact WHERE lastName like 'example last name%']);
```


### `public static void stripInaccessibleFromUntrustedData(String jsonText)`

Demonstrates how to use stripInaccessible to sanitize untrusted data prior to DML. In this case, the code demonstrates how to deserialize a JSON string, and strip fields / objects that the user has no access to. This pattern is especially useful for `@auraenabled` methods!

#### Parameters

|Param|Description|
|---|---|
|`jsonText`|jsonText description|

#### Example
```apex
Account acct = new Account(name='Awesome Strip Inaccessible example');
insert acct;
acct.ShippingStreet = '123 To Be Updated st.';
stripInaccessibleRecipes.stripInaccessibleFromUntrustedData(JSON.serialize(acct));
System.debug([SELECT Name, ShippingStreet FROM Account WHERE Id = :acct.id]);
```


---
## Classes
### StripInaccessibleRecipesException

Internal custom exception used by this class.


**Inheritance**

StripInaccessibleRecipesException


---
