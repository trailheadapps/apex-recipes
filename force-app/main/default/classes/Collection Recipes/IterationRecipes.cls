/**
 * @description Demonstrates how to iterate on lists and sets
 *
 * @group Collection Recipes
 * @see IterableApiClient
 */
public with sharing class IterationRecipes {
    /**
     * @description Demonstrates how to iterate on a list of SObject thanks to the Iterable and Iterator interfaces.
     * This example iterates on Accounts to sum the 'number of employees' field values
     * (use the `SUM` SOQL function for a real-life application).
     * @param accounts a list of accounts that will be iterated on
     * @return Total number of employees for the accounts
     */
    public static Integer iterateOnAccountList(List<Account> accounts) {
        Integer employeeCount = 0;
        // Lists and Sets implement the Iterable interface in Apex
        Iterable<Account> accountIterator = accounts;
        // While the iterator is in use, the account list is locked in read-only mode
        // any attempt to modify the collection will cause a System.FinalException
        for (Account acct : accountIterator) {
            // Do something with the account
            if (acct.NumberOfEmployees != null) {
                employeeCount += acct.NumberOfEmployees;
            }
        }
        return employeeCount;
    }

    /**
     * @description Demonstrates how to use a REST API client that leverages the `Iterator` interface.
     * This example iterates on a paginated record list. Records are represented as strings for simplicity.
     * Remote records are retrieved on the fly by IterableApiClient when the Iterator is accessed.
     * @return List of "records" retrieved
     */
    public static List<String> iterableApiClientRecipe() {
        List<String> records = new List<String>();
        IterableApiClient client = new IterableApiClient('myNamedCredential');
        for (IterableApiClient.RecordPage page : client) {
            records.addAll(page.getRecords());
        }
        return records;
    }
}
