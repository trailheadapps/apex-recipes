# DMLRecipes Class

Demonstrates various ways of making Data Manipulation Language 
(DML) calls. Note that this class demonstrates both Database methods as 
well as DML Keywords.

**Group** Data Recipes

## Methods
### `insertAccountViaInsertKeywordInSystemMode(name)`

Demonstrates how to use the `insert` keyword to persist a 
net-new record to the database in system mode

#### Signature
```apex
public static Account insertAccountViaInsertKeywordInSystemMode(String name)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| name | String | name of the created account |

#### Return Type
**Account**

the inserted Account

#### Example
DMLRecipes.insertAccountViaInsertKeywordInSystemMode(&#x27;Hello&#x27;);

---

### `insertAccountViaInsertKeywordInUserMode(name)`

Demonstrates how to use the `insert` keyword to persist a 
net-new record to the database in user mode

#### Signature
```apex
public static Account insertAccountViaInsertKeywordInUserMode(String name)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| name | String | name of the created account |

#### Return Type
**Account**

the inserted Account

#### Example
```apex
DMLRecipes.insertAccountViaInsertKeywordInUserMode('Hello');
```

---

### `insertAccountsViaDatabaseMethod(names, allOrNothing, accessLevel)`

Demonstrates how to use the `Database.insert()` method to 
persist a net-new record to the database.

#### Signature
```apex
public static List<Account> insertAccountsViaDatabaseMethod(List<String> names, Boolean allOrNothing, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| names | List&lt;String&gt; | names used for account creation |
| allOrNothing | Boolean | determines whether or not all accounts 
to be inserted must insert successfully |
| accessLevel | System.AccessLevel |  |

#### Return Type
**List&lt;Account&gt;**

list of inserted accounts

#### Example
```apex
DMLRecipes.insertAccountsViaDatabaseMethod('Hello', false, AccessLevel.USER_MODE);
```

---

### `upsertAccountViaUpsertKeywordInSystemMode(acct)`

Demonstrates the use of the `upsert` keyword to either insert 
or update a record in system mode

#### Signature
```apex
public static Account upsertAccountViaUpsertKeywordInSystemMode(Account acct)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| acct | Account | account to upsert |

#### Return Type
**Account**

Upserted Account record

#### Example
```apex
DMLRecipes.upsertAccountViaUpsertKeywordInSystemMode(new Account(name='Hello World'));
```

---

### `upsertAccountViaUpsertKeywordInUserMode(acct)`

Demonstrates the use of the `upsert` keyword to either insert 
or update a record in user mode

#### Signature
```apex
public static Account upsertAccountViaUpsertKeywordInUserMode(Account acct)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| acct | Account | account to upsert |

#### Return Type
**Account**

Upserted Account record

#### Example
```apex
DMLRecipes.upsertAccountViaUpsertKeywordInUserMode(new Account(name='Hello World'));
```

---

### `upsertAccountViaDatabaseMethod(acct, allOrNothing, accessLevel)`

Upserts an account with a potential of all or nothing, using 
the `Database.upsert` method

#### Signature
```apex
public static Database.UpsertResult upsertAccountViaDatabaseMethod(Account acct, Boolean allOrNothing, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| acct | Account | The account object to upsert |
| allOrNothing | Boolean | all or nothing flag |
| accessLevel | System.AccessLevel |  |

#### Return Type
**Database.UpsertResult**

Upsert operation result

#### Example
```apex
DMLRecipes.upsertAccountViaDatabaseMethod(
           new Account(Name='Hello World'), false, AccessLevel.USER_MODE);
```

---

### `updateAcccountViaKeywordInSystemMode(accts)`

Demonstrates how to Update a list of accounts via the `update` 
DML keyword in System Mode

#### Signature
```apex
public static List<Account> updateAcccountViaKeywordInSystemMode(List<Account> accts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accts | List&lt;Account&gt; | List of accounts to update |

#### Return Type
**List&lt;Account&gt;**

List of updated records

#### Example
```apex
Account acct = new Account(name='Hello World');
insert acct;
DMLRecipes.updateAcccountViaKeywordInSystemMode(acct);
```

---

### `updateAcccountViaKeywordInUserMode(accts)`

Demonstrates how to Update a list of accounts via the `update` 
DML keyword

#### Signature
```apex
public static List<Account> updateAcccountViaKeywordInUserMode(List<Account> accts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accts | List&lt;Account&gt; | List of accounts to update |

#### Return Type
**List&lt;Account&gt;**

List of updated records

#### Example
```apex
Account acct = new Account(name='Hello World');
insert acct;
DMLRecipes.updateAcccountViaKeyword(acct);
```

---

### `updateAccountViaDatabaseMethod(accts, accessLevel)`

Demonstrates how to update a list of accounts via the 
 `Database.update()` method

#### Signature
```apex
public static List<Account> updateAccountViaDatabaseMethod(List<Account> accts, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accts | List&lt;Account&gt; | list of accounts to update |
| accessLevel | System.AccessLevel |  |

#### Return Type
**List&lt;Account&gt;**

List of updated records

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
List<Account> results = DMLRecipes.updateAccountViaDatabaseMethod(accounts, AccessLevel.USER_MODE);
System.debug(results);
```

---

### `deleteAccountViaKeywordInSystemMode(accts)`

Deletes a list of accounts via the `delete` DML keyword

#### Signature
```apex
public static void deleteAccountViaKeywordInSystemMode(List<Account> accts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accts | List&lt;Account&gt; | list of accounts to delete in system mode |

#### Return Type
**void**

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
DMLRecipes.deleteAccountViaKeywordInSystemMode(accounts);
```

---

### `deleteAccountViaKeywordInUserMode(accts)`

Deletes a list of accounts via the `delete` DML keyword

#### Signature
```apex
public static void deleteAccountViaKeywordInUserMode(List<Account> accts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accts | List&lt;Account&gt; | list of accounts to delete in user mode |

#### Return Type
**void**

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
DMLRecipes.deleteAccountViaKeywordInUserMode(accounts);
```

---

### `deleteAccountViaDatabaseMethod(accts, accessLevel)`

Deletes a list of accounts via the `Database.delete` method

#### Signature
```apex
public static void deleteAccountViaDatabaseMethod(List<Account> accts, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accts | List&lt;Account&gt; | List of Accounts to delete |
| accessLevel | System.AccessLevel |  |

#### Return Type
**void**

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts in user mode;
DMLRecipes.deleteAccountViaDatabaseMethod(accounts, AccessLevel.USER_MODE);
```

---

### `undeleteAccountViaKeywordInSystemMode(accts)`

Undeletes a list of accounts via the `undelete` DML keyword

#### Signature
```apex
public static List<Account> undeleteAccountViaKeywordInSystemMode(List<Account> accts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accts | List&lt;Account&gt; | List of accounts to undelete in user mode |

#### Return Type
**List&lt;Account&gt;**

list of undeleted accounts

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
delete accounts;
List<Account> results = DMLRecipes.undeleteAccountViaKeywordInSystemMode(accounts);
System.debug(results);
```

---

### `undeleteAccountViaKeywordInUserMode(accts)`

Undeletes a list of accounts via the `undelete` DML keyword

#### Signature
```apex
public static List<Account> undeleteAccountViaKeywordInUserMode(List<Account> accts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accts | List&lt;Account&gt; | List of accounts to undelete in user mode |

#### Return Type
**List&lt;Account&gt;**

list of undeleted accounts

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
delete accounts;
List<Account> results = DMLRecipes.undeleteAccountViaKeywordInUserMode(accounts);
System.debug(results);
```

---

### `undeleteAccountViaDatabaseMethod(accts, accessLevel)`

undeletes a list of accounts via the `Database.undelete` method.

#### Signature
```apex
public static List<Account> undeleteAccountViaDatabaseMethod(List<Account> accts, System.AccessLevel accessLevel)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accts | List&lt;Account&gt; | list of accounts to undelete |
| accessLevel | System.AccessLevel |  |

#### Return Type
**List&lt;Account&gt;**

list of undeleted accounts

#### Example
```apex
List<Account> accounts = new List<Account>{new Account(name = 'Hello World')};
insert accounts;
delete accounts;
List<Account> results = DMLRecipes.undeleteAccountViaDatabaseMethod(accounts, AccessLevel.USER_MODE);
System.debug(results);
```

## Classes
### CustomDMLException Class

This exception is for throwing a custom exception to 
highlight how negative tests operate.