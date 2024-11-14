# QueueableChainingRecipes Class

Demonstrates how to use the Queueable interface 
to chain multiple queueable instances together. The methods in this class, 
with the exception of the constructor, are run automatically by the system 
as the job runs. To enqueue this job, use: 
 `System.enqueueJob(new QueueableChainingRecipes());` 
 
More on the Queuable interface: 
https://sfdc.co/queueable-apex

**Group** Async Apex Recipes

**See** [QueueableRecipes](QueueableRecipes.md)

**Implements**

Queueable

## Methods
### `execute(context)`

This recipe demonstrates how one queuable (this one) can 
enqueue a second Queueable class. 
If the second queueable class utilizes a constructor, information can be 
passed through to the next Queueable.

#### Signature
```apex
public static void execute(QueueableContext context)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| context | QueueableContext | Dependency Injected by the System |

#### Return Type
**void**

#### Example
```apex
System.enqueueJob(new QueueableChainingRecipes());
```