@isTest
/**
 * @description Tests the IterationRecipes class.
 */
public class IterationRecipes_Tests {
    @isTest
    private static void testIterateOnAccountListPositive() {
        List<Account> accounts = new List<Account>{
            new Account(NumberOfEmployees = 2),
            new Account(NumberOfEmployees = 3),
            new Account(NumberOfEmployees = null)
        };

        Integer employeeCount = IterationRecipes.iterateOnAccountList(accounts);

        System.Assert.areEqual(5, employeeCount);
    }

    @isTest
    private static void testIterableApiClientRecipePositive() {
        // Prepare mocks for REST API calls
        List<HttpResponse> responses = new List<HttpResponse>{
            HttpCalloutMockFactory.generateHttpResponse(
                200,
                'OK',
                '{"records": ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"], "totalRecordCount": 11}',
                new Map<String, String>()
            ),
            HttpCalloutMockFactory.generateHttpResponse(
                200,
                'OK',
                '{"records": ["k"], "totalRecordCount": 11}',
                new Map<String, String>()
            )
        };
        HttpCalloutMockFactory mockHttp = new HttpCalloutMockFactory(responses);
        Test.setMock(HttpCalloutMock.class, mockHttp);

        Test.startTest();
        List<String> records = IterationRecipes.iterableApiClientRecipe();
        Test.stopTest();

        System.Assert.areEqual(11, records.size());
    }

    @isTest
    private static void testIterableApiClientRecipeNegativeWhenRecordPageRequestFails() {
        HttpCalloutMockFactory mockHttp = new HttpCalloutMockFactory(
            500,
            'error',
            '',
            new Map<String, String>()
        );
        Test.setMock(HttpCalloutMock.class, mockHttp);

        try {
            Test.startTest();
            IterationRecipes.iterableApiClientRecipe();
            System.Assert.fail('Expected IterableApiException');
        } catch (Exception baseException) {
            // Ensure that we caught our custom IterableApiException exception.
            // The catch clause is voluntarily kept generic with Exception as other exceptions could be triggered.
            // We use the instanceof operator to check that baseException is an instance of IterableApiException.
            System.Assert.isInstanceOfType(
                baseException,
                IterableApiClient.IterableApiException.class,
                'Expected an instance of IterableApiException'
            );
        } finally {
            Test.stopTest();
        }
    }
}
