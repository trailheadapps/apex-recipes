/**
 * @description This class provides an example of an intelligent abstraction for
 * making REST callouts to external endpoints. It utilizes NamedCredentials
 * for security. This class is designated as Virtual so that
 * API Service classes can extend it, and make use of it's methods easily.
 * See the CovidTrackerAPI class for an example of how an API service class
 * can extend RestClient.
 *
 * This class also provides static methods - so that the abstractions
 * provided can be used in a one-off or ad-hoc manner for situations
 * where a full API Service class isn't needed.
 *
 * More on Named Credentials:
 * https://sfdc.co/named-credentials
 *
 *
 * @group Shared Code
 * @see AtFutureRecipes
 * @see QueueableWithCalloutRecipes
 * @see ApiServiceRecipes
 * @see CalloutRecipes
 */
public virtual class RestClient {
    /**
     * These two properties are not public - which means that in
     * order to manipulate them during a Unit test, we have to
     * mark them @testVisible
     *
     * The namedCredentialName also demonstrates how to auto
     * create a getter/setter for a property with the
     * {get;set;} syntax
     */

    /**
     * @description The default headers to use, when none are specified
     */
    @testVisible
    private static Map<String, String> defaultHeaders = new Map<String, String>{
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
    };

    /**
     * @description The name of the Named Credential to use
     */
    @testVisible
    protected String namedCredentialName { get; set; }

    /**
     * @description This ENUM lists possible HTTP Verbs. Note: 'Delete' is an Apex Keyword (DML)
     * and as a result, the ENUM value 'DEL' is used for delete.
     */
    public enum HttpVerb {
        GET,
        POST,
        PATCH,
        PUT,
        HEAD,
        DEL
    }

    /**
     * @description Constructor that sets Named Credential
     * @param  namedCredential name of the Named Credential to use
     */
    public RestClient(String namedCredential) {
        this.namedCredentialName = namedCredential;
    }

    /**
     * @description This constructor isn't intended for use, which is why it's
     * access modifier is 'Protected'. However, any child class extending
     * this class will either have to implement constructors matching the one
     * above, or this constructor must exist. In order to make this abstraction
     * as useful as possible, we've elected to leave this constructor here,
     * but unavailable to anything but inner classes and classes that
     * extend this one.
     */
    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected RestClient() {
    }

    /**
     * @description Omnibus callout method. This is the primary method for
     * making a REST callout. Most of the other methods in this class serve
     * as convient, syntactic sugar on this method.
     * @param   method Enum HTTP verb to use. i.e. GET
     * @param   path patch component of the callout url i.e. `/services/data/v39.0/SObjects`
     * @param   query Query portion of the URL i.e. `?q=SELECT Id FROM Account`
     * @param   body JSON string representing the body of the callout in post/patch situations
     * @param   headers A map<String,String> of headers to use while making this callout
     */
    @testVisible
    @SuppressWarnings('PMD.ExcessiveParameterList')
    protected HttpResponse makeApiCall(
        HttpVerb method,
        String path,
        String query,
        String body,
        Map<String, String> headers
    ) {
        path = ensureStringEndsInSlash(path);
        String encodedQuery = EncodingUtil.urlEncode(query, 'UTF-8');
        if (method == HttpVerb.PATCH) {
            method = HttpVerb.POST;
            encodedQuery += '?_HttpMethod=PATCH';
        }
        HttpRequest apiRequest = new HttpRequest();
        if (method == HttpVerb.DEL) {
            apiRequest.setMethod('DELETE');
        } else {
            apiRequest.setMethod(String.valueOf(method));
        }
        Map<String, String> functionalHeaders = (headers != null)
            ? headers
            : RestClient.defaultHeaders;
        for (String header : functionalHeaders.keySet()) {
            apiRequest.setHeader(header, functionalHeaders.get(header));
        }
        if (
            String.isNotBlank(body) &&
            (method == HttpVerb.POST ||
            method == HttpVerb.PUT ||
            method == HttpVerb.PATCH)
        ) {
            apiRequest.setBody(body);
        }
        apiRequest.setEndpoint(
            'callout:' + this.namedCredentialName + path + encodedQuery
        );
        Http http = new Http();
        HttpResponse toReturn = http.send(apiRequest);
        return toReturn;
    }

    /**
     * @description  Makes an HTTP Callout to an api resource.
     * Convienence method that assumes the Default Headers.
     * @param method HTTPVerb to use. See the enum above.
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     * @param query  Query component of the URL ie: after `?foo=bar`
     * @param body   Body to send with this call.
     */
    @testVisible
    @SuppressWarnings('PMD.ExcessiveParameterList')
    protected HttpResponse makeApiCall(
        HttpVerb method,
        String path,
        String query,
        String body
    ) {
        return this.makeApiCall(
            method,
            path,
            query,
            body,
            RestClient.defaultHeaders
        );
    }

    /**
     * @description  convenience version of makeApiCall without body param.
     * Invokes omnibus version above, with blank body param and default headers.
     * @param method HTTPVerb to use. See the enum above.
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     * @param query  Query component of the URL ie: after `?foo=bar`
     */
    @testVisible
    protected HttpResponse makeApiCall(
        HttpVerb method,
        String path,
        String query
    ) {
        return this.makeApiCall(
            method,
            path,
            query,
            '',
            RestClient.defaultHeaders
        );
    }

    /**
     * @description  convenience version of makeApiCall without body or query
     * params.
     * Invokes omnibus version above, with blank body and query params
     * @param method HTTPVerb to use. See the enum above.
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     */
    @testVisible
    protected HttpResponse makeApiCall(HttpVerb method, String path) {
        return this.makeApiCall(
            method,
            path,
            '',
            '',
            RestClient.defaultHeaders
        );
    }

    /**
     * @description convenience method for a GET Call that only requires a path
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     */
    @testVisible
    protected HttpResponse get(String path) {
        return this.makeApiCall(HttpVerb.GET, path);
    }

    /**
     * @description convenience method for a GET Call that only requires a path
     * and query
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     * @param query  Query component of the URL ie: after `?foo=bar`
     */
    @testVisible
    protected HttpResponse get(String path, String query) {
        return this.makeApiCall(HttpVerb.GET, path, query);
    }

    /**
     * @description convenience method for deleteing a resource based only on
     * path
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     */
    @testVisible
    protected HttpResponse del(String path) {
        return this.makeApiCall(HttpVerb.DEL, path);
    }

    /**
     * @description convenience method for a Delete Call that only requires a
     * path and query
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     * @param query  Query component of the URL ie: after `?foo=bar`
     */
    @testVisible
    protected HttpResponse del(String path, String query) {
        return this.makeApiCall(HttpVerb.DEL, path, query);
    }

    /**
     * @description convenience method for a POST Call that only requires a path
     * and body
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     * @param body   JSON string to post
     */
    @testVisible
    protected HttpResponse post(String path, String body) {
        return this.makeApiCall(HttpVerb.POST, path, '', body);
    }

    /**
     * @description convenience method for a POST Call that only requires a
     * path, query and body
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     * @param query  Query component of the URL ie: after `?foo=bar`
     * @param body   JSON string to post
     */
    @testVisible
    protected HttpResponse post(String path, String query, String body) {
        return this.makeApiCall(HttpVerb.POST, path, query, body);
    }

    /**
     * @description convenience method for a PUT Call that only requires a path
     * and body
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     * @param body   JSON string to post
     */
    @testVisible
    protected HttpResponse put(String path, String body) {
        return this.makeApiCall(HttpVerb.PUT, path, '', body);
    }

    /**
     * @description convenience method for a PUT Call that only requires a path,
     * query and body
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     * @param query  Query component of the URL ie: after `?foo=bar`
     * @param body   JSON string to post
     */
    @testVisible
    protected HttpResponse put(String path, String query, String body) {
        return this.makeApiCall(HttpVerb.PUT, path, query, body);
    }

    /**
     * @description convenience method for a PATCH Call that only requires a
     * path, query and body
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     * @param body   JSON string to post
     */
    @testVisible
    protected HttpResponse patch(String path, String body) {
        return this.makeApiCall(HttpVerb.PATCH, path, '', body);
    }

    /**
     * @description convenience method for a PATCH Call that only requires a
     * path, query and body
     * @param path   Http path component of the URL. ie: `/path/to/resource`
     * @param query  Query component of the URL ie: after `?foo=bar`
     * @param body   JSON string to post
     */
    @testVisible
    protected HttpResponse patch(String path, String query, String body) {
        return this.makeApiCall(HttpVerb.PATCH, path, query, body);
    }

    // Private Helper Methods
    /**
     * @description Ensures that the inputted string ends in a `/`
     * makes callouts more robust.
     * @param   resource string to ensure ends in `/`
     * @return  inputted string with `/` if it didn't already end in one.
     */
    @testVisible
    protected String ensureStringEndsInSlash(String resource) {
        if (resource.endsWith('/')) {
            return resource;
        }
        return resource + '/';
    }

    /**
     * @description           A static wrapper for the main makeApiCall method
     * @param namedCredential The named credential to use
     * @param method          HTTPVerb enum value. See Enum above
     * @param path           Http path component of the URL. ie: `/path/to/resource`
     * @param query           Query component of the URL ie: after `?foo=bar`
     * @param body            JSON string to post
     * @param headers         Map<String,String> representing outgoing Request
     * headers
     * @example
     * ```
     * System.Debug(RestClient.makeApiCall('GoogleBooksAPI',
     *                                      RestClient.HttpVerb.GET,
     *                                      'volumes',
     *                                      'q=salesforce',
     *                                      '',
     *                                      new Map<String,String>()));
     * ```
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public static HttpResponse makeApiCall(
        String namedCredential,
        HttpVerb method,
        String path,
        String query,
        String body,
        Map<String, String> headers
    ) {
        return new RestClient(namedCredential)
            .makeApiCall(method, path, query, body, headers);
    }

    /**
     * @description           A static wrapper for the main makeApiCall method
     * that assumes default headers.
     * @param namedCredential The named credential to use
     * @param method          HTTPVerb enum value. See Enum above
     * @param path           Http path component of the URL. ie: `/path/to/resource`
     * @param query           Query component of the URL ie: after `?foo=bar`
     * @example
     * ```
     * System.Debug(RestClient.makeApiCall('GoogleBooksAPI',
     *                                      RestClient.HttpVerb.GET,
     *                                      'volumes',
     *                                      'q=salesforce'));
     * ```
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public static HttpResponse makeApiCall(
        String namedCredential,
        HttpVerb method,
        String path,
        String query
    ) {
        return new RestClient(namedCredential)
            .makeApiCall(method, path, query, '', RestClient.defaultHeaders);
    }

    /**
     * @description           A static wrapper for the main makeApiCall method
     * where you only need the path
     * @param namedCredential The named credential to use
     * @param method          HTTPVerb enum value. See Enum above
     * @param path           Http path component of the URL. ie: `/path/to/resource`
     * @example
     * ```
     * System.Debug(RestClient.makeApiCall('GoogleBooksAPI',
     *                                      RestClient.HttpVerb.GET,
     *                                      'volumes'));
     * ```
     */
    public static HttpResponse makeApiCall(
        String namedCredential,
        HttpVerb method,
        String path
    ) {
        return new RestClient(namedCredential)
            .makeApiCall(method, path, '', '', RestClient.defaultHeaders);
    }
}
