/**
 * @description Demonstrates how to manage named credentials from Apex
 * @group Integration Recipes
 */
public with sharing class NamedCredentialRecipes {
    public static final String NAMED_CREDENTIAL_MASTER_LABEL = 'GoogleBooksAPI (created with Apex)';
    public static final String NAMED_CREDENTIAL_DEVELOPER_NAME = 'googleBooksAPIApex';
    public static final ConnectApi.NamedCredentialType NAMED_CREDENTIAL_TYPE = ConnectApi.NamedCredentialType.SecuredEndpoint;
    public static final String NAMED_CREDENTIAL_CALLOUT_URL = 'https://www.googleapis.com/books/v1';
    public static final Boolean NAMED_CREDENTIAL_ALLOW_MERGE_FIELDS_IN_BODY = false;
    public static final Boolean NAMED_CREDENTIAL_ALLOW_MERGE_FIELDS_IN_HEADER = false;
    public static final Boolean NAMED_CREDENTIAL_GENERATE_AUTH_HEADER = true;
    public static final String EXTERNAL_CREDENTIAL_MASTER_LABEL = 'GoogleBooksAPI (created with Apex)';
    public static final String EXTERNAL_CREDENTIAL_DEVELOPER_NAME = 'googleBooksAPIApexExternal';
    public static final ConnectApi.CredentialAuthenticationProtocol EXTERNAL_CREDENTIAL_AUTHENTICATION_PROTOCOL = ConnectApi.CredentialAuthenticationProtocol.Custom;
    public static final String PRINCIPAL_NAME = 'Developer Access';
    public static final ConnectApi.CredentialPrincipalType PRINCIPAL_TYPE = ConnectApi.CredentialPrincipalType.NamedPrincipal;
    public static final Integer PRINCIPAL_SEQUENCE_NUMBER = 1;

    /**
     * @description Demonstrates how create a named credential from Apex.
     * @param connectApiWrapper instance of ConnectApiWrapper, created to allow mocking
     * @param permissionSetName name of the permission set that will have access to the external credential
     * @return The created named credential
     * @example
     * ```
     * System.debug(NamedCredentialRecipes.createNamedCredential(new ConnectApiWrapper(), 'Apex_Recipes'));
     * HttpResponse response = RestClient.makeApiCall(
     *     NAMED_CREDENTIAL_DEVELOPER_NAME,
     *     RestClient.HttpVerb.GET,
     *     '/volumes?q=salesforce'
     * );
     * System.debug(response.getBody());
     * ```
     */
    public static ConnectApi.NamedCredential createNamedCredential(
        ConnectApiWrapper connectApiWrapper,
        String permissionSetName
    ) {
        // Create an external credential (you could use an existing one)
        ConnectApi.ExternalCredential externalCredential = NamedCredentialRecipes.createExternalCredential(
            connectApiWrapper,
            permissionSetName
        );

        // Create a list of external credential inputs and add the external credential name
        List<ConnectApi.ExternalCredentialInput> externalCredentials = new List<ConnectApi.ExternalCredentialInput>();
        ConnectApi.ExternalCredentialInput externalCredentialInput = new ConnectApi.ExternalCredentialInput();
        externalCredentialInput.developerName = externalCredential.DeveloperName;
        externalCredentials.add(externalCredentialInput);

        // Create a named credential input and setup the required fields
        ConnectApi.NamedCredentialInput namedCredentialInput = new ConnectApi.NamedCredentialInput();
        namedCredentialInput.developerName = NAMED_CREDENTIAL_DEVELOPER_NAME;
        namedCredentialInput.masterLabel = NAMED_CREDENTIAL_MASTER_LABEL;
        namedCredentialInput.type = NAMED_CREDENTIAL_TYPE;
        namedCredentialInput.calloutUrl = NAMED_CREDENTIAL_CALLOUT_URL;
        namedCredentialInput.externalCredentials = externalCredentials;

        // Configure the named credential callout options
        ConnectApi.NamedCredentialCalloutOptionsInput calloutOptions = new ConnectApi.NamedCredentialCalloutOptionsInput();
        calloutOptions.allowMergeFieldsInBody = NAMED_CREDENTIAL_ALLOW_MERGE_FIELDS_IN_BODY;
        calloutOptions.allowMergeFieldsInHeader = NAMED_CREDENTIAL_ALLOW_MERGE_FIELDS_IN_HEADER;
        calloutOptions.generateAuthorizationHeader = NAMED_CREDENTIAL_GENERATE_AUTH_HEADER;
        namedCredentialInput.calloutOptions = calloutOptions;

        // Create the named credential!
        return connectApiWrapper.createNamedCredential(namedCredentialInput);
    }

    /**
     * @description This example shows how to create an external credential in Apex.
     * An external credential contains the authentication and authorization information for the callout,
     * and needs to be linked to a named credential in order to be used.
     * @param connectApiWrapper instance of ConnectApiWrapper, created to allow mocking
     * @param permissionSetName name of the permission set that will have access to the external credential
     * @return The created external credential
     * @example
     * ```
     * System.debug(NamedCredentialRecipes.createExternalCredential(new ConnectApiWrapper(), 'Apex_Recipes'));
     * ```
     */
    private static ConnectApi.ExternalCredential createExternalCredential(
        ConnectApiWrapper connectApiWrapper,
        String permissionSetName
    ) {
        ConnectApi.ExternalCredentialInput externalCredentialInput = new ConnectApi.ExternalCredentialInput();
        externalCredentialInput.developerName = EXTERNAL_CREDENTIAL_DEVELOPER_NAME;
        externalCredentialInput.masterLabel = EXTERNAL_CREDENTIAL_MASTER_LABEL;
        externalCredentialInput.authenticationProtocol = EXTERNAL_CREDENTIAL_AUTHENTICATION_PROTOCOL;

        // Populate principals to connect the external credential to permissions
        ConnectApi.ExternalCredentialPrincipalInput principalInput = new ConnectApi.ExternalCredentialPrincipalInput();
        principalInput.principalName = PRINCIPAL_NAME;
        principalInput.principalType = PRINCIPAL_TYPE;
        principalInput.sequenceNumber = PRINCIPAL_SEQUENCE_NUMBER;

        externalCredentialInput.principals = new List<ConnectApi.ExternalCredentialPrincipalInput>{
            principalInput
        };

        // Create external credential
        ConnectApi.ExternalCredential externalCredential = connectApiWrapper.createExternalCredential(
            externalCredentialInput
        );

        if (!Test.isRunningTest()) {
            // Tests should skip giving permission set access, as principal doesn't really exist
            // Reload principal to get its id
            List<ConnectApi.ExternalCredentialPrincipal> principals = connectApiWrapper.getExternalCredential(
                    EXTERNAL_CREDENTIAL_DEVELOPER_NAME
                )
                .principals;

            PermissionSet permissionSet = [
                SELECT Id
                FROM PermissionSet
                WHERE Name = :permissionSetName
                WITH USER_MODE
                LIMIT 1
            ];

            if (permissionSet != null) {
                // Give access to named principal on permission set
                insert as user new SetupEntityAccess(
                    ParentId = permissionSet.Id,
                    SetupEntityId = principals[0].Id
                );
            }
        }

        return externalCredential;
    }
}
