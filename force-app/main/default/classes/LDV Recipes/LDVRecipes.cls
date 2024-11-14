/**
 * @description A demonstration recipe for how to process a large amount of
 * records in serial chunks using Queueables. The idea behind this recipe
 * is that Queueables, in production, have no max-queue depth. Meaning that so
 * long as you only enqueue one new queueable, it can keep cycling through until
 * the entire data set is processed. This is useful for instance, when you want
 * to process hundreds of thousands of records.
 *
 * Note: You're not able to re-enqueue within a test context, so the unit test
 * for this code is limited to the same number of records as chunkSize below.
 *
 * Note: This should be refactored to be an abstract class that you can extend
 * named 'Ouroboros'. (Ouroboros = the snake eating it's own tail)
 *
 * @group LDV Recipes
 */
public with sharing class LDVRecipes implements Queueable {
    private final Integer chunkSize = 20;
    private Id offsetId;
    private List<ContentDocumentLink> objectsToProcess;
    @testVisible
    private static Integer chunksExecuted = 0;

    /**
     * @description No param constructor. Use for starting the chain.
     */
    public LDVRecipes() {
        this.objectsToProcess = getRecordsToProcess(this.offsetId);
    }

    /**
     * @description    Constructor accepting an ID to use as an offset. Use
     * this version to *continue* the chain.
     * @param offsetId
     */
    public LDVRecipes(Id offsetId) {
        if (offsetId != null) {
            this.offsetId = offsetId;
        }
        this.objectsToProcess = getRecordsToProcess(this.offsetId);
    }

    /**
     * @description            This method contains the 'what' happens to each
     * chunk of records. Note, that this example doesn't actually do any
     * processing. In a real-life use case you'd iterate over the records stored
     * in this.objectsToProcess.
     * @param queueableContext
     */
    public void execute(System.QueueableContext queueableContext) {
        // Used to demonstrate the method was executed.
        LDVRecipes.chunksExecuted += 1;
        // If you're processing the group of records there's likely a better way
        // to determine the last objects' ID, but this will do for demonstrating
        // the idea. We need the last ID from objectsToProcess in order to
        // construct the next queueable with an offset.
        Id lastRecordId = objectsToProcess[objectsToProcess.size() - 1].id;

        if (getRecordsToProcess(lastRecordId).size() > 0 && safeToReenqueue()) {
            LDVRecipes newQueueable = new LDVRecipes(lastRecordId);
            System.enqueueJob(newQueueable);
        }
    }

    /**
     * @description    Returns a 'cursor' - a set of records of size X from a
     * given offset. Note: We originally intended to use OFFSET - the SOQL
     * keyword, but discovered the max OFFSET size is 2000. This obviously won't
     * work for large data volumes greater than 2000 so we switched to using the
     * ID of the record. Since ID is an indexed field, this should also allow
     * us to prevent full table scans even on the largest tables.
     * @param offsetId The offset ID is used to demarcate already processed
     * records.
     */
    private List<ContentDocumentLink> getRecordsToProcess(Id offsetId) {
        // Map to hold all the bind variables used in the query
        Map<String, Object> queryBinds = new Map<String, Object>{
            'offsetId' => offsetId,
            'chunkSize' => this.chunkSize
        };
        String queryString = '';
        queryString += 'SELECT ContentDocumentId,ContentDocument.Title, ContentDocument.CreatedDate,LinkedEntityId ';
        queryString += 'FROM ContentDocumentLink ';
        queryString += 'WHERE LinkedEntityId in (SELECT Id FROM Account) ';
        if (offsetId != null) {
            queryString += 'AND Id > :offsetId ';
        }
        queryString += 'ORDER BY Id ASC ';
        queryString += 'LIMIT :chunkSize';
        return Database.queryWithBinds(
            queryString,
            queryBinds,
            AccessLevel.USER_MODE
        );
    }

    private Boolean safeToReenqueue() {
        return Limits.getLimitQueueableJobs() > Limits.getQueueableJobs();
    }
}
