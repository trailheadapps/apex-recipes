@isTest
private with sharing class NamedCredentialRecipesTest {
    @isTest
    static void createNamedCredential() {
        // GIVEN
        ConnectApiWrapper connectApiWrapper = (ConnectApiWrapper) Test.createStub(
            ConnectApiWrapper.class,
            new ConnectApiWrapperMock()
        );

        // WHEN
        Test.startTest();
        ConnectApi.NamedCredential namedCredential = NamedCredentialRecipes.createNamedCredential(
            connectApiWrapper,
            'Apex_Recipes'
        );
        Test.stopTest();

        // THEN
        // Check named credential
        Assert.areEqual(
            NamedCredentialRecipes.NAMED_CREDENTIAL_DEVELOPER_NAME,
            namedCredential.developerName,
            'Expected a different developerName value'
        );
        Assert.areEqual(
            NamedCredentialRecipes.NAMED_CREDENTIAL_MASTER_LABEL,
            namedCredential.masterLabel,
            'Expected a different masterLabel value'
        );
        Assert.areEqual(
            NamedCredentialRecipes.NAMED_CREDENTIAL_TYPE,
            namedCredential.type,
            'Expected a different type value'
        );
        Assert.areEqual(
            NamedCredentialRecipes.NAMED_CREDENTIAL_CALLOUT_URL,
            namedCredential.calloutUrl,
            'Expected a different calloutUrl value'
        );
        Assert.areEqual(
            NamedCredentialRecipes.NAMED_CREDENTIAL_ALLOW_MERGE_FIELDS_IN_BODY,
            namedCredential.calloutOptions.allowMergeFieldsInBody,
            'Expected a different allowMergeFieldsInBody value'
        );
        Assert.areEqual(
            NamedCredentialRecipes.NAMED_CREDENTIAL_ALLOW_MERGE_FIELDS_IN_HEADER,
            namedCredential.calloutOptions.allowMergeFieldsInHeader,
            'Expected a different allowMergeFieldsInHeader value'
        );
        Assert.areEqual(
            NamedCredentialRecipes.NAMED_CREDENTIAL_GENERATE_AUTH_HEADER,
            namedCredential.calloutOptions.generateAuthorizationHeader,
            'Expected a different generateAuthorizationHeader value'
        );

        // Check external credential
        Assert.areEqual(
            1,
            namedCredential.externalCredentials.size(),
            'Expected a external credential created'
        );
        ConnectApi.ExternalCredential externalCredential = namedCredential.externalCredentials[0];
        Assert.areEqual(
            NamedCredentialRecipes.EXTERNAL_CREDENTIAL_DEVELOPER_NAME,
            externalCredential.developerName,
            'Expected a different developerName value'
        );
        Assert.areEqual(
            NamedCredentialRecipes.EXTERNAL_CREDENTIAL_MASTER_LABEL,
            externalCredential.masterLabel,
            'Expected a different masterLabel value'
        );
        Assert.areEqual(
            NamedCredentialRecipes.EXTERNAL_CREDENTIAL_AUTHENTICATION_PROTOCOL,
            externalCredential.authenticationProtocol,
            'Expected a different authenticationProtocol value'
        );

        // Check principal
        Assert.areEqual(
            1,
            externalCredential.principals.size(),
            'Expected a principal created'
        );
        ConnectApi.ExternalCredentialPrincipal principal = externalCredential.principals[0];
        Assert.areEqual(
            NamedCredentialRecipes.PRINCIPAL_NAME,
            principal.principalName,
            'Expected a different principalName value'
        );
        Assert.areEqual(
            NamedCredentialRecipes.PRINCIPAL_TYPE,
            principal.principalType,
            'Expected a different principalType value'
        );
        Assert.areEqual(
            NamedCredentialRecipes.PRINCIPAL_SEQUENCE_NUMBER,
            principal.sequenceNumber,
            'Expected a different sequenceNumber value'
        );
    }
}
