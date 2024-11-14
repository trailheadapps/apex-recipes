# QuiddityGuard Class

contains methods and static lists for rapid acceptence of a 
particular set of quiddities

**Group** Quiddity Recipes

## Fields
### `testQuiddityOverride`

`TESTVISIBLE`

a private testvisible variable allowing developers to 
inject a custom quiddity value during test execution.

#### Signature
```apex
private static testQuiddityOverride
```

#### Type
Quiddity

---

### `trustedQuiddities`

a non-exhaustive list of Quiddities that do not include user 
situations where users could be injecting malicious data.

#### Signature
```apex
public static trustedQuiddities
```

#### Type
List&lt;Quiddity&gt;

---

### `trustedTestQuiddities`

An exaustive list of quiddities that are valid for a test 
execution

#### Signature
```apex
public static trustedTestQuiddities
```

#### Type
List&lt;Quiddity&gt;

---

### `untrustedQuiddities`

A list of quiddities that may include user-defined data and 
therefore should not be trusted without manual FLS/CRUD checks

#### Signature
```apex
public static untrustedQuiddities
```

#### Type
List&lt;Quiddity&gt;

## Methods
### `isAcceptableQuiddity(acceptableQuiddites)`

A method to determine if the current Quiddity context is 
within a caller-supplied list of acceptable quiddity values.

#### Signature
```apex
public static Boolean isAcceptableQuiddity(List<Quiddity> acceptableQuiddites)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| acceptableQuiddites | List&lt;Quiddity&gt; | A list of quiddities to check against |

#### Return Type
**Boolean**

---

### `isNotAcceptableQuiddity(acceptableQuiddites)`

#### Signature
```apex
public static Boolean isNotAcceptableQuiddity(List<Quiddity> acceptableQuiddites)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| acceptableQuiddites | List&lt;Quiddity&gt; |  |

#### Return Type
**Boolean**