# OrderAppMenu Class

A queueable class to prioritize this sample app in the org wide 
App Menu. This is done as a Queuable, because calling setOrgSortOrder causes 
an exeception if your setup script is also creating non-metadata records, 
for instance accounts.

**Group** Shared Code

**Implements**

System.Queueable

## Methods
### `execute(qc)`

`SUPPRESSWARNINGS`

reorders the org wide AppMenu order so Apex Recipes is the 
first seen.

#### Signature
```apex
public void execute(QueueableContext qc)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| qc | QueueableContext | dependency injected by the system at runtime. |

#### Return Type
**void**