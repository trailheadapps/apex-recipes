---
layout: default
---
# QueueableRecipes class

This class demonstrates how to construct a Queueable class. The methods in this class are run automatically by the system as the job runs. To enqueue this job, use: `System.enqueueJob(new QueueableRecipes());` More on the Queable interface: https://sfdc.co/queueable-apex

---
## Methods
### `execute(QueueableContext qc)` → `void`

This is the only required method to implement Queueable. In our case, it&apos;s simply updating account names, but this execute method can be used to execute any asynchronous code. Queueable classes run asynchronously much like @future annotated code. However, because they&apos;re implementing an interface they can be constructed, and thus accept full objects, not just primitives. Crucially, Queueable classes can also _enqueue_ other Queueable classes. See QueueableChainingRecipes for more details.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`qc` |  dependency injected by the system |

#### Example
```java
System.enqueueJob(new QueueableRecipes());
```

---
