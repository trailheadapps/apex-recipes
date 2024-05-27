# OrgShape

Class contains static methods for determining if specific
platform features are enabled. For example, do we have platform cache
enabled. You could also write similar methods for experiences.


**Group** Shared Code

## Fields

### `private orgShape` → `Organization`

`TESTVISIBLE` 

### `private safeDefaultCachePartition` → `Cache`

`TESTVISIBLE` 

---
## Properties

### `public getFiscalYearStartMonth` → `Integer`


returns this org's fiscal year starting month

### `public hasNamespacePrefix` → `Boolean`


reports whether this transaction took place in an org with a namespace prefix

### `public id` → `Id`


reports the org's ID. in practice, this is a constant

### `public instanceName` → `String`


returns the instance name. In practice not null.

### `public isReadOnly` → `Boolean`


reports the read-only status. this is a proxy for 'is this org active'

### `public isSandbox` → `Boolean`


property reports whether this transaction took place in a sandbox.

### `public lightningEnabled` → `Boolean`


reports the users' displayed theme.

### `public locale` → `String`


reports the org's locale

### `public multiCurrencyEnabled` → `Boolean`


reports whether or not this transaction took place in an org with multiCurrency enabled. Note: I have no idea why the underlying method is on UserInfo.

### `public name` → `String`


reports the org's name

### `public namespacePrefix` → `String`


reports the namespace prefix of this org. May return null;

### `public orgType` → `String`


reports this org's type. ie: 'Developer Edition'

### `public podName` → `String`


convenience method. Alias for instanceName

### `public timeZoneKey` → `String`


reports the timeZoneSidKey

---
## Methods
### `public Boolean isPlatformCacheEnabled()`

Method determines if platform cache is enabled for this org Note: fail-safes to false. Note: Allows override by setting OrgShape.disablePlatformCache equal to true. Use this in test contexts where cache is not available like when you have to use seeAllData=true

#### Returns

|Type|Description|
|---|---|
|`Boolean`|`Boolean`|

### `public Boolean isSeeAllDataTrue()`

Certain features of the platform are incompatible with data-siloed tests. These features require testing with the annotation

#### Returns

|Type|Description|
|---|---|
|`Boolean`|`Boolean`|


**Test** (seeAllData=true). Other platform features are incompatible with seeAllData=true. When used in a test context, this method determines if the currently running test is executing with, or without seeAllData=true. This method is therefore used to automatically disable platform features that require are incompatible with seeAllData=true. For example: platform cache is incompatible with seeAllData=true. However, our security library, CanTheUser utilizes platform cache to accelerate Crud and FLS checks. CanTheUser uses this method, in part, to determine, transparently if it should utilize platformCache during test execution Note: It is not a good idea, and against best practices to use seeAllData=true when not absolutely necessary.

### `private Cache getAvailableOrgCachePartition()`

`SUPPRESSWARNINGS`

This method is responsible for discovering a cache partition that can be used for determining if platformCache is enabled and configured. Note: This method memoizes the result of the query, ensuring that the underlying soql query is only ever run once per transaction.

#### Returns

|Type|Description|
|---|---|
|`Cache`|`String`|

### `public Boolean isAdvancedMultiCurrencyManagementEnabled()`

Uses a dynamic soql query to determine if Advanced MultiCurrency Management is enabled. Note, this must be a dynamic soql query because referencing DatedConversionRate will not compile in orgs without Advanced MultiCurrency Management enabled. Note: This was originally written by the NPSP team and can be found here: https://github.com/SalesforceFoundation/NPSP/blob/aad20ffb747ecda9a037c4bce9cd19617b6a727b/src/classes/UTIL_Currency.cls#L79

#### Returns

|Type|Description|
|---|---|
|`Boolean`|`Boolean`|

### `private Organization getOrgShape()`

`SUPPRESSWARNINGS`

Private method that memoizes the query result Suppressing the PMD warning to validate crud permissions before DML, because the Organization Object is always available.

#### Returns

|Type|Description|
|---|---|
|`Organization`|`Organization`|

### `private Organization getOrgRecord()`

`SUPPRESSWARNINGS`

Private method for pulling the Organization record Note: We're suppressing PMD warning on Crud Checking because we want everyone to be able to pull this read-only record.

---
## Classes
### CachedOrgShape

**Implemented types**

[Cache.CacheBuilder](Cache.CacheBuilder)

#### Methods
##### `public Organization doLoad(String requiredButNotUsed)`

`SUPPRESSWARNINGS`

Note: We're suppressing PMD warning on Crud Checking because we want everyone to be able to pull this read-only record.

---

---
