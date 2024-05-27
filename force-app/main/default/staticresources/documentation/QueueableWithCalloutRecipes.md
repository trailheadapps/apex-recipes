# QueueableWithCalloutRecipes

Demmonstrates the use of the Queueable interface to make
callouts. The methods in this class are called by the system at run time.
To enqueue this job and see it's results, use `System.enqueueJob(new QueueableWithCalloutRecipes());`
More on the Queable interface:
https://sfdc.co/queueable-apex


**Implemented types**

[Queueable](Queueable)
, 
[Database.AllowsCallouts](Database.AllowsCallouts)


**Group** Async Apex Recipes


**See** [RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient)

## Fields

### `private circuitBreakerThrown` → `Boolean`

`TESTVISIBLE` 

### `private throwError` → `Boolean`

`TESTVISIBLE` 

---
## Methods
### `public static void execute(QueueableContext qc)`

This is the only required method to implement Queueable. Queueable classes that also implement Database.allowsCallouts can make HTTP requests to external services. In this recipe we make a GET request to developer.salesforce.com

#### Parameters

|Param|Description|
|---|---|
|`qc`|dependency injected by the system|

#### Example
```apex
System.enqueueJob(new QueueableWithCalloutRecipes());
```


---
## Classes
### QueueableWithCalloutRecipesException

Internal custom exception class


**Inheritance**

QueueableWithCalloutRecipesException


---
