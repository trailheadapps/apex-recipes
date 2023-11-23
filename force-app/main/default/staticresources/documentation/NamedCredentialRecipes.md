# NamedCredentialRecipes

Demonstrates how to manage named credentials from Apex


**Group** Integration Recipes

## Fields

### `public EXTERNAL_CREDENTIAL_DEVELOPER_NAME` → `String`


### `public EXTERNAL_CREDENTIAL_LABEL` → `String`


### `public NAMED_CREDENTIAL_CALLOUT_URL` → `String`


### `public NAMED_CREDENTIAL_DEVELOPER_NAME` → `String`


### `public NAMED_CREDENTIAL_LABEL` → `String`


---
## Methods
### `public static ConnectApi createNamedCredential()`

Demonstrates how create a named credential from Apex.

#### Returns

|Type|Description|
|---|---|
|`ConnectApi`|ConnectApi.NamedCredential The created named credential|

#### Example
```apex
System.debug(NamedCredentialRecipes.createNamedCredential());
```


### `private static ConnectApi createExternalCredential()`

This example shows how to create an external credential in Apex. An external credential contains the authentication and authorization information for the callout, and needs to be linked to a named credential in order to be used.

#### Returns

|Type|Description|
|---|---|
|`ConnectApi`|ConnectApi.ExternalCredential The created external credential|

#### Example
```apex
System.debug(NamedCredentialRecipes.createExternalCredential());
```


### `public static void makeCalloutWithNamedCredential()`

Demonstrates how tu use the programmatically created named credential

#### Returns

|Type|Description|
|---|---|
|`void`|void|

#### Example
```apex
After having executed NamedCredentialRecipes.createNamedCredential(); and
having enable the created Named Credential manually on the setup menu, execute:
System.debug(NamedCredentialRecipes.makeCalloutWithNamedCredential());
```


---
