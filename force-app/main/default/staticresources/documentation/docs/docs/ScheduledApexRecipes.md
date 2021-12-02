---
layout: default
---
# ScheduledApexRecipes class

Demonstrates how to implement the Schedulable interface. The methods in this class are designed to be scheduled, similar to a cron job. More on the Schedulable interface: https://sfdc.co/scheduled-apex

## Related

ScheduledApexDemo, BatchApexRecipes

---
## Properties

### `TEST_CRON_STATEMENT` → `String`

---
## Methods
### `execute(SchedulableContext context)` → `void`

This is the one method required by the Schedulable interface. Key requirements are that it be public, and void. Best practice is to keep your logic in a different class. In this case, we&apos;re calling code in the ScheduledApexDemo class. Note: You can use the schedulable interface to schedule Batch Classes but it&apos;s generally easier to use System.ScheduleBatch instead. See BatchApexRecipes for more information.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`context` |  Dependency Injected by the System |

#### Example
```java
System.schedule('Friendly Message to identify this job',
                 ScheduledApexRecipes.TEST_CRON_STATEMENT,
                 new ScheduledApexRecipes());
```

---
