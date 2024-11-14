# QueueableWithCalloutRecipes Class

Demmonstrates the use of the Queueable interface to make 
callouts. The methods in this class are called by the system at run time. 
To enqueue this job and see it&#x27;s results, use `System.enqueueJob(new QueueableWithCalloutRecipes());` 
 
More on the Queable interface: 
https://sfdc.co/queueable-apex

**Group** Async Apex Recipes

**See** [RestClient](https://github.com/trailheadapps/apex-recipes/wiki/RestClient)

**Implements**

Queueable, 
Database.AllowsCallouts

## Fields
### `throwError`

`TESTVISIBLE`

#### Signature
```apex
private static throwError
```

#### Type
Boolean

---

### `circuitBreakerThrown`

`TESTVISIBLE`

#### Signature
```apex
private static circuitBreakerThrown
```

#### Type
Boolean

## Methods
### `execute(qc)`

This is the only required method to implement Queueable. 
Queueable classes that also implement Database.allowsCallouts can make 
HTTP requests to external services. In this recipe we make a GET request 
to developer.salesforce.com

#### Signature
```apex
public static void execute(QueueableContext qc)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| qc | QueueableContext | dependency injected by the system |

#### Return Type
**void**

#### Example
```apex
System.enqueueJob(new QueueableWithCalloutRecipes());
```

## Classes
### QueueableWithCalloutRecipesException Class

Internal custom exception class