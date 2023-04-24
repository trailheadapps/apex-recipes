---
layout: default
---
# AccountServiceLayer class

Demonstrates what a Service Layer object might look like for teh Account object. Demonstrates the placement of shared code that is specific to the Account Object, and contains code that is called by the AccountTriggerHandler

## Related

[AccountTriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/AccountTriggerHandler.md)

---
## Properties

### `didExecuteMethod` → `String`

---
## Methods
### `changeShippingStreet(List<Account> accounts,System.AccessLevel accessLevel)` → `void`

Changes the account&apos;s Shipping Street field to a hardcoded value. You should do this kind of work in a before trigger, but this is a demo. Note: This method contains a false-positive PMD viloation around not checking FLS/CRUD before doing DML. This is because PMD is unaware of what the CanTheUser call right before it is doing - namely checking CRUD.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accounts` |  List of account objects to change the shipping street on |

#### Example
```java
Account[] accounts = [SELECT Name FROM Account LIMIT 50];
AccountServiceLayer.changeShippingStreet(accounts);
System.debug([SELECT Name, ShippingStreet FROM Account WHERE id in : accounts]);
```

### `incrementCounterInDescription(List<Account> incomingAccounts,Boolean save)` → `List<Account>`

Increments a counter stored in the Description field. Demonstration method of the kind of work a service layer may do.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`incomingAccounts` |  List of Account Objects. |
|`save` |  Boolean determining if DML update is requested. |

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;

#### Example
```java
Account[] accounts = [SELECT Description FROM Account LIMIT 50];
AccountServiceLayer.incrementCounterInDescription(accounts, true);
System.debug([SELECT Name, Description FROM Account WHERE id in : accounts]);
```

### `justWriteALogStatement(String toLog)` → `void`

Method exists to demonstrate what it might look like to call a service layer method from a trigger handler.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`toLog` |  String to Log. |

#### Example
```java
AccountServiceLayer.justWriteALogStatement('Hello World');
```

### `safelySave(List<Account> accounts)` → `void`

Updates a list of accounts if the user has access to update the Account Object. Demonstrates simple usage of Security.stripInacessible(), and DML with a try/catch block.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | s |

#### Example
```java
Account[] accounts = [SELECT Name FROM Account LIMIT 50];
for(Account acct: accounts){
     acct.description = 'safely save example';
}
AccountServiceLayer.safelySave(accounts);
System.debug([SELECT Name, Description FROM Account WHERE id in : accounts]);
```

---
## Inner Classes

### AccountServiceLayer.ASLException class

Internal custom exception class

---
