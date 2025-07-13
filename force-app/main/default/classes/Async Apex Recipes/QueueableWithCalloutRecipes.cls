/**
 * @description Demmonstrates the use of the Queueable interface to make
 * callouts. The methods in this class are called by the system at run time.
 * To enqueue this job and see it's results, use `System.enqueueJob(new QueueableWithCalloutRecipes());`
 *
 * More on the Queable interface:
 * https://sfdc.co/queueable-apex
 *
 * @group Async Apex Recipes
 * @see RestClient
 */
public with sharing class QueueableWithCalloutRecipes implements Queueable, Database.AllowsCallouts {
    // This allows us to cause a DML failure in execute batch, enabling testing.
    @testVisible
    private static Boolean throwError = false;
    @testVisible
    private static Boolean circuitBreakerThrown = false;

    /**
     * @description Internal custom exception class
     */
    public class QueueableWithCalloutRecipesException extends Exception {
    }

    /**
     * @description This is the only required method to implement Queueable.
     * Queueable classes that also implement Database.allowsCallouts can make
     * HTTP requests to external services. In this recipe we make a GET request
     * to developer.salesforce.com
     * @param qc dependency injected by the system
     * @example
     * ```
     * System.enqueueJob(new QueueableWithCalloutRecipes());
     * ```
     */
    public static void execute(QueueableContext qc) {
        HttpResponse response = RestClient.makeApiCall(
            'GoogleBooksAPI',
            RestClient.HttpVerb.GET,
            'volumes?q=salesforce'
        );
        List<Account> accounts = [
            SELECT Id
            FROM Account
            ORDER BY Id
            LIMIT 1000
        ];
        for (Account acct : accounts) {
            acct.Description = String.valueOf(response.getStatusCode());
        }
        if (Test.isRunningTest() && throwError) {
            accounts = (List<Account>) TestFactory.invalidateSObjectList(
                accounts
            );
        }

        try {
            update accounts;
        } catch (DmlException dmle) {
            System.debug(
                LoggingLevel.INFO,
                'real life use cases should do something more than just logging the error: ' +
                dmle.getMessage()
            );
            if (Test.isRunningTest()) {
                QueueableWithCalloutRecipes.circuitBreakerThrown = true;
            }
        }
    }
}
