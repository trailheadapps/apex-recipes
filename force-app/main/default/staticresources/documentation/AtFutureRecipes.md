---
layout: default
---
# AtFutureRecipes

Demonstrates the `@future` syntax and usage


**Group** Async Apex Recipes

## Fields

### `private testCircuitBreaker` → `Boolean`

`TESTVISIBLE` 

---
## Methods
### `public static atFutureMethodWithoutCalloutPrivileges(String data)`

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


### `public static atFutureMethodWithCalloutPrivileges(String url)`

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
