---
layout: default
---
# QueueableWithCalloutRecipes class

Demmonstrates the use of the Queueable interface to make callouts. The methods in this class are called by the system at run time. To enqueue this job and see it&apos;s results, use `System.enqueueJob(new QueueableWithCalloutRecipes());` More on the Queable interface: https://sfdc.co/queueable-apex

## Related

[RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient.md)

---
## Properties

### `circuitBreakerThrown` → `Boolean`

### `throwError` → `Boolean`

---
## Methods
### `execute(QueueableContext qc)` → `void`

This is the only required method to implement Queueable. Queueable classes that also implement Database.allowsCallouts can make HTTP requests to external services. In this recipe we make a GET request to developer.salesforce.com

#### Parameters

| Param | Description |
| ----- | ----------- |
|`qc` |  dependency injected by the system |

#### Example
```java
System.enqueueJob(new QueueableWithCalloutRecipes());
```

---
## Inner Classes

### QueueableWithCalloutRecipes.QueueableWithCalloutRecipesException class

Internal custom exception class

---
