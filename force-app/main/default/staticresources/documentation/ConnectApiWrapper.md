# ConnectApiWrapper

Most Connect in Apex methods require access to real organization data,
and fail unless used in test methods marked `@isTest(SeeAllData=true)`.
An alternative to that, is mocking the calls to the ConnectAPI class.
This class can be used to inject the ConnectAPI dependency,
allowing its methods to be mocked in test classes.


**Group** Shared Code


**See** [NamedCredentialRecipesTest](NamedCredentialRecipesTest)

## Methods
### `public ConnectApi.ExternalCredential createExternalCredential(ConnectApi.ExternalCredentialInput externalCredentialInput)`
### `public ConnectApi.NamedCredential createNamedCredential(ConnectApi.NAmedCredentialInput namedCredentialInput)`
### `public ConnectApi.ExternalCredential getExternalCredential(String developerName)`
---
