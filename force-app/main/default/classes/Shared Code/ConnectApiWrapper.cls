/**
 * @description Most Connect in Apex methods require access to real organization data,
 * and fail unless used in test methods marked `@isTest(SeeAllData=true)`.
 * An alternative to that, is mocking the calls to the ConnectAPI class.
 * This class can be used to inject the ConnectAPI dependency,
 * allowing its methods to be mocked in test classes.
 * @group Shared Code
 * @see NamedCredentialRecipesTest
 */
public with sharing class ConnectApiWrapper {
    public ConnectApi.ExternalCredential createExternalCredential(
        ConnectApi.ExternalCredentialInput externalCredentialInput
    ) {
        return ConnectApi.NamedCredentials.createExternalCredential(
            externalCredentialInput
        );
    }

    public ConnectApi.NamedCredential createNamedCredential(
        ConnectApi.NamedCredentialInput namedCredentialInput
    ) {
        return ConnectApi.NamedCredentials.createNamedCredential(
            namedCredentialInput
        );
    }

    public ConnectApi.ExternalCredential getExternalCredential(
        String developerName
    ) {
        return ConnectApi.NamedCredentials.getExternalCredential(developerName);
    }
}
