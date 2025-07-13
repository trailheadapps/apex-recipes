@isTest
public class HttpCalloutMockFactory implements HttpCalloutMock {
    // Holds a list of HTTP Response objects to return.
    protected List<HttpResponse> responseQueue = new List<HttpResponse>();

    /**
     * @description This constructor builds a single response that will be returned by the mock
     * @param code HTTP status code (200, 201, 301, 302, 400, 404, 503, etc)
     * @param status HTTP text status. ie: "ok" for 200
     * @param bodyAsString This is the string that will be returned as the body
     * @param headers a map of headers applied to the response object
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public HttpCalloutMockFactory(
        Integer code,
        String status,
        String bodyAsString,
        Map<String, String> headers
    ) {
        this.responseQueue.add(
            HttpCalloutMockFactory.generateHttpResponse(
                code,
                status,
                bodyAsString,
                headers
            )
        );
    }

    /**
     * @description This constructor accepts a list of HTTP responses to be returned.
     * @param orderedResponses HTTP status code (200, 201, 301, 302, 400, 404, 503, etc)
     */
    public HttpCalloutMockFactory(List<HttpResponse> orderedResponses) {
        this.responseQueue = orderedResponses;
    }

    /**
     * @description `setMock` can only be called once per test so to enable mocking
     * multiple callouts, this response method removes the first reponse from the queue
     * and returns that. Additional callouts will respond with the next first items.
     * @param request injected by the system but we don't use it in this mock.
     * @return First mock reponse in the queue.
     */
    public HttpResponse respond(HttpRequest request) {
        if (this.responseQueue.size() > 0) {
            return this.responseQueue.remove(0);
        }
        throw new HttpCalloutMockException('Mock reponse queue is empty.');
    }

    /**
     * @description Required method for the `HttpCalloutMock` interface
     * @param code         Response status code - 200, 301, 404 etc.
     * @param status       Response status label: 'OK' or 'Server Error'
     * @param bodyAsString Reponse body
     * @param headers      Reponse headers
     * @return the assembled response
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public static HttpResponse generateHttpResponse(
        Integer code,
        String status,
        String bodyAsString,
        Map<String, String> headers
    ) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(code);
        res.setStatus(status);
        res.setBody(bodyAsString);
        for (String headerKey : headers.keySet()) {
            res.setHeader(headerKey, headers.get(headerKey));
        }
        return res;
    }

    public class HttpCalloutMockException extends Exception {
    }
}
