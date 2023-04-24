---
layout: default
---
# DMLRecipes class

Demonstrates various ways of making Data Manipulation Language (DML) calls. Note that this class demonstrates both Database.* methods as well as DML Keywords.

---
## Methods
### `deleteAccountViaDatabaseMethod(List<Account> accts,System.AccessLevel accessLevel)` → `Void`

Deletes a list of accounts via the Database.delete method

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accts` |  List of Accounts to delete |

#### Example
```java
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts in user mode;
DMLRecipes.deleteAccountViaDatabaseMethod(accounts, AccessLevel.USER_MODE);
```

### `deleteAccountViaKeywordInSystemMode(List<Account> accts)` → `Void`

Deletes a list of accounts via the delete DML keyword

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accts` |  list of accounts to delete in system mode |

#### Example
```java
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
DMLRecipes.deleteAccountViaKeywordInSystemMode(accounts);
```

### `deleteAccountViaKeywordInUserMode(List<Account> accts)` → `Void`

Deletes a list of accounts via the delete DML keyword

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accts` |  list of accounts to delete in user mode |

#### Example
```java
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
DMLRecipes.deleteAccountViaKeywordInUserMode(accounts);
```

### `insertAccountViaInsertKeywordInSystemMode(String name)` → `void`

Demonstrates how to use the insert keyword to persist a net-new record to the database in system mode

#### Parameters

| Param | Description |
| ----- | ----------- |
|`name` |  name passed through to the name of the created account |

#### Example
```java
DMLRecipes.insertAccountViaInsertKeywordInSystemMode('Hello');
```

### `insertAccountViaInsertKeywordInUserMode(String name)` → `void`

Demonstrates how to use the insert keyword to persist a net-new record to the database in user mode

#### Parameters

| Param | Description |
| ----- | ----------- |
|`name` |  name passed through to the name of the created account |

#### Example
```java
DMLRecipes.insertAccountViaInsertKeywordInUserMode('Hello');
```

### `insertAccountsViaDatabaseMethod(String name,Boolean allOrNothing,System.AccessLevel accessLevel)` → `void`

Demonstrates how to use the Database.insert() method to persist a net-new record to the database.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`name` |          name Passed through to the account created |
|`allOrNothing` |  allOrNothing determines whether or not all accounts |

#### Example
```java
DMLRecipes.insertAccountsViaDatabaseMethod('Hello', false, AccessLevel.USER_MODE);
```

### `undeleteAccountViaDatabaseMethod(List<Account> accts,System.AccessLevel accessLevel)` → `List<Account>`

undeletes a list of accounts via the Database.undelete method.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accts` |  list of accounts to undelete |

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;

#### Example
```java
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
delete accounts;
List<Account> results = DMLRecipes.undeleteAccountViaDatabaseMethod(accounts, AccessLevel.USER_MODE);
System.debug(results);
```

### `undeleteAccountViaKeywordInSystemMode(List<Account> accts)` → `List<Account>`

Undeletes a list of accounts via the undelete DML keyword

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accts` |  List of accounts to undelete in user mode |

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;

#### Example
```java
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
delete accounts;
List<Account> results = DMLRecipes.undeleteAccountViaKeywordInSystemMode(accounts);
System.debug(results);
```

### `undeleteAccountViaKeywordInUserMode(List<Account> accts)` → `List<Account>`

Undeletes a list of accounts via the undelete DML keyword

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accts` |  List of accounts to undelete in user mode |

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;

#### Example
```java
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
delete accounts;
List<Account> results = DMLRecipes.undeleteAccountViaKeywordInUserMode(accounts);
System.debug(results);
```

### `updateAcccountViaKeywordInSystemMode(List<Account> accts)` → `List<Account>`

Demonstrates how to Update a list of accounts via the Update DML keyword in System Mode

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accts` |  List of accounts to update |

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;

#### Example
```java
Account acct = new Account(name='Hello World');
insert acct;
DMLRecipes.updateAcccountViaKeywordInSystemMode(acct);
```

### `updateAcccountViaKeywordInUserMode(List<Account> accts)` → `List<Account>`

Demonstrates how to Update a list of accounts via the Update DML keyword

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accts` |  List of accounts to update |

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;

#### Example
```java
Account acct = new Account(name='Hello World');
insert acct;
DMLRecipes.updateAcccountViaKeyword(acct);
```

### `updateAccountViaDatabaseMethod(List<Account> accts,System.AccessLevel accessLevel)` → `List<Account>`

Demonstrates how to update a list of accounts via the Database.update() method

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accts` |  list of accounts to update |

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;

#### Example
```java
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
List<Account> results = DMLRecipes.updateAccountViaDatabaseMethod(accounts, AccessLevel.USER_MODE);
System.debug(results);
```

### `upsertAccountViaDatabaseMethod(Account acct,Boolean allOrNothing,System.AccessLevel accessLevel)` → `Database.UpsertResult`

Upserts an account with a potential of all or nothing, using the Database.upsert method

#### Parameters

| Param | Description |
| ----- | ----------- |
|`acct` |  The account object to upsert |
|`allOrNothing` |  all or nothing flag |

#### Return

**Type**

Database.UpsertResult

**Description**

UpsertResult

#### Example
```java
DMLRecipes.upsertAccountViaDatabaseMethod(
           new Account(name='Hello World'), false, AccessLevel.USER_MODE);
```

### `upsertAccountViaUpsertKeywordInSystemMode(Account acct)` → `Account`

Demonstrates the use of the upsert keyword to either insert or update a record in system mode

#### Parameters

| Param | Description |
| ----- | ----------- |
|`acct` |  account to upsert |

#### Return

**Type**

Account

**Description**

Account

#### Example
```java
DMLRecipes.upsertAccountViaUpsertKeywordInSystemMode(new Account(name='Hello World'));
```

### `upsertAccountViaUpsertKeywordInUserMode(Account acct)` → `Account`

Demonstrates the use of the upsert keyword to either insert or update a record in user mode

#### Parameters

| Param | Description |
| ----- | ----------- |
|`acct` |  account to upsert |

#### Return

**Type**

Account

**Description**

Account

#### Example
```java
DMLRecipes.upsertAccountViaUpsertKeywordInUserMode(new Account(name='Hello World'));
```

---
## Inner Classes

### DMLRecipes.CustomDMLException class

This exception is for throwing a custom exception to highlight how negative tests operate.

---
