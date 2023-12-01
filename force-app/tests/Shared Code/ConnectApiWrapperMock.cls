@isTest
public class ConnectApiWrapperMock implements System.StubProvider {
    public static ConnectApi.NamedCredential namedCredential = new ConnectApi.NamedCredential();
    public static ConnectApi.ExternalCredential externalCredential = new ConnectApi.ExternalCredential();

    @SuppressWarnings('PMD.ExcessiveParameterList') // This is just a mock!
    public Object handleMethodCall(
        Object stubbedObject,
        String stubbedMethodName,
        Type returnType,
        List<Type> listOfParamTypes,
        List<String> listOfParamNames,
        List<Object> listOfArgs
    ) {
        switch on stubbedMethodName {
            when 'createExternalCredential' {
                ConnectApi.ExternalCredentialInput externalCredentialInput = (ConnectApi.ExternalCredentialInput) listOfArgs[0];
                externalCredential.developerName = externalCredentialInput.developerName;
                externalCredential.masterLabel = externalCredentialInput.masterLabel;
                externalCredential.authenticationProtocol = externalCredentialInput.authenticationProtocol;
                externalCredential.principals = new List<ConnectApi.ExternalCredentialPrincipal>();
                for (
                    ConnectApi.ExternalCredentialPrincipalInput principalInput : externalCredentialInput.principals
                ) {
                    ConnectApi.ExternalCredentialPrincipal principal = new ConnectApi.ExternalCredentialPrincipal();
                    principal.principalName = principalInput.principalName;
                    principal.principalType = principalInput.principalType;
                    principal.sequenceNumber = principalInput.sequenceNumber;
                    externalCredential.principals.add(principal);
                }

                return externalCredential;
            }
            when 'createNamedCredential' {
                ConnectApi.NamedCredentialInput namedCredentialInput = (ConnectApi.NamedCredentialInput) listOfArgs[0];
                namedCredential.developerName = namedCredentialInput.developerName;
                namedCredential.masterLabel = namedCredentialInput.masterLabel;
                namedCredential.type = namedCredentialInput.type;
                namedCredential.calloutUrl = namedCredentialInput.calloutUrl;
                namedCredential.calloutOptions = new ConnectApi.NamedCredentialCalloutOptions();
                namedCredential.calloutOptions.allowMergeFieldsInBody = namedCredentialInput.calloutOptions.allowMergeFieldsInBody;
                namedCredential.calloutOptions.allowMergeFieldsInHeader = namedCredentialInput.calloutOptions.allowMergeFieldsInHeader;
                namedCredential.calloutOptions.generateAuthorizationHeader = namedCredentialInput.calloutOptions.generateAuthorizationHeader;
                namedCredential.externalCredentials = new List<ConnectApi.ExternalCredential>{
                    externalCredential
                };
                return namedCredential;
            }
            when 'getExternalCredential' {
                return externalCredential;
            }
        }
        return null;
    }
}
