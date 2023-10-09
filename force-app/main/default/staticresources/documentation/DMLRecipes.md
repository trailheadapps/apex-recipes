# DMLRecipes

Demonstrates various ways of making Data Manipulation Language
(DML) calls. Note that this class demonstrates both Database.* methods as
well as DML Keywords.


**Group** Data Recipes

## Methods
### `public static void insertAccountViaInsertKeywordInSystemMode(String name)`

Demonstrates how to use the insert keyword to persist a net-new record to the database in system mode

#### Parameters

|Param|Description|
|---|---|
|`name`|name passed through to the name of the created account in salesforce|

#### Example
```apex
DMLRecipes.insertAccountViaInsertKeywordInSystemMode('Hello');
```


### `public static void insertAccountViaInsertKeywordInUserMode(String name)`

Demonstrates how to use the insert keyword to persist a net-new record to the database in user mode

#### Parameters

|Param|Description|
|---|---|
|`name`|name passed through to the name of the created account|

#### Example
```apex
DMLRecipes.insertAccountViaInsertKeywordInUserMode('Hello');
```


### `public static void insertAccountsViaDatabaseMethod(String name, Boolean allOrNothing, System accessLevel)`

Demonstrates how to use the Database.insert() method to persist a net-new record to the database.

#### Parameters

|Param|Description|
|---|---|
|`name`|name Passed through to the account created|
|`allOrNothing`|allOrNothing determines whether or not all accounts to be inserted must insert successfully|

#### Example
```apex
DMLRecipes.insertAccountsViaDatabaseMethod('Hello', false, AccessLevel.USER_MODE);
```


### `public static Account upsertAccountViaUpsertKeywordInSystemMode(Account acct)`

Demonstrates the use of the upsert keyword to either insert or update a record in system mode

#### Parameters

|Param|Description|
|---|---|
|`acct`|account to upsert|

#### Returns

|Type|Description|
|---|---|
|Account|Account|

#### Example
```apex
DMLRecipes.upsertAccountViaUpsertKeywordInSystemMode(new Account(name='Hello World'));
```


### `public static Account upsertAccountViaUpsertKeywordInUserMode(Account acct)`

Demonstrates the use of the upsert keyword to either insert or update a record in user mode

#### Parameters

|Param|Description|
|---|---|
|`acct`|account to upsert|

#### Returns

|Type|Description|
|---|---|
|Account|Account|

#### Example
```apex
DMLRecipes.upsertAccountViaUpsertKeywordInUserMode(new Account(name='Hello World'));
```


### `public static Database upsertAccountViaDatabaseMethod(Account acct, Boolean allOrNothing, System accessLevel)`

Upserts an account with a potential of all or nothing, using the Database.upsert method

#### Parameters

|Param|Description|
|---|---|
|`acct`|The account object to upsert|
|`allOrNothing`|all or nothing flag|

#### Returns

|Type|Description|
|---|---|
|Database|UpsertResult|

#### Example
```apex
DMLRecipes.upsertAccountViaDatabaseMethod(
           new Account(name='Hello World'), false, AccessLevel.USER_MODE);
```


### `public static List updateAcccountViaKeywordInSystemMode(List<Account> accts)`

Demonstrates how to Update a list of accounts via the Update DML keyword in System Mode

#### Parameters

|Param|Description|
|---|---|
|`accts`|List of accounts to update|

#### Returns

|Type|Description|
|---|---|
|List<Account>|List<Account>|

#### Example
```apex
Account acct = new Account(name='Hello World');
insert acct;
DMLRecipes.updateAcccountViaKeywordInSystemMode(acct);
```


### `public static List updateAcccountViaKeywordInUserMode(List<Account> accts)`

Demonstrates how to Update a list of accounts via the `update` DML keyword

#### Parameters

|Param|Description|
|---|---|
|`accts`|List of accounts to update|

#### Returns

|Type|Description|
|---|---|
|List<Account>|List of updated records|

#### Example
```apex
Account acct = new Account(name='Hello World');
insert acct;
DMLRecipes.updateAcccountViaKeyword(acct);
```


### `public static List updateAccountViaDatabaseMethod(List<Account> accts, System accessLevel)`

Demonstrates how to update a list of accounts via the `Database.update()` method

#### Parameters

|Param|Description|
|---|---|
|`accts`|list of accounts to update|

#### Returns

|Type|Description|
|---|---|
|List<Account>|List of updated records|

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
List<Account> results = DMLRecipes.updateAccountViaDatabaseMethod(accounts, AccessLevel.USER_MODE);
System.debug(results);
```


### `public static Void deleteAccountViaKeywordInSystemMode(List<Account> accts)`

Deletes a list of accounts via the `delete` DML keyword

#### Parameters

|Param|Description|
|---|---|
|`accts`|list of accounts to delete in system mode|

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
DMLRecipes.deleteAccountViaKeywordInSystemMode(accounts);
```


### `public static Void deleteAccountViaKeywordInUserMode(List<Account> accts)`

Deletes a list of accounts via the `delete` DML keyword

#### Parameters

|Param|Description|
|---|---|
|`accts`|list of accounts to delete in user mode|

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
DMLRecipes.deleteAccountViaKeywordInUserMode(accounts);
```


### `public static Void deleteAccountViaDatabaseMethod(List<Account> accts, System accessLevel)`

Deletes a list of accounts via the `Database.delete` method

#### Parameters

|Param|Description|
|---|---|
|`accts`|List of Accounts to delete|

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts in user mode;
DMLRecipes.deleteAccountViaDatabaseMethod(accounts, AccessLevel.USER_MODE);
```


### `public static List undeleteAccountViaKeywordInSystemMode(List<Account> accts)`

Undeletes a list of accounts via the `undelete` DML keyword

#### Parameters

|Param|Description|
|---|---|
|`accts`|List of accounts to undelete in user mode|

#### Returns

|Type|Description|
|---|---|
|List<Account>|list of undeleted accounts|

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
delete accounts;
List<Account> results = DMLRecipes.undeleteAccountViaKeywordInSystemMode(accounts);
System.debug(results);
```


### `public static List undeleteAccountViaKeywordInUserMode(List<Account> accts)`

Undeletes a list of accounts via the `undelete` DML keyword

#### Parameters

|Param|Description|
|---|---|
|`accts`|List of accounts to undelete in user mode|

#### Returns

|Type|Description|
|---|---|
|List<Account>|list of undeleted accounts|

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
delete accounts;
List<Account> results = DMLRecipes.undeleteAccountViaKeywordInUserMode(accounts);
System.debug(results);
```


### `public static List undeleteAccountViaDatabaseMethod(List<Account> accts, System accessLevel)`

undeletes a list of accounts via the `Database.undelete` method.

#### Parameters

|Param|Description|
|---|---|
|`accts`|list of accounts to undelete|

#### Returns

|Type|Description|
|---|---|
|List<Account>|list of undeleted accounts|

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
delete accounts;
List<Account> results = DMLRecipes.undeleteAccountViaDatabaseMethod(accounts, AccessLevel.USER_MODE);
System.debug(results);
```


---
## Classes
### CustomDMLException

This exception is for throwing a custom exception to
highlight how negative tests operate.


**Inheritance**

CustomDMLException


---
