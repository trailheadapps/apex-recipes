---
layout: default
---
# QueueableChainingRecipes class

Demonstrates how to use the Queueable interface to chain multiple queueable instances together. The methods in this class, with the exception of the constructor, are run automatically by the system as the job runs. To enqueue this job, use: `System.enqueueJob(new QueueableChainingRecipes());` More on the Queuable interface: https://sfdc.co/queueable-apex

## Related

[QueueableRecipes](https://github.com/trailheadapps/apex-recipes/wiki/QueueableRecipes.md)

---
## Methods
### `execute(QueueableContext context)` → `void`

This recipe demonstrates how one queuable (this one) can enqueue a second Queueable class. If the second queueable class utilizes a constructor, information can be passed through to the next Queueable.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`context` |  Dependency Injected by the System |

#### Example
```java
System.enqueueJob(new QueueableChainingRecipes());
```

---
