---
layout: default
---
# DynamicSOQLRecipes class

Demonstrates how to construct a SOQL query dynamically, and safely More on dynamic SOQL and SOQL injection: https://sfdc.co/soql-injection

---
## Methods
### `dynamicFieldsBindingSOQLQuery(Account acct)` → `List<Account>`

Demonstrates how to use a field from a passed param in a bound dynamic SOQL queryString. DANGER: because this method accepts user input (name param), it must be sanitized against SOQL injections

#### Parameters

| Param | Description |
| ----- | ----------- |
|`acct` |  Account to base the search off of |

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;

#### Example
```java
Account acct = [SELECT name FROM Account WHERE name = 'hello' LIMIT 1];
Account[] results = DynamicSOQLRecipes.dynamicFieldsBindingSOQLQuery(acct);
System.debug(results);
```

### `simpleBindingSOQLQuery(String name)` → `List<Account>`

Demonstrates the use of a bound variable in a dynamic SOQL query. DANGER Because this method accepts user input (name param), it must be sanitized against SOQL injections

#### Parameters

| Param | Description |
| ----- | ----------- |
|`name` |  Name of the account to search for |

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;

#### Example
```java
System.debug(DynamicSoqlRecipes.simpleBindingSOQLQuery('hello'))
```

### `simpleDynamicSOQLQuery()` → `List<Account>`

demonstrates a simple dynamic SOQL query where the query is defined in Apex Note: This method has a false-positive PMD warning. Our Query does not include any input parameters so SOQL Injection is not possible.

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt; with security enforced using USER_MODE

#### Example
```java
System.debug(DynamicSOQLRecipes.simpleDynamicSOQLQuery());
```

### `simpleQueryBuilder(List<String> fields,String whereClause)` → `List<Account>`

Demonstrates the power of Dynamic SOQL to create a SOQL query on the fly Note: This method contains a PMD false-positive report on a possible SOQL injection vulnerability. This method is, in fact, a potentially dangerous one. Be *extremely careful* with queries like this. Whenever possible do not dynamically generate your where clause as a string. Use bind variables. Because the where clause here comes in as a pre-defined string, the calling code *must* sanitize the input. If you try to String.escapeSingleQuotes(whereClause) it will generate a SQL error saying: no viable alternative at character &apos;\&apos; At the very least, typecast it to a string. Please look at: DynamicSOQLRecipes_Tests.simpleQueryBuilderTest_Positive() for details on how to do calling side sanitization of input. This method *also* uses a guard statement to prevent execution contexts where input sanitization is unlikey or impossible.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`fields` |       A list of String field names to include in the query |
|`whereClause` |  A string containing the where clause |

#### Return

**Type**

List&lt;Account&gt;

**Description**

`List&lt;Account&gt;`

#### Example
```java
List<String> fields = new List<String>{
      'Name',
      'NumberOfEmployees',
      'BillingAddress'
  };
String whereClause =
      'id = \'' +
      String.escapeSingleQuotes(acctId) +
      '\'';
List<Account> results = DynamicSOQLRecipes.simpleQueryBuilder(
      fields,
      whereClause
  );
  System.debug(results);
```

### `typecastDataIntelligently(String numberOfRecords)` → `List<Account>`

Demonstrates intelligent typecasting to enforce sanitized dynamic queries DANGER: Because this method accepts user input (name param), it must be sanitized against SOQL injections Note: This method contains a False-Positive PMD warning about SOQL Injection. Developers should always ensure the data you&apos;re merging into a query is safe by escaping it. However, Apex is a type safe language, and attempting to pass anything other than an integer to this method will result in an exception being thrown. The purpose of this method is to demonstrate how typecasting a string to an integer can prevent SOQL injection attacks. If you passed in &apos;44&apos;do smething mean&apos; the cast to integer will throw an exception.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`numberOfRecords` |  String to be used as the comparison in the query |

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;

#### Example
```java
System.debug(DynamicSOQLRecipes.typecastDataIntelligently(2).size());
```

---
## Inner Classes

### DynamicSOQLRecipes.DynamicSoqlException class

Internal exception class

---
