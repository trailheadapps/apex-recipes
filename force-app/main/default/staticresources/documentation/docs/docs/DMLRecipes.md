---
layout: default
---
# DMLRecipes class

Demonstrates various ways of making Data Manipulation Language (DML) calls. Note that this class demonstrates both Database.* methods as well as DML Keywords. Note: There is a @suppressWarnings annotation on this class for Cyclomatic Complexity. You can read more about what Cyclomatic Complexity is here: https://en.wikipedia.org/wiki/Cyclomatic_complexity Classes with a high Cyclomatic Compelexity score are harder to test, and more prone to bugs because of the sheer number of branching logic paths available. This class is made up of a number of small methods, each of whom does CRUD/FLS Checks and therefor every method includes at least one branching path - but not much else. Because this class is designed to teach safe DML I&apos;ve decided to mute this warning. Other classes in this repository do not have such a high Cyclomatic Complexity because the ratio of logic to if/else statments is much lower.

## Related

[CanTheUser](https://github.com/trailheadapps/apex-recipes/wiki/CanTheUser.md)

---
## Methods
### `deleteAccountViaDatabaseMethod(List<Account> accts)` → `Void`

Deletes a list of accounts via the Database.delete method

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accts` |  List of Accounts to delete |

#### Example
```java
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
DMLRecipes.deleteAccountViaDatabaseMethod(accounts);
```

### `deleteAccountViaKeyword(List<Account> accts)` → `Void`

Deletes a list of accounts via the delete DML keyword

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accts` |  list of accounts to delete |

#### Example
```java
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
DMLRecipes.deleteAccountViaDatabaseMethod(accounts);
```

### `insertAccountViaInsertKeyword(String name)` → `void`

Demonstrates how to use the insert keyword to persist a net-new record to the database

#### Parameters

| Param | Description |
| ----- | ----------- |
|`name` |  name passed through to the name of the created account |

#### Example
```java
DMLRecipes.insertAccountViaInsertKeyword('Hello');
```

### `insertAccountsViaDatabaseMethod(String name,Boolean allOrNothing)` → `void`

Demonstrates how to use the Database.insert() method to persist a net-new record to the database.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`name` |          name Passed through to the account created |
|`allOrNothing` |  allOrNothing determines whether or not all accounts |

#### Example
```java
DMLRecipes.insertAccountsViaDatabaseMethod('Hello', false);
```

### `undeleteAccountViaDatabaseMethod(List<Account> accts)` → `List<Account>`

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
List<Account> results = DMLRecipes.undeleteAccountViaDatabaseMethod(accounts);
System.debug(results);
```

### `undeleteAccountViaKeyword(List<Account> accts)` → `List<Account>`

Undeletes a list of accounts via the undelete DML keyword

#### Parameters

| Param | Description |
| ----- | ----------- |
|`accts` |  List of accounts to undelete |

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
List<Account> results = DMLRecipes.undeleteAccountViaKeyword(accounts);
System.debug(results);
```

### `updateAcccountViaKeyword(List<Account> accts)` → `List<Account>`

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

### `updateAccountViaDatabaseMethod(List<Account> accts)` → `List<Account>`

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
List<Account> results = DMLRecipes.updateAccountViaDatabaseMethod(accounts);
System.debug(results);
```

### `upsertAccountViaDatabaseMethod(Account acct,Boolean allOrNothing)` → `Database.UpsertResult`

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
           new Account(name='Hello World'), false);
```

### `upsertAccountViaUpsertKeyword(Account acct)` → `Account`

Demonstrates the use of the upsert keyword to either insert or update a record

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
DMLRecipes.upsertAccountViaUpsertKeyword(new Account(name='Hello World'));
```

---
## Inner Classes

### DMLRecipes.CustomDMLException class

This exception is for throwing a custom exception to highlight how negative tests operate.

---
