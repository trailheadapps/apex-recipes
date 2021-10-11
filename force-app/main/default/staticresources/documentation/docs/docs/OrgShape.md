---
layout: default
---
# OrgShape class

Class contains static methods for determining if specific platform features are enabled. For example, do we have platform cache enabled. You could also write similar methods for experiences.

---
## Properties

### `getFiscalYearStartMonth` → `Integer`

returns this org&apos;s fiscal year starting month

### `hasNamespacePrefix` → `Boolean`

reports whether this transaction took place in an org with a namespace prefix

### `id` → `Id`

reports the org&apos;s ID. in practice, this is a constant

### `instanceName` → `String`

returns the instance name. In practice not null.

### `isReadOnly` → `Boolean`

reports the read-only status. this is a proxy for &apos;is this org active&apos;

### `isSandbox` → `Boolean`

property reports whether this transaction took place in a sandbox.

### `lightningEnabled` → `Boolean`

reports the users&apos; displayed theme.

### `locale` → `String`

reports the org&apos;s locale

### `multiCurrencyEnabled` → `Boolean`

reports whether or not this transaction took place in an org with multiCurrency enabled. Note: I have no idea why the underlying method is on UserInfo.

### `name` → `String`

reports the org&apos;s name

### `namespacePrefix` → `String`

reports the namespace prefix of this org. May return null;

### `orgShape` → `Organization`

### `orgType` → `String`

reports this org&apos;s type. ie: &apos;Developer Edition&apos;

### `podName` → `String`

convenience method. Alias for instanceName

### `safeDefaultCachePartition` → `Cache.OrgPartition`

### `timeZoneKey` → `String`

reports the timeZoneSidKey

---
## Methods
### `getAvailableOrgCachePartition()` → `Cache.OrgPartition`

This method is responsible for discovering a cache partition that can be used for determining if platformCache is enabled and configured. Note: This method memoizes the result of the query, ensuring that the underlying soql query is only ever run once per transaction.

#### Return

**Type**

Cache.OrgPartition

**Description**

`String`

### `getOrgRecord()` → `Organization`

Private method for pulling the Organization record Note: We&apos;re suppressing PMD warning on Crud Checking because we want everyone to be able to pull this read-only record.

### `getOrgShape()` → `Organization`

Private method that memoizes the query result Suppressing the PMD warning to validate crud permissions before DML, because the Organization Object is always available.

#### Return

**Type**

Organization

**Description**

`Organization`

### `isAdvancedMultiCurrencyManagementEnabled()` → `Boolean`

Uses a dynamic soql query to determine if Advanced MultiCurrency Management is enabled. Note, this must be a dynamic soql query because referencing DatedConversionRate will not compile in orgs without Advanced MultiCurrency Management enabled. Note: This was originally written by the NPSP team and can be found here: https://github.com/SalesforceFoundation/NPSP/blob/aad20ffb747ecda9a037c4bce9cd19617b6a727b/src/classes/UTIL_Currency.cls#L79

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `isPlatformCacheEnabled()` → `Boolean`

Method determines if platform cache is enabled for this org Note: fail-safes to false. Note: Allows override by setting OrgShape.disablePlatformCache equal to true. Use this in test contexts where cache is not available like when you have to use seeAllData=true

#### Return

**Type**

Boolean

**Description**

`Boolean`

### `isSeeAllDataTrue()` → `Boolean`

Certain features of the platform are incompatible with data-siloed tests. These features require testing with the annotation @test(seeAllData=true). Other platform features are incompatible with seeAllData=true. When used in a test context, this method determines if the currently running test is executing with, or without seeAllData=true. This method is therefore used to automatically disable platform features that require are incompatible with seeAllData=true. For example: platform cache is incompatible with seeAllData=true. However, our security library, CanTheUser utilizes platform cache to accelerate Crud and FLS checks. CanTheUser uses this method, in part, to determine, transparently if it should utilize platformCache during test execution Note: It is not a good idea, and against best practices to use seeAllData=true when not absolutely necessary.

#### Return

**Type**

Boolean

**Description**

`Boolean`

---
## Inner Classes

### OrgShape.CachedOrgShape class
---
#### Methods
##### `doLoad(String requiredButNotUsed)` → `Organization`

 Note: We&apos;re suppressing PMD warning on Crud Checking because we want everyone to be able to pull this read-only record.

---
