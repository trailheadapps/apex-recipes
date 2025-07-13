# ConnectApiWrapper Class

Most Connect in Apex methods require access to real organization data, 
and fail unless used in test methods marked `@isTest(SeeAllData=true)` . 
An alternative to that, is mocking the calls to the ConnectAPI class. 
This class can be used to inject the ConnectAPI dependency, 
allowing its methods to be mocked in test classes.

**Group** Shared Code

**See** NamedCredentialRecipesTest

## Methods
### `createExternalCredential(externalCredentialInput)`

#### Signature
```apex
public ConnectApi.ExternalCredential createExternalCredential(ConnectApi.ExternalCredentialInput externalCredentialInput)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| externalCredentialInput | ConnectApi.ExternalCredentialInput |  |

#### Return Type
**ConnectApi.ExternalCredential**

---

### `createNamedCredential(namedCredentialInput)`

#### Signature
```apex
public ConnectApi.NamedCredential createNamedCredential(ConnectApi.NamedCredentialInput namedCredentialInput)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| namedCredentialInput | ConnectApi.NamedCredentialInput |  |

#### Return Type
**ConnectApi.NamedCredential**

---

### `getExternalCredential(developerName)`

#### Signature
```apex
public ConnectApi.ExternalCredential getExternalCredential(String developerName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| developerName | String |  |

#### Return Type
**ConnectApi.ExternalCredential**