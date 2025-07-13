# AtFutureRecipes Class

Demonstrates the `@future` syntax and usage

**Group** Async Apex Recipes

## Fields
### `testCircuitBreaker`

`TESTVISIBLE`

This class features a &#x27;circuit breaker&#x27; variable. While this is not a 
pattern I routinely turn to, it is a valuable pattern for testing code 
that is otherwise hard to test. For instance, `@future` methods must be 
static void methods. This makes it hard to assert against return values. 
The idea behind this pattern is set a private static class variable to 
true, only when irreversible conditions or actions have occurred. The 
circuit breaker &#x27;breaks&#x27;, giving you something you can assert on. Again 
this isn&#x27;t a pattern I *often* turn to, but it can be valuable in certain 
circumstances.

#### Signature
```apex
private static testCircuitBreaker
```

#### Type
Boolean

## Methods
### `atFutureMethodWithoutCalloutPrivileges(data)`

`FUTURE`

Method demonstrates the `@future` annotation without the 
 `(callout=true)` adendum. This method will be run in a different Apex 
transaction than the calling code.

#### Signature
```apex
public static void atFutureMethodWithoutCalloutPrivileges(String data)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| data | String | String to be logged |

#### Return Type
**void**

#### Example
```apex
AtFutureRecipes.atFutureMethodWithoutCalloutPrivileges('Some Data');
```

---

### `atFutureMethodWithCalloutPrivileges(url)`

`FUTURE`

Method demonstrates how an `@future` anotated method can make 
an HTTP Callout. This method also demonstrates the necessary steps to 
make an HTTP callout without the RestClient abstraction layer. 
 
The RestClient class can be found in the &#x27;Shared Code&#x27; group.

#### Signature
```apex
public static void atFutureMethodWithCalloutPrivileges(String url)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| url | String | The URL to make a callout to. |

#### Return Type
**void**

#### Example
```apex
AtFutureRecipes.atFutureMethodWithCalloutPrivileges('google.com');
```