# QueueableRecipes Class

This class demonstrates how to construct a Queueable class. 
The methods in this class are run automatically by the system 
as the job runs. To enqueue this job, use: `System.enqueueJob(new QueueableRecipes());` 
 
More on the Queable interface: 
https://sfdc.co/queueable-apex

**Group** Async Apex Recipes

**Implements**

Queueable

## Methods
### `execute(qc)`

This is the only required method to implement Queueable. 
In our case, it&#x27;s simply updating account names, but this execute method 
can be used to execute any asynchronous code. Queueable classes run 
asynchronously much like `@future` annotated code. However, because they&#x27;re 
implementing an interface they can be constructed, and thus accept full 
objects, not just primitives. Crucially, Queueable classes can also 
_enqueue_ other Queueable classes. See QueueableChainingRecipes for more 
details.

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
System.enqueueJob(new QueueableRecipes());
```