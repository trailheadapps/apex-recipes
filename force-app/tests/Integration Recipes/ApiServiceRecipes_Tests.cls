@isTest
private class ApiServiceRecipes_Tests {
    @isTest
    static void testConstructorAssignsNamedCredentialPositive() {
        Test.startTest();
        ApiServiceRecipes api = new ApiServiceRecipes();
        Test.stopTest();

        System.assert(
            api.namedCredentialName == 'MockBin',
            'Expected constructor to create an instance that specifies the named credentialname'
        );
    }

    @isTest
    static void testGetCurrentDataPositive200() {
        ApiServiceRecipes api = new ApiServiceRecipes();
        HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
            200,
            'OK',
            ApiServiceRecipesDataModel_Tests.testJSON,
            new Map<string, string>()
        );
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        // execute on the api instance
        List<ApiServiceRecipesDataModel> results = api.getCurrentData();
        Test.stopTest();

        for (ApiServiceRecipesDataModel obj : results) {
            System.assertNotEquals(
                null,
                obj.exampleArray,
                'exampleArray should not be null'
            );
            System.assertNotEquals(
                null,
                obj.exampleBoolean,
                'exampleBoolean should not be null'
            );
            System.assertNotEquals(
                null,
                obj.exampleColor,
                'exampleColor should not be null'
            );
            System.assertNotEquals(
                null,
                obj.exampleNumber,
                'exampleNumber should not be null'
            );
            System.assertNotEquals(
                null,
                obj.exampleString,
                'exampleString should not be null'
            );
            System.assertNotEquals(
                null,
                obj.exampleObject,
                'exampleObject should not be null'
            );
        }
    }

    @isTest
    static void testGetCurrentDataNegativeJSONExceptionThrown() {
        ApiServiceRecipes api = new ApiServiceRecipes();
        HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
            200,
            'OK',
            ApiServiceRecipesDataModel_Tests.testJSONBad,
            new Map<string, string>()
        );
        Test.setMock(HttpCalloutMock.class, mock);
        Boolean didCatchTheRightException = false;

        Test.startTest();
        try {
            api.getCurrentData();
        } catch (ApiServiceRecipes.ApiException apiException) {
            if (
                apiException.getMessage()
                    .containsIgnoreCase('Unexpected end-of-input')
            ) {
                didCatchTheRightException = true;
            }
        }
        System.assert(
            didCatchTheRightException,
            'Expected to have caught an Unexpected response code error'
        );
    }

    @isTest
    static void testGetCurrentDataNegative404() {
        ApiServiceRecipes api = new ApiServiceRecipes();
        HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
            404,
            'Not Found',
            '',
            new Map<string, string>()
        );
        Test.setMock(HttpCalloutMock.class, mock);
        Boolean didCatchTheRightException = false;

        Test.startTest();
        try {
            api.getCurrentData();
        } catch (ApiServiceRecipes.ApiException apiException) {
            if (apiException.getMessage().containsIgnoreCase('404 error')) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();

        System.assert(
            didCatchTheRightException,
            'Expected to see our custom exception an underlying JSON exception'
        );
    }

    @isTest
    static void testGetCurrentDataNegative500TriggersWhenElse() {
        ApiServiceRecipes api = new ApiServiceRecipes();
        HttpCalloutMockFactory mock = new HttpCalloutMockFactory(
            503,
            'Not Found',
            '',
            new Map<string, string>()
        );
        Test.setMock(HttpCalloutMock.class, mock);
        Boolean didCatchTheRightException = false;

        Test.startTest();
        try {
            api.getCurrentData();
        } catch (ApiServiceRecipes.ApiException apiException) {
            if (
                apiException.getMessage()
                    .containsIgnoreCase('unexpected response code')
            ) {
                didCatchTheRightException = true;
            }
        }
        Test.stopTest();

        System.assert(
            didCatchTheRightException,
            'Expected to see our custom exception an underlying JSON exception'
        );
    }
}
