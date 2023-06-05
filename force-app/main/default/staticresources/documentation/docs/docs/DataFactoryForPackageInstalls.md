---
layout: default
---
# DataFactoryForPackageInstalls class

Class generates data for installation cases where we cannot create example data via a Salesforce CLI call

---
## Methods
### `generateData()` → `void`

generates three sets of data, used to demonstrate how junction objects work. It creates two lists of parent records and a list of junction objects. Note: This is intended as a setup script, and as such, it supresses the PMD ApexCrudViolation.

---
