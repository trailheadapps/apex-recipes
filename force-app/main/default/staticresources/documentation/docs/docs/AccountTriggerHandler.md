---
layout: default
---
# AccountTriggerHandler class

Demonstrates how to construct a TriggerHandler using the trigger handler framework found in Shared Code/TriggerHandler.cls

## Related

TriggerHandler, AccountServiceLayer

---
## Constructors
### `AccountTriggerHandler()`

Constructor that sets class variables based on Trigger context vars
---
## Properties

### `circuitBreaker` → `Exception`

### `triggerMapNew` → `Map<Id, Account>`

### `triggerMapOld` → `Map<Id, Account>`

### `triggerNew` → `List<Account>`

### `triggerOld` → `List<Account>`

---
## Methods
### `afterDelete()` → `void`

after delete context method. Called automatically by the trigger framework this class extends Note: this method contains a PMD false-positive report about CRUD checking before insert. However, trigger code is run in system mode, regardless of users, so it doesn&apos;t make sense to check for Account and Task permissions. This code is therefore only safe to execute in the context of a trigger.

#### Example
```java
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
insert accounts;
delete accounts;
```

### `afterInsert()` → `void`

after insert context method. Called automatically by the trigger framework this class extends

#### Example
```java
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
accounts.add(new Account(name='example 2'));
insert accounts;
```

### `afterUndelete()` → `void`

after undelete context method. Called automatically by the trigger framework this class extends Note: this method contains a PMD false-positive report about CRUD checking before insert. However, trigger code is run in system mode, regardless of users, so it doesn&apos;t make sense to check for Account and Task permissions. This code is therefore only safe to execute in the context of a trigger.

#### Example
```java
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
insert accounts;
delete accounts;
undelete accounts;
```

### `afterUpdate()` → `void`

after update context method. Called automatically by the trigger framework this class extends Note: this method contains a PMD false-positive report about CRUD checking before insert. However, trigger code is run in system mode, regardless of users, so it doesn&apos;t make sense to check for Account and Task permissions. This code is therefore only safe to execute in the context of a trigger.

#### Example
```java
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
accounts.add(new Account(name='example 2'));
insert accounts;
accounts[0].name += ' Updated';
update accounts;
```

### `beforeDelete()` → `void`

before delete context method. Called automatically by the trigger framework this class extends Note: this method contains a PMD false-positive report about CRUD checking before insert. However, trigger code is run in system mode, regardless of users, so it doesn&apos;t make sense to check for Account and Task permissions. This code is therefore only safe to execute in the context of a trigger.

#### Example
```java
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
insert accounts;
delete accounts;
```

### `beforeInsert()` → `void`

Before Insert context method. Called automatically by the trigger framework this class extends.

#### Example
```java
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
accounts.add(new Account(name='example 2'));
insert accounts;
```

### `beforeUpdate()` → `void`

before update context method. Called automatically by the trigger framework this class extends

#### Example
```java
Account[] accounts = new Account[]();
accounts.add(new Account(name='example 1'));
accounts.add(new Account(name='example 2'));
insert accounts;
accounts[0].name += ' Updated';
update accounts;
```

---
## Inner Classes

### AccountTriggerHandler.AccountTriggerHandlerException class

Custom exception class

---
