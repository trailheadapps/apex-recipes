# ScheduledApexRecipes

Demonstrates how to implement the Schedulable interface. The
methods in this class are designed to be scheduled, similar to a cron job.
More on the Schedulable interface:
https://sfdc.co/scheduled-apex


**Implemented types**

[Schedulable](Schedulable)


**Group** Async Apex Recipes


**See** [ScheduledApexDemo](https://github.com/trailheadapps/apex-recipes/wiki/ScheduledApexDemo)


**See** [BatchApexRecipes](https://github.com/trailheadapps/apex-recipes/wiki/BatchApexRecipes)

## Fields

### `private TEST_CRON_STATEMENT` → `String`

`TESTVISIBLE` 

---
## Methods
### `public void execute(SchedulableContext context)`

This is the one method required by the Schedulable interface. Key requirements are that it be public, and void. Best practice is to keep your logic in a different class. In this case, we're calling code in the ScheduledApexDemo class. Note: You can use the schedulable interface to schedule Batch Classes but it's generally easier to use System.ScheduleBatch instead. See BatchApexRecipes for more information.

#### Parameters

|Param|Description|
|---|---|
|`context`|Dependency Injected by the System|

#### Example
```apex
System.schedule('Friendly Message to identify this job',
                 ScheduledApexRecipes.TEST_CRON_STATEMENT,
                 new ScheduledApexRecipes());
```


---
