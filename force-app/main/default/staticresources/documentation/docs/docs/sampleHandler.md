---
layout: default
---
# SampleHandler class

This class is a sample trigger handler for use while testing the metadataTriggerHandler. Because custom metadata cannot be inserted, and because the MetadataTriggerHandler instantiates handler classes from custom metadata records, even when we stub/mock the metadata record retrieval we still need an actuall class that it can instantiate. Note, this class is annotated with @isTest to prevent it&apos;s use outside of tests, not because it contains tests.

---
## Methods
### `afterDelete()` → `void`
### `afterInsert()` → `void`
### `afterUndelete()` → `void`
### `afterupdate()` → `void`
### `beforeDelete()` → `void`
### `beforeInsert()` → `void`
### `beforeUpdate()` → `void`
---
