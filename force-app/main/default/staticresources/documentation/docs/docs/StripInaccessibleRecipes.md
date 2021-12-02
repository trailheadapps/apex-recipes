---
layout: default
---
# StripInaccessibleRecipes class

Demonstrates the use of Security.stripInaccessible() and the SObjectAccessDecision object. This helps developers write secure code that prevents users from seeing and accessing fields they cannot access.

---
## Methods
### `stripInaccessibleBeforeDML(List<Contact> contacts)` → `void`

Demonstrates how to use stripInacessible in a pre-DML context. This prevents a user from persisting changes to fields and objects the do not have access to.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`contacts` |  A list of Contacts |

#### Example
```java
Contact[] contacts = new Contact[]();
for(Integer i = 0, i < 5; i++){
     contacts.add(new Contact(lastName='example last name' + i));
}
stripInaccessibleRecipes.stripInaccessibleBeforeDML(contacts);
System.debug([SELECT Id, lastName FROM Contact WHERE lastName like 'example last name%']);
```

### `stripInaccessibleFromQuery()` → `List<Campaign>`

Demonstrates how to use stripInaccessible to remove fields and objects from a queries results.

#### Return

**Type**

List&lt;Campaign&gt;

**Description**

List&lt;Campaign&gt;

#### Example
```java
System.debug(StripInaccessibleRecipes.stripInaccessibleFromQuery());
```

### `stripInaccessibleFromSubquery()` → `List<Account>`

Demonstrates how to use stripInaccessible to remove fields and objects not only from the primary object in this case account but also from related child objects that are queried in this case contacts.

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;

#### Example
```java
System.debug(StripInaccessibleRecipes.stripInaccessibleFromSubquery());
```

### `stripInaccessibleFromUntrustedData(String jsonText)` → `void`

Demonstrates how to use stripInaccessible to sanitize untrusted data prior to DML. In this case, the code demonstrates how to deserialize a JSON string, and strip fields / objects that the user has no access to. This pattern is especially useful for @auraenabled methods!

#### Parameters

| Param | Description |
| ----- | ----------- |
|`jsonText` |  jsonText description |

#### Example
```java
Account acct = new Account(name='Awesome Strip Inaccessible example');
insert acct;
acct.ShippingStreet = '123 To Be Updated st.';
stripInaccessibleRecipes.stripInaccessibleFromUntrustedData(JSON.serialize(acct));
System.debug([SELECT Name, ShippingStreet FROM Account WHERE Id = :acct.id]);
```

---
## Inner Classes

### StripInaccessibleRecipes.StripInaccessibleRecipesException class

Internal custom exception used by this class.

---
