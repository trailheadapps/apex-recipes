/**
 * @description A demonstration recipe for how to process a large amount of
 * records in serial chunks using Queueables.
 */
public with sharing class LDVRecipes implements Queueable {
    // points of interest
    // 50k records
    // 60 seconds to process
    // re-enqueue one queueable
    // constructable

    private final Integer chunkSize = 5;
    private Id offsetId;
    private List<ContentDocumentLink> objectsToProcess;

    public LDVRecipes() {
        this.objectsToProcess = getRecordsToProcess(this.offsetId);
    }

    public LDVRecipes(Id offsetId) {
        if (offsetId != null) {
            this.offsetId = offsetId;
        }
        this.objectsToProcess = getRecordsToProcess(this.offsetId);
    }

    public void execute(System.QueueableContext queueableContext) {
        // find attachments on the account object

        // second queuable that processes the actual attachment
        system.debug('$$$ ' + objectsToProcess);
        Id lastRecordId = objectsToProcess[objectsToProcess.size()-1].id;
        LDVRecipes newQueueable = new LDVRecipes(this.offsetId);
        System.enqueueJob(newQueueable);
    }

    public List<ContentDocumentLink> getRecordsToProcess(Id offsetId) {
        String queryString = '';
        queryString += 'SELECT ContentDocumentId,ContentDocument.Title, ContentDocument.CreatedDate,LinkedEntityId ';
        queryString += 'FROM ContentDocumentLink ';
        queryString += 'where LinkedEntityId in (SELECT Id FROM Account) ';
        if (offsetId != null) {
            queryString += 'AND WHERE ID > :offsetId ';
        }
        queryString += 'LIMIT :chunkSize';
        return Database.query(queryString);
    }
}
