# DynamicSOQLRecipes Class

Demonstrates how to construct a SOQL query dynamically, and 
safely 
 
More on dynamic SOQL and SOQL injection: 
https://sfdc.co/soql-injection

**Group** Data Recipes

## Methods
### `simpleDynamicSOQLQuery()`

`SUPPRESSWARNINGS`

demonstrates a simple dynamic SOQL query where the query is 
defined in Apex 
Note: This method has a false-positive PMD warning. Our Query 
does not include any input parameters so SOQL Injection is not possible.

#### Signature
```apex
public static List<Account> simpleDynamicSOQLQuery()
```

#### Return Type
**List&lt;Account&gt;**

Account list with security enforced using ,[object Object]

#### Example
```apex
System.debug(DynamicSOQLRecipes.simpleDynamicSOQLQuery());
```

---

### `simpleBindingSOQLQuery(name)`

Demonstrates the use of a bound variable in a dynamic SOQL 
query. DANGER Because this method accepts user input (name param), it 
must be sanitized against SOQL injections

#### Signature
```apex
public static List<Account> simpleBindingSOQLQuery(String name)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| name | String | Name of the account to search for |

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
System.debug(DynamicSoqlRecipes.simpleBindingSOQLQuery('hello'))
```

---

### `dynamicFieldsBindingSOQLQuery(acct)`

Demonstrates how to use a field from a passed param in a 
bound dynamic SOQL queryString. DANGER: because this method accepts user 
input (name param), it must be sanitized against SOQL injections

#### Signature
```apex
public static List<Account> dynamicFieldsBindingSOQLQuery(Account acct)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| acct | Account | Account to base the search off of |

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
Account acct = [SELECT Name FROM Account WHERE Name = 'hello' LIMIT 1];
Account[] results = DynamicSOQLRecipes.dynamicFieldsBindingSOQLQuery(acct);
System.debug(results);
```

---

### `typecastDataIntelligently(numberOfRecords)`

`SUPPRESSWARNINGS`

Demonstrates intelligent typecasting to enforce sanitized 
dynamic queries DANGER: Because this method accepts user input 
(name param), it must be sanitized against SOQL injections 
 
Note: This method contains a False-Positive PMD warning about SOQL 
Injection. Developers should always ensure the data you&#x27;re merging into a 
query is safe by escaping it. However, Apex is a type safe language, and 
attempting to pass anything other than an integer to this method will 
result in an exception being thrown. The purpose of this method is to 
demonstrate how typecasting a string to an integer can prevent SOQL 
injection attacks. If you passed in &#x27;44&#x27;do smething mean&#x27; the cast to 
integer will throw an exception.

#### Signature
```apex
public static List<Account> typecastDataIntelligently(String numberOfRecords)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| numberOfRecords | String | String to be used as the comparison in the query |

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
System.debug(DynamicSOQLRecipes.typecastDataIntelligently(2).size());
```

---

### `simpleQueryBuilder(fields, whereClause)`

`SUPPRESSWARNINGS`

Demonstrates the power of Dynamic SOQL to create a SOQL 
query on the fly 
 
Note: This method contains a PMD false-positive report on a possible 
SOQL injection vulnerability. This method is, in fact, a potentially 
dangerous one. Be *extremely careful* with queries like this. 
Whenever possible do not dynamically generate your 
where clause as a string. Use bind variables. 
Because the where clause here comes in as a pre-defined 
string, the calling code *must* sanitize the input. 
If you try to String.escapeSingleQuotes(whereClause) it will 
generate a SQL error saying: no viable alternative at character &#x27;\&#x27; 
At the very least, typecast it to a string. 
 
Please look at: 
DynamicSOQLRecipes_Tests.simpleQueryBuilderTest_Positive() 
for details on how to do calling side sanitization of input. 
 
This method *also* uses a guard statement to prevent execution 
contexts where input sanitization is unlikey or impossible.

#### Signature
```apex
public static List<Account> simpleQueryBuilder(List<String> fields, String whereClause)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fields | List&lt;String&gt; | A list of String field names to include in the query |
| whereClause | String | A string containing the where clause |

#### Return Type
**List&lt;Account&gt;**

#### Example
```apex
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