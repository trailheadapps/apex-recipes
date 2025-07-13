# StripInaccessibleRecipes Class

Demonstrates the use of Security.stripInaccessible() 
and the SObjectAccessDecision object. This helps developers write 
secure code that prevents users from seeing and accessing fields 
they cannot access.

**Group** Security Recipes

## Methods
### `stripInaccessibleFromQuery()`

Demonstrates how to use stripInaccessible to remove fields 
and objects from a queries results.

#### Signature
```apex
public static List<Campaign> stripInaccessibleFromQuery()
```

#### Return Type
**List&lt;Campaign&gt;**

#### Example
```apex
System.debug(StripInaccessibleRecipes.stripInaccessibleFromQuery());
```

---

### `stripInaccessibleFromSubquery()`

Demonstrates how to use stripInaccessible to remove fields 
and objects not only from the primary object in this case account but 
also from related child objects that are queried in this case contacts.

#### Signature
```apex
public static List<Account> stripInaccessibleFromSubquery()
```

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
System.debug(StripInaccessibleRecipes.stripInaccessibleFromSubquery());
```

---

### `stripInaccessibleBeforeDML(contacts)`

Demonstrates how to use stripInacessible in a pre-DML 
context. This prevents a user from persisting changes to fields and 
objects the do not have access to.

#### Signature
```apex
public static void stripInaccessibleBeforeDML(List<Contact> contacts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| contacts | List&lt;Contact&gt; | A list of Contacts |

#### Return Type
**void**

#### Example
```apex
Contact[] contacts = new Contact[]();
for(Integer i = 0, i < 5; i++){
     contacts.add(new Contact(lastName='example last name' + i));
}
stripInaccessibleRecipes.stripInaccessibleBeforeDML(contacts);
System.debug([SELECT Id, lastName FROM Contact WHERE lastName like 'example last name%']);
```

---

### `stripInaccessibleFromUntrustedData(jsonText)`

Demonstrates how to use stripInaccessible to sanitize 
untrusted data prior to DML. In this case, the code demonstrates how to 
deserialize a JSON string, and strip fields / objects that the user has 
no access to. This pattern is especially useful for `@AuraEnabled` methods!

#### Signature
```apex
public static void stripInaccessibleFromUntrustedData(String jsonText)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| jsonText | String | jsonText description |

#### Return Type
**void**

#### Example
```apex
Account acct = new Account(name='Awesome Strip Inaccessible example');
insert acct;
acct.ShippingStreet = '123 To Be Updated st.';
stripInaccessibleRecipes.stripInaccessibleFromUntrustedData(JSON.serialize(acct));
System.debug([SELECT Name, ShippingStreet FROM Account WHERE Id = :acct.id]);
```

## Classes
### StripInaccessibleRecipesException Class

Internal custom exception used by this class.