---
layout: default
---
# IsFeatureEnabled class

Class contains static methods for determining if specific platform features are enabled here. For example, do we have platform cache enabled. You could also write similar methods for experiences.

---
## Methods
### `isSeeAllDataTrue()` → `Boolean`
### `platformCache()` → `Boolean`

Method determines if platform cache is enabled for this org Note: failsafes to false. Note: Allows override by setting IsFeatureEnabled.disablePlatformCache equal to true. Use this in test contexts where cache is not availble like when you have to use seeAllData=true

---
