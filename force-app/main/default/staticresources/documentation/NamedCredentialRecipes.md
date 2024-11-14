# NamedCredentialRecipes Class

Demonstrates how to manage named credentials from Apex

**Group** Integration Recipes

## Fields
### `NAMED_CREDENTIAL_MASTER_LABEL`

#### Signature
```apex
public static final NAMED_CREDENTIAL_MASTER_LABEL
```

#### Type
String

---

### `NAMED_CREDENTIAL_DEVELOPER_NAME`

#### Signature
```apex
public static final NAMED_CREDENTIAL_DEVELOPER_NAME
```

#### Type
String

---

### `NAMED_CREDENTIAL_TYPE`

#### Signature
```apex
public static final NAMED_CREDENTIAL_TYPE
```

#### Type
ConnectApi.NamedCredentialType

---

### `NAMED_CREDENTIAL_CALLOUT_URL`

#### Signature
```apex
public static final NAMED_CREDENTIAL_CALLOUT_URL
```

#### Type
String

---

### `NAMED_CREDENTIAL_ALLOW_MERGE_FIELDS_IN_BODY`

#### Signature
```apex
public static final NAMED_CREDENTIAL_ALLOW_MERGE_FIELDS_IN_BODY
```

#### Type
Boolean

---

### `NAMED_CREDENTIAL_ALLOW_MERGE_FIELDS_IN_HEADER`

#### Signature
```apex
public static final NAMED_CREDENTIAL_ALLOW_MERGE_FIELDS_IN_HEADER
```

#### Type
Boolean

---

### `NAMED_CREDENTIAL_GENERATE_AUTH_HEADER`

#### Signature
```apex
public static final NAMED_CREDENTIAL_GENERATE_AUTH_HEADER
```

#### Type
Boolean

---

### `EXTERNAL_CREDENTIAL_MASTER_LABEL`

#### Signature
```apex
public static final EXTERNAL_CREDENTIAL_MASTER_LABEL
```

#### Type
String

---

### `EXTERNAL_CREDENTIAL_DEVELOPER_NAME`

#### Signature
```apex
public static final EXTERNAL_CREDENTIAL_DEVELOPER_NAME
```

#### Type
String

---

### `EXTERNAL_CREDENTIAL_AUTHENTICATION_PROTOCOL`

#### Signature
```apex
public static final EXTERNAL_CREDENTIAL_AUTHENTICATION_PROTOCOL
```

#### Type
ConnectApi.CredentialAuthenticationProtocol

---

### `PRINCIPAL_NAME`

#### Signature
```apex
public static final PRINCIPAL_NAME
```

#### Type
String

---

### `PRINCIPAL_TYPE`

#### Signature
```apex
public static final PRINCIPAL_TYPE
```

#### Type
ConnectApi.CredentialPrincipalType

---

### `PRINCIPAL_SEQUENCE_NUMBER`

#### Signature
```apex
public static final PRINCIPAL_SEQUENCE_NUMBER
```

#### Type
Integer

## Methods
### `createNamedCredential(connectApiWrapper, permissionSetName)`

Demonstrates how create a named credential from Apex.

#### Signature
```apex
public static ConnectApi.NamedCredential createNamedCredential(ConnectApiWrapper connectApiWrapper, String permissionSetName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| connectApiWrapper | [ConnectApiWrapper](https://github.com/trailheadapps/apex-recipes/wiki/ConnectApiWrapper) | instance of ConnectApiWrapper, created to allow mocking |
| permissionSetName | String | name of the permission set that will have access to the external credential |

#### Return Type
**ConnectApi.NamedCredential**

The created named credential

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

---

### `createExternalCredential(connectApiWrapper, permissionSetName)`

This example shows how to create an external credential in Apex. 
An external credential contains the authentication and authorization information for the callout, 
and needs to be linked to a named credential in order to be used.

#### Signature
```apex
private static ConnectApi.ExternalCredential createExternalCredential(ConnectApiWrapper connectApiWrapper, String permissionSetName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| connectApiWrapper | [ConnectApiWrapper](https://github.com/trailheadapps/apex-recipes/wiki/ConnectApiWrapper) | instance of ConnectApiWrapper, created to allow mocking |
| permissionSetName | String | name of the permission set that will have access to the external credential |

#### Return Type
**ConnectApi.ExternalCredential**

The created external credential

#### Example
```apex
System.debug(NamedCredentialRecipes.createExternalCredential(new ConnectApiWrapper(), 'Apex_Recipes'));
```