# ConnectApiWrapper

Most Connect in Apex methods require access to real organization data,
* and fail unless used in test methods marked


**IsTest** (SeeAllData=true). An alternative to that, is mocking the calls to the ConnectAPI class. This class can be used to inject the ConnectAPI dependency, allowing its methods to be mocked in test classes.


**See** [NamedCredentialRecipesTest](NamedCredentialRecipesTest)

## Methods
### `public ConnectApi createExternalCredential(ConnectApi externalCredentialInput)`
### `public ConnectApi createNamedCredential(ConnectApi namedCredentialInput)`
### `public ConnectApi getExternalCredential(String developerName)`
---
