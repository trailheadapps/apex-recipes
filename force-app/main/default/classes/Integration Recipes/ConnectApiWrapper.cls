public with sharing class ConnectApiWrapper {
    public ConnectApi.ExternalCredential createExternalCredential(
        ConnectApi.ExternalCredentialInput externalCredentialInput
    ) {
        return ConnectApi.NamedCredentials.createExternalCredential(
            externalCredentialInput
        );
    }

    public ConnectApi.NamedCredential createNamedCredential(
        ConnectApi.NAmedCredentialInput namedCredentialInput
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
