# AccountServiceLayer Class

Demonstrates what a Service Layer object might look like 
for teh Account object. Demonstrates the placement of shared code that 
is specific to the Account Object, and contains code that is called 
by the AccountTriggerHandler

**Group** Shared Code

**See** [AccountTriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/AccountTriggerHandler)

## Fields
### `didExecuteMethod`

`TESTVISIBLE`

#### Signature
```apex
private static didExecuteMethod
```

#### Type
String

## Methods
### `justWriteALogStatement(toLog)`

Method exists to demonstrate what it might look like to 
call a service layer method from a trigger handler.

#### Signature
```apex
public static void justWriteALogStatement(String toLog)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| toLog | String | String to Log. |

#### Return Type
**void**

#### Example
```apex
AccountServiceLayer.justWriteALogStatement('Hello World');
```

---

### `changeShippingStreet(accounts, accessLevel)`

`SUPPRESSWARNINGS`

Changes the account&#x27;s Shipping Street field to a hardcoded 
value. You should do this kind of work in a before trigger, but this is a 
demo. 
 
Note: This method contains a false-positive PMD viloation around not 
checking FLS/CRUD before doing DML. This is because PMD is unaware of 
what the CanTheUser call right before it is doing - namely checking CRUD.

#### Signature
```apex
public static void changeShippingStreet(List<Account> accounts, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accounts | List&lt;Account&gt; | List of account objects to change the shipping street on |
| accessLevel | System.AccessLevel |  |

#### Return Type
**void**

#### Example
```apex
Account[] accounts = [SELECT Name FROM Account LIMIT 50];
AccountServiceLayer.changeShippingStreet(accounts);
System.debug([SELECT Name, ShippingStreet FROM Account WHERE Id in : accounts]);
```

---

### `incrementCounterInDescription(incomingAccounts, save)`

Increments a counter stored in the Description field. 
Demonstration method of the kind of work a service layer may do.

#### Signature
```apex
public static List<Account> incrementCounterInDescription(List<Account> incomingAccounts, Boolean save)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| incomingAccounts | List&lt;Account&gt; | List of Account Objects. |
| save | Boolean | Boolean determining if DML update is requested. |

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
Account[] accounts = [SELECT Description FROM Account LIMIT 50];
AccountServiceLayer.incrementCounterInDescription(accounts, true);
System.debug([SELECT Name, Description FROM Account WHERE Id in : accounts]);
```

---

### `safelySave(accounts)`

`TESTVISIBLE`

Updates a list of accounts if the user has access to update 
the Account Object. Demonstrates simple usage of 
 `Security.stripInacessible()` , and DML with a try/catch block.

#### Signature
```apex
private static void safelySave(List<Account> accounts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accounts | List&lt;Account&gt; |  |

#### Return Type
**void**

#### Example
```apex
Account[] accounts = [SELECT Name FROM Account LIMIT 50];
for(Account acct: accounts){
     acct.description = 'safely save example';
}
AccountServiceLayer.safelySave(accounts);
System.debug([SELECT Name, Description FROM Account WHERE Id in : accounts]);
```

## Classes
### ASLException Class

Internal custom exception class