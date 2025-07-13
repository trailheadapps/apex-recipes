# ScheduledApexDemo Class

A demo class to be scheduled by ScheduledApexRecipes

**Group** Async Apex Recipes

**See** [ScheduledApexRecipes](ScheduledApexRecipes.md)

## Fields
### `counter`

`TESTVISIBLE`

#### Signature
```apex
private counter
```

#### Type
Integer

## Methods
### `runAtMidnight()`

A method demosrating the best practice of separating your 
logic from 
the schedulable interface code that executes it.

#### Signature
```apex
public void runAtMidnight()
```

#### Return Type
**void**

#### Example
```apex
ScheduledApexDemo.runAtMidnight();
```