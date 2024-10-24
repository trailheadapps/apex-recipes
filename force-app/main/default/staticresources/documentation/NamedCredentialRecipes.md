# NamedCredentialRecipes

Demonstrates how to manage named credentials from Apex


**Group** Integration Recipes

## Fields

### `public NAMED_CREDENTIAL_MASTER_LABEL` → `String`


### `public NAMED_CREDENTIAL_DEVELOPER_NAME` → `String`


### `public NAMED_CREDENTIAL_TYPE` → `ConnectApi.NamedCredentialType`


### `public NAMED_CREDENTIAL_CALLOUT_URL` → `String`


### `public NAMED_CREDENTIAL_ALLOW_MERGE_FIELDS_IN_BODY` → `Boolean`


### `public NAMED_CREDENTIAL_ALLOW_MERGE_FIELDS_IN_HEADER` → `Boolean`


### `public NAMED_CREDENTIAL_GENERATE_AUTH_HEADER` → `Boolean`


### `public EXTERNAL_CREDENTIAL_MASTER_LABEL` → `String`


### `public EXTERNAL_CREDENTIAL_DEVELOPER_NAME` → `String`


### `public EXTERNAL_CREDENTIAL_AUTHENTICATION_PROTOCOL` → `ConnectApi.CredentialAuthenticationProtocol`


### `public PRINCIPAL_NAME` → `String`


### `public PRINCIPAL_TYPE` → `ConnectApi.CredentialPrincipalType`


### `public PRINCIPAL_SEQUENCE_NUMBER` → `Integer`


---
## Methods
### `public static ConnectApi.NamedCredential createNamedCredential(ConnectApiWrapper connectApiWrapper, String permissionSetName)`

Demonstrates how create a named credential from Apex.

#### Parameters

|Param|Description|
|---|---|
|`connectApiWrapper`|instance of ConnectApiWrapper, created to allow mocking|
|`permissionSetName`|name of the permission set that will have access to the external credential|

#### Returns

|Type|Description|
|---|---|
|`ConnectApi.NamedCredential`|ConnectApi.NamedCredential The created named credential|

#### Example
```apex
System.debug(NamedCredentialRecipes.createNamedCredential(new ConnectApiWrapper(), 'Apex_Recipes'));
HttpResponse response = RestClient.makeApiCall(
    NAMED_CREDENTIAL_DEVELOPER_NAME,
    RestClient.HttpVerb.GET,
    '/volumes?q=salesforce'
);
System.debug(response.getBody());
```


### `private static ConnectApi.ExternalCredential createExternalCredential(ConnectApiWrapper connectApiWrapper, String permissionSetName)`

This example shows how to create an external credential in Apex.
An external credential contains the authentication and authorization information for the callout,
and needs to be linked to a named credential in order to be used.

#### Parameters

|Param|Description|
|---|---|
|`connectApiWrapper`|instance of ConnectApiWrapper, created to allow mocking|
|`permissionSetName`|name of the permission set that will have access to the external credential|

#### Returns

|Type|Description|
|---|---|
|`ConnectApi.ExternalCredential`|ConnectApi.ExternalCredential The created external credential|

#### Example
```apex
System.debug(NamedCredentialRecipes.createExternalCredential(new ConnectApiWrapper(), 'Apex_Recipes'));
```


---
