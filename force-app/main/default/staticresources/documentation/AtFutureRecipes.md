# AtFutureRecipes

Demonstrates the `@future` syntax and usage


**Group** Async Apex Recipes

## Fields

### `private testCircuitBreaker` → `Boolean`

`TESTVISIBLE` 

This class features a 'circuit breaker' variable. While this is not a pattern I routinely turn to, it is a valuable pattern for testing code that is otherwise hard to test. For instance, `@future` methods must be static void methods. This makes it hard to assert against return values. The idea behind this pattern is set a private static class variable to true, only when irreversible conditions or actions have occurred. The circuit breaker 'breaks', giving you something you can assert on. Again this isn't a pattern I *often* turn to, but it can be valuable in certain circumstances.

---
## Methods
### `public static void atFutureMethodWithoutCalloutPrivileges(String data)`

`FUTURE`

Method demonstrates the `@future` annotation without the `(callout=true)` adendum. This method will be run in a different Apex transaction than the calling code.

#### Parameters

|Param|Description|
|---|---|
|`data`|String to be logged|

#### Example
```apex
AtFutureRecipes.atFutureMethodWithoutCalloutPrivileges('Some Data');
```


### `public static void atFutureMethodWithCalloutPrivileges(String url)`

`FUTURE`

Method demonstrates how an `@future` anotated method can make an HTTP Callout. This method also demonstrates the necessary steps to make an HTTP callout without the RestClient abstraction layer. The RestClient class can be found in the 'Shared Code' group.

#### Parameters

|Param|Description|
|---|---|
|`url`|The URL to make a callout to.|

#### Example
```apex
AtFutureRecipes.atFutureMethodWithCalloutPrivileges('google.com');
```


---
