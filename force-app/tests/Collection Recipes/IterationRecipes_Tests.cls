@isTest
/**
 * @description Tests the IterationRecipes class.
 */
public class IterationRecipes_Tests {
    @isTest
    private static void iterateOnAccountList_works() {
        List<Account> accounts = new List<Account>{
            new Account(NumberOfEmployees = 2),
            new Account(NumberOfEmployees = 3),
            new Account(NumberOfEmployees = null)
        };

        Integer employeeCount = IterationRecipes.iterateOnAccountList(accounts);

        System.assertEquals(5, employeeCount);
    }

    @isTest
    private static void iterableApiClientRecipe_works() {
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

        System.assertEquals(11, records.size());
    }

    @isTest
    private static void iterableApiClientRecipe_fails_when_record_page_request_fails() {
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
            System.assert(false, 'Expected IterableApiException');
        } catch (Exception e) {
            System.assert(
                e instanceof IterableApiClient.IterableApiException,
                'Expected an instance of IterableApiException'
            );
        } finally {
            Test.stopTest();
        }
    }
}
