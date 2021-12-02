---
layout: default
---
# QuiddityGuard class

contains methods and static lists for rapid acceptence of a particular set of quiddities

---
## Properties

### `testQuiddityOverride` → `Quiddity`

a private testvisible variable allowing developers to inject a custom quiddity value during test execution.

### `trustedQuiddities` → `List<Quiddity>`

a non-exhaustive list of Quiddities that do not include user situations where users could be injecting malicious data.

### `trustedTestQuiddities` → `List<Quiddity>`

An exaustive list of quiddities that are valid for a test execution

### `untrustedQuiddities` → `List<Quiddity>`

A list of quiddities that may include user-defined data and therefore should not be trusted without manual FLS/CRUD checks

---
## Methods
### `isAcceptableQuiddity(List<Quiddity> acceptableQuiddites)` → `Boolean`

A method to determine if the current Quiddity context is within a caller-supplied list of acceptable quiddity values.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`acceptableQuiddites` |  A list of quiddities to check against |

#### Return

**Type**

Boolean

**Description**

`boolean`

### `isNotAcceptableQuiddity(List<Quiddity> acceptableQuiddites)` → `Boolean`
---
