/**
 * @description Demonstrates an interable REST API client that loads paginated records (strings) thanks to an iterator
 */
public with sharing class IterableApiClient extends RestClient implements Iterable<RecordPage> {
    private static final Integer RESPONSE_PAGE_SIZE = 10;

    /**
     * @description Public custom exception class
     */
    public class IterableApiException extends Exception {
    }

    /**
     * @description Constructor accepting a named credential.
     * @param namedCredential name of the Named Credential to use
     */
    public IterableApiClient(String namedCredential) {
        super(namedCredential);
    }

    /**
     * @description Returns an iterator on RecordPage
     * (as required by the Iterable interface)
     */
    public Iterator<RecordPage> iterator() {
        return new RecordPageIterator(this);
    }

    /**
     * @description Internal method that issues a REST request to read a record page
     * @return A page with a list of records
     */
    private RecordPage getRecordPage(Integer pageIndex) {
        HttpResponse response = this.get(
            '/records?page-size=' + RESPONSE_PAGE_SIZE + '&page=' + pageIndex
        );
        Integer statusCode = response.getStatusCode();
        if (statusCode == 200) {
            return (RecordPage) JSON.deserializeStrict(
                response.getBody(),
                RecordPage.class
            );
        }
        throw new IterableApiException(
            'Failed to retrieve record page ' +
                pageIndex +
                ': HTTP ' +
                statusCode +
                ' ' +
                response.getStatus()
        );
    }

    /**
     * @description Custom Iterator used to navigate IterableApiClient responses as RecordPage.
     * The iterator keeps track on the iteration state with currentPageIndex and totalRecordCount.
     * It uses IterableApiClient to perform REST requests to load the record pages.
     */
    public class RecordPageIterator implements Iterator<RecordPage> {
        private IterableApiClient client;
        private Integer currentPageIndex;
        private Integer totalRecordCount;

        private RecordPageIterator(IterableApiClient client) {
            this.client = client;
            this.currentPageIndex = 0;
            this.totalRecordCount = null; // We don't know yet how many records are available
        }

        public Boolean hasNext() {
            return this.totalRecordCount == null ||
                this.currentPageIndex * RESPONSE_PAGE_SIZE <
                this.totalRecordCount;
        }

        public RecordPage next() {
            RecordPage page = client.getRecordPage(this.currentPageIndex);
            this.currentPageIndex++;
            this.totalRecordCount = page.totalRecordCount;
            return page;
        }
    }

    /**
     * @description Public class used for JSON deserialization of record page response
     */
    public class RecordPage {
        private List<String> records;
        private Integer totalRecordCount;

        public List<String> getRecords() {
            return this.records;
        }
    }
}
