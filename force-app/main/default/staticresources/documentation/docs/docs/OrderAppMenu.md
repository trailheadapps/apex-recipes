---
layout: default
---
# OrderAppMenu class

A queueable class to prioritize this sample app in the org wide App Menu. This is done as a Queuable, because calling setOrgSortOrder causes an exeception if your setup script is also creating non-metadata records, for instance accounts.

---
## Methods
### `execute(QueueableContext qc)` → `void`

reorders the org wide AppMenu order so Apex Recipes is the first seen.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`qc` |     dependency injected by the system at runtime. |

---
