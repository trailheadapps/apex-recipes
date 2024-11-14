/**
 * @description Demonstrates how to create Apex classes and methods that
 * can be invoked from Visual Flows and Process Builder Processes
 * This also demonstrates custom input and output inner classes allowing
 * you to create code that accepts input from a flow/process and
 * returns data to the flow
 * @group Invocable Recipes
 */
public with sharing class InvocableMethodRecipes {
    /**
     * @description Internal custom exception class
     */
    public class InvocableMethodRecipesException extends Exception {
    }

    /**
     * @description inner class that represents an incoming search request
     */
    public class ContactSearchRequest {
        @InvocableVariable(
            label='Generic SObject records - Input'
            description='Input variable for generic SObjects'
            required=true
        )
        public List<SObject> inputs;
    }

    /**
     * @description Represents the output from the invocable method
     */
    public class ContactSearchResult {
        @InvocableVariable(
            label='Generic SObject record - Output'
            description='Output variable for generic SObject'
            required=true
        )
        public SObject output;
        /**
         * @description    Constructor building output object from SObject
         * @param toOutput  Object to output
         */
        public ContactSearchResult(SObject toOutput) {
            this.output = toOutput;
        }
    }

    /**
     * @description Invocable method accepts a list of incoming
     * ContactSearchRequest objects. The first incoming request is extracted,
     * and the incoming records' Id is used to determine the type of object.
     * In this case, the code handles either an Account or a Task. A query is
     * crafted specific to the incoming object, and it's type and the results
     * of the query are converted to a Result object and returned.
     * @param inputParams A list of ContactSearchRequest objects
     * @example
     * From Apex:
     * ```
     * Account account = new Account(name='awesome examples ltd.');
     * insert account;
     * Contact contact = new Contact(accountId = account.id, firstName='Kevin', lastName='Awesome');
     * insert contact;
     * InvocableMethodRecipes.ContactSearchRequest csr = new InvocableMethodRecipes.ContactSearchRequest();
     * csr.inputs = new List<sObject>{account};
     * InvocableMethodRecipes.ContactSearchResult results = InvocableMethodRecipes.findRelatedContacts(csr);
     * System.debug(results.output);
     * ```
     */
    @InvocableMethod(
        label='Example Invocable Method'
        description='Example Invocable Method'
    )
    public static List<ContactSearchResult> findRelatedContacts(
        List<ContactSearchRequest> inputParams
    ) {
        // Map to hold all the bind variables used in the query
        Map<String, Object> contactQueryBinds = new Map<String, Object>();
        // Grab the first ContactSearchRequest from the list of inputParams
        List<SObject> inputs = inputParams[0].inputs;
        String firstRecordId = inputs[0].Id;
        // Get the incoming input's concrete SObject type
        String sObjectType = inputs[0]
            .Id.getSobjectType()
            .getDescribe()
            .getName();
        String queryString = '';
        // Switch on the SObject type to customize the query
        switch on sObjectType.toLowerCase() {
            when 'account' {
                contactQueryBinds.put('firstRecordId', firstRecordId);
                queryString = 'SELECT Id, Name FROM Contact WHERE accountId = :firstRecordId LIMIT 1';
            }
            when 'task' {
                Task task = (Task) inputs[0];
                contactQueryBinds.put('whoId', task.WhoId);
                queryString = 'SELECT Id, Name FROM Contact WHERE Id = :whoId LIMIT 1';
            }
            when else {
                throw new InvocableMethodRecipesException(
                    'Unknown object type passed. This method only supports Account and Task.'
                );
            }
        }
        // Note, both queries artificially limit the results to 1, but that's
        // not a requirement
        Contact contact = Database.queryWithBinds(
            queryString,
            contactQueryBinds,
            AccessLevel.USER_MODE
        );
        // Create a list of ContactSearchResults to hold eventual value(s)
        List<ContactSearchResult> results = new List<ContactSearchResult>();
        results.add(new ContactSearchResult(contact));

        return results;
    }
}
