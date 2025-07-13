# ScheduledApexRecipes Class

Demonstrates how to implement the Schedulable interface. The 
methods in this class are designed to be scheduled, similar to a cron job. 
 
More on the Schedulable interface: 
https://sfdc.co/scheduled-apex

**Group** Async Apex Recipes

**See** [ScheduledApexDemo](ScheduledApexDemo.md)

**See** [BatchApexRecipes](BatchApexRecipes.md)

**Implements**

Schedulable

## Fields
### `TEST_CRON_STATEMENT`

`TESTVISIBLE`

#### Signature
```apex
private final static TEST_CRON_STATEMENT
```

#### Type
String

## Methods
### `execute(context)`

This is the one method required by the Schedulable 
interface. Key requirements are that it be public, and void. 
Best practice is to keep your logic in a different class. In this case, 
we&#x27;re calling code in the ScheduledApexDemo class. 
 
Note: You can use the schedulable interface to schedule Batch Classes 
but it&#x27;s generally easier to use System.ScheduleBatch instead. See 
BatchApexRecipes for more information.

#### Signature
```apex
public void execute(SchedulableContext context)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| context | SchedulableContext | Dependency Injected by the System |

#### Return Type
**void**

#### Example
```apex
System.schedule('Friendly Message to identify this job',
                 ScheduledApexRecipes.TEST_CRON_STATEMENT,
                 new ScheduledApexRecipes());
```