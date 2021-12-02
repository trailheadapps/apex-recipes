---
layout: default
---
# AtFutureRecipes class

Demonstrates the @future syntax and usage

---
## Properties

### `testCircuitBreaker` → `Boolean`

 This class features a &apos;circuit breaker&apos; variable. While this is not a pattern I routinely turn to, it is a valuable pattern for testing code that is otherwise hard to test. For instance, @future methods must be static void methods. This makes it hard to assert against return values. The idea behind this pattern is set a private static class variable to true, only when irreversible conditions or actions have occurred. The circuit breaker &apos;breaks&apos;, giving you something you can assert on. Again this isn&apos;t a pattern I *often* turn to, but it can be valuable in certain circumstances.

---
## Methods
### `atFutureMethodWithCalloutPrivileges(String url)` → `void`

Method demonstrates how an @future anotated method can make an HTTP Callout. This method also demonstrates the necessary steps to make an HTTP callout without the RestClient abstraction layer. The RestClient class can be found in the &apos;Shared Code&apos; group

#### Parameters

| Param | Description |
| ----- | ----------- |
|`url` |        The URL to make a callout to. |

#### Example
```java
AtFutureRecipes.atFutureMethodWithCalloutPrivileges('google.com');
```

### `atFutureMethodWithoutCalloutPrivileges(String data)` → `void`

Method demonstrates the @future annotation without the (callout=true) adendum. This method will be run in a different Apex transaction than the calling code.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`data` |  String to be logged |

#### Example
```java
AtFutureRecipes.atFutureMethodWithoutCalloutPrivileges('Some Data');
```

---
