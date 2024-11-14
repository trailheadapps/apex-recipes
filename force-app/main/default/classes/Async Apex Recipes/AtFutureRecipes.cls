/**
 * @description Demonstrates the `@future` syntax and usage
 * @group Async Apex Recipes
 */
public with sharing class AtFutureRecipes {
    /**
     * @description This class features a 'circuit breaker' variable. While this is not a
     * pattern I routinely turn to, it is a valuable pattern for testing code
     * that is otherwise hard to test. For instance, `@future` methods must be
     * static void methods. This makes it hard to assert against return values.
     * The idea behind this pattern is set a private static class variable to
     * true, only when irreversible conditions or actions have occurred. The
     * circuit breaker 'breaks', giving you something you can assert on. Again
     * this isn't a pattern I *often* turn to, but it can be valuable in certain
     * circumstances.
     */
    @testVisible
    private static Boolean testCircuitBreaker = false;
    /**
     * @description Method demonstrates the `@future` annotation without the
     * `(callout=true)` adendum. This method will be run in a different Apex
     * transaction than the calling code.
     * @param data String to be logged
     * @example
     * ```
     * AtFutureRecipes.atFutureMethodWithoutCalloutPrivileges('Some Data');
     * ```
     */
    @future
    public static void atFutureMethodWithoutCalloutPrivileges(String data) {
        // this runs in the future!in a separate Apex transaction from the
        // calling code
        System.debug(LoggingLevel.INFO, '\n\nOur Data is: \n' + data);
        AtFutureRecipes.testCircuitBreaker = true;
    }

    /**
     * @description Method demonstrates how an `@future` anotated method can make
     * an HTTP Callout. This method also demonstrates the necessary steps to
     * make an HTTP callout without the RestClient abstraction layer.
     *
     * The RestClient class can be found in the 'Shared Code' group.
     *
     * @param url       The URL to make a callout to.
     * @example
     * ```
     * AtFutureRecipes.atFutureMethodWithCalloutPrivileges('google.com');
     * ```
     */
    @future(callout=true)
    public static void atFutureMethodWithCalloutPrivileges(String url) {
        // This is the bare minimum code needed to make a HTTP callout without
        // using our RestClient abstraction. These next few lines could be
        // replaced with this RestClient call:
        // HttpResponse response = RestClient.makeApiCall('NamedCredentialName',
        //      RestClient.GET, '/');
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://' + url);
        request.setMethod('GET');

        HttpResponse response = h.send(request);
        /**
         * This is the point in which you would interact with the response you
         * receive because this recipe is intended only to demonstrate making a
         * callout from an @future annotated method, we'll stop here.
         * However, we do want to demonstrate throwing an exception if the
         * callout fails
         */

        if (response.getStatusCode() != 200) {
            AtFutureRecipes.testCircuitBreaker = true;
        }
    }
}
