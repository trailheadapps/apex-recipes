/**
 * @description Demonstrates how to manage named credentials from Apex
 * @group Integration Recipes
 */
public with sharing class NamedCredentialRecipes {
    public static String NAMED_CREDENTIAL_LABEL = 'GoogleBooksAPI (created with Apex)';
    public static String NAMED_CREDENTIAL_DEVELOPER_NAME = 'googleBooksAPIApex';
    public static String EXTERNAL_CREDENTIAL_LABEL = 'GoogleBooksAPI (created with Apex)';
    public static String EXTERNAL_CREDENTIAL_DEVELOPER_NAME = 'googleBooksAPIApexExternal';
    public static String NAMED_CREDENTIAL_CALLOUT_URL = 'https://www.googleapis.com/books/v1';

    /**
     * @description Demonstrates how create a named credential from Apex.
     * @return ConnectApi.NamedCredential The created named credential
     * @example
     * System.debug(NamedCredentialRecipes.createNamedCredential());
     **/
    public static ConnectApi.NamedCredential createNamedCredential() {
        // Create an external credential (you could use an existing one)
        ConnectApi.ExternalCredential externalCredential = NamedCredentialRecipes.createExternalCredential();

        // Create a list of external credential inputs and add the external credential name
        List<ConnectApi.ExternalCredentialInput> externalCredentials = new List<ConnectApi.ExternalCredentialInput>();
        ConnectApi.ExternalCredentialInput externalCredentialInput = new ConnectApi.ExternalCredentialInput();
        externalCredentialInput.developerName = externalCredential.DeveloperName;
        externalCredentials.add(externalCredentialInput);

        // Create a named credential input and setup the required fields
        ConnectApi.NamedCredentialInput namedCredentialInput = new ConnectApi.NamedCredentialInput();
        namedCredentialInput.developerName = NAMED_CREDENTIAL_DEVELOPER_NAME;
        namedCredentialInput.masterLabel = NAMED_CREDENTIAL_LABEL;
        namedCredentialInput.type = ConnectApi.NamedCredentialType.SecuredEndpoint;
        namedCredentialInput.calloutUrl = NAMED_CREDENTIAL_CALLOUT_URL;
        namedCredentialInput.externalCredentials = externalCredentials;

        // Configure the named credential callout options
        ConnectApi.NamedCredentialCalloutOptionsInput calloutOptions = new ConnectApi.NamedCredentialCalloutOptionsInput();
        calloutOptions.allowMergeFieldsInBody = false;
        calloutOptions.allowMergeFieldsInHeader = false;
        calloutOptions.generateAuthorizationHeader = true;
        namedCredentialInput.calloutOptions = calloutOptions;

        // Create the named credential!
        return ConnectApi.NamedCredentials.createNamedCredential(
            namedCredentialInput
        );
    }

    /**
     * @description This example shows how to create an external credential in Apex.
     * An external credential contains the authentication and authorization information for the callout,
     * and needs to be linked to a named credential in order to be used.
     * @return ConnectApi.ExternalCredential The created external credential
     * @example
     * System.debug(NamedCredentialRecipes.createExternalCredential());
     **/
    private static ConnectApi.ExternalCredential createExternalCredential() {
        ConnectApi.ExternalCredentialInput externalCredentialInput = new ConnectApi.ExternalCredentialInput();
        externalCredentialInput.developerName = EXTERNAL_CREDENTIAL_DEVELOPER_NAME;
        externalCredentialInput.masterLabel = EXTERNAL_CREDENTIAL_LABEL;
        externalCredentialInput.authenticationProtocol = ConnectApi.CredentialAuthenticationProtocol.Custom;

        // Populate principals to connect the external credential to permissions
        ConnectApi.ExternalCredentialPrincipalInput principalInput = new ConnectApi.ExternalCredentialPrincipalInput();
        principalInput.principalName = 'Developer Access';
        principalInput.principalType = ConnectApi.CredentialPrincipalType.NamedPrincipal;
        principalInput.sequenceNumber = 1;
        principalInput.parameters = new List<ConnectApi.ExternalCredentialParameterInput>();

        externalCredentialInput.principals = new List<ConnectApi.ExternalCredentialPrincipalInput>{
            principalInput
        };

        // Create external credential
        ConnectApi.ExternalCredential externalCredential = ConnectApi.NamedCredentials.createExternalCredential(
            externalCredentialInput
        );

        // Give access to named principal on permission set
        // Reload principal to get its id
        ConnectApi.ExternalCredentialPrincipal principal = ConnectApi.NamedCredentials.getExternalCredential(
                EXTERNAL_CREDENTIAL_DEVELOPER_NAME
            )
            .principals[0];
        // We assume you have the Apex_Recipes permission set assigned
        Id permissionSetId = [
            SELECT Id
            FROM PermissionSet
            WHERE Name = 'Apex_Recipes'
            LIMIT 1
        ]
        .Id;
        insert new SetupEntityAccess(
            ParentId = permissionSetId,
            SetupEntityId = principal.Id
        );

        return externalCredential;
    }

    // Need to enable Named Credential manually on the setup menu first
    public static void makeCalloutWithNamedCredential() {
        HttpResponse response = RestClient.makeApiCall(
            NAMED_CREDENTIAL_DEVELOPER_NAME,
            RestClient.HttpVerb.GET,
            '/volumes?q=salesforce'
        );
        System.debug(response.getBody());
    }
}
