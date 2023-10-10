# AccountServiceLayer

Demonstrates what a Service Layer object might look like
for teh Account object. Demonstrates the placement of shared code that
is specific to the Account Object, and contains code that is called
by the AccountTriggerHandler


**Group** Shared Code


**See** [AccountTriggerHandler](https://github.com/trailheadapps/apex-recipes/wiki/AccountTriggerHandler)

## Fields

### `private didExecuteMethod` → `String`

`TESTVISIBLE` 

---
## Methods
### `public static void justWriteALogStatement(String toLog)`

Method exists to demonstrate what it might look like to  call a service layer method from a trigger handler.

#### Parameters

|Param|Description|
|---|---|
|`toLog`|String to Log.|

#### Example
```apex
AccountServiceLayer.justWriteALogStatement('Hello World');
```


### `public static void changeShippingStreet(List<Account> accounts, System accessLevel)`

`SUPPRESSWARNINGS`

Changes the account's Shipping Street field to a hardcoded value. You should do this kind of work in a before trigger, but this is a demo. Note: This method contains a false-positive PMD viloation around not checking FLS/CRUD before doing DML. This is because PMD is unaware of what the CanTheUser call right before it is doing - namely checking CRUD.

#### Parameters

|Param|Description|
|---|---|
|`accounts`|List of account objects to change the shipping street on|

#### Example
```apex
Account[] accounts = [SELECT Name FROM Account LIMIT 50];
AccountServiceLayer.changeShippingStreet(accounts);
System.debug([SELECT Name, ShippingStreet FROM Account WHERE Id in : accounts]);
```


### `public static List<Account> incrementCounterInDescription(List<Account> incomingAccounts, Boolean save)`

Increments a counter stored in the Description field.  Demonstration method of the kind of work a service layer may do.

#### Parameters

|Param|Description|
|---|---|
|`incomingAccounts`|List of Account Objects.|
|`save`|Boolean determining if DML update is requested.|

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List<Account>|

#### Example
```apex
Account[] accounts = [SELECT Description FROM Account LIMIT 50];
AccountServiceLayer.incrementCounterInDescription(accounts, true);
System.debug([SELECT Name, Description FROM Account WHERE Id in : accounts]);
```


### `private static void safelySave(List<Account> accounts)`

`TESTVISIBLE`

Updates a list of accounts if the user has access to update  the Account Object. Demonstrates simple usage of  Security.stripInacessible(), and DML with a try/catch block.

#### Parameters

|Param|Description|
|---|---|
|`accounts`||

#### Example
```apex
Account[] accounts = [SELECT Name FROM Account LIMIT 50];
for(Account acct: accounts){
     acct.description = 'safely save example';
}
AccountServiceLayer.safelySave(accounts);
System.debug([SELECT Name, Description FROM Account WHERE Id in : accounts]);
```


---
## Classes
### ASLException

Internal custom exception class


**Inheritance**

ASLException


---
