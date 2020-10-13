/**
 * @description Demonstrates how to make various types of SOQL calls
 * including multi-object queries, and aggregate queries
 * @group Data Recipes
 * @see CanTheUser
 */
public inherited sharing class SOQLRecipes {
    /**
     * @description Demonstrates the proper way to query accounts with SOQL
     *   keeping FLS and CRUD in account.
     *
     * Note: This method has a false-positive PMD warning. PMD isn't aware of
     * the purpose or functionality of CanTheUser.* so it doesn't undersatnd
     * that we are, in fact, checking for CRUD / FLS permissions prior to
     * querying.
     * @return list<Account>
     * @example
     * List<Account> results = SOQLRecipes.querySingleObject();
     * System.debug(results);
     **/
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static list<Account> querySingleObject() {
        List<Account> accounts = new List<Account>();
        if (CanTheUser.read(new Account())) {
            accounts = [
                SELECT Name, ShippingStreet, ShippingCity
                FROM Account
                WITH SECURITY_ENFORCED
            ];
        }
        return accounts;
    }

    /**
     * @description Demonstrates how to loop over a SOQL query
     *
     * Note: This method has a false-positive PMD warning. Our query
     * includes the keyword 'WITH SECURITY_ENFORCED' which prevents this
     * query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     *
     * @return integer
     * @example
     * System.debug(SOQLRecipes.queryMassiveNumberOfRecordsReturningCount());
     **/
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static integer queryMassiveNumberOfRecordsReturningCount() {
        Integer count = 0;
        /**
         * You'll see this pattern, called a SQOL for loop used
         * whenever you're iterating over a massive number of rows.
         * Doing a SOQL for loop like this helps you avoid hitting
         * Heap limits.
         */

        for (Account acct : [SELECT Name FROM Account WITH SECURITY_ENFORCED]) {
            count++;
        }
        return count;
    }

    /**
     * @description Demonstrates how to use a WHERE clause in a SOQL query
     *
     * Note: This method has a false-positive PMD warning. Our query
     * includes the keyword 'WITH SECURITY_ENFORCED' which prevents this
     * query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     * @return List<Account>
     * @example
     * System.debug(SOQLRecipes.getFilteredList());
     **/
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static List<Account> getFilteredList() {
        return [
            SELECT Name
            FROM Account
            WHERE ShippingCountry = 'UK'
            WITH SECURITY_ENFORCED
        ];
    }

    /**
     * @description Demonstrates how to use a complex WHERE clause in a SOQL
     * query
     *
     * Note: This method has a false-positive PMD warning. Our query
     * includes the keyword 'WITH SECURITY_ENFORCED' which prevents this
     * query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     * @return List<Account>
     * @example
     * System.debug(SOQLRecipes.getComplexFilteredList());
     **/
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static List<Account> getComplexFilteredList() {
        return [
            SELECT Name
            FROM Account
            WHERE
                ShippingCountry = 'US'
                AND ShippingState = 'IN'
                AND (Industry = 'Fast Food - made whole'
                OR Industry = 'Slow Food - Made quickly')
            WITH SECURITY_ENFORCED
        ];
    }

    /**
     * @description Demonstrates how to use the LIMIT clause in a SOQL statement
     *
     * Note: This method has a false-positive PMD warning. Our query
     * includes the keyword 'WITH SECURITY_ENFORCED' which prevents this
     * query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     * @return List<Account>
     * @example
     * System.debug(SOQLRecipes.getSpecificNumberOfResults());
     **/
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static List<Account> getSpecificNumberOfResults() {
        //LIMIT clause
        return [
            SELECT name
            FROM Account
            WITH SECURITY_ENFORCED
            ORDER BY Industry DESC
            LIMIT 10
        ];
    }

    /**
     * @description Demonstrates how to use a bound variable to define the LIMIT
     * @param wantedNumberOfRows the number of rows desired
     *
     * Note: This method has a false-positive PMD warning. Our query
     * includes the keyword 'WITH SECURITY_ENFORCED' which prevents this
     * query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     * @return List<Account>
     * @example
     * System.debug(SOQLRecipes.getFirstXResults(5));
     **/
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static List<Account> getFirstXResults(Integer wantedNumberOfRows) {
        return [
            SELECT name
            FROM Account
            WITH SECURITY_ENFORCED
            ORDER BY Industry DESC
            LIMIT :wantedNumberOfRows
        ];
    }

    /**
     * @description Demonstrates how to use a bound variable in a WHERE clause
     * @param state String representing a US State code (AK, KS, etc.)
     *
     * Note: This method has a false-positive PMD warning. Our query
     * includes the keyword 'WITH SECURITY_ENFORCED' which prevents this
     * query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     * @return List<Account>
     * @example
     * System.debug(SOQLRecipes.getAccountsInState('ks'));
     **/
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static List<Account> getAccountsInState(String state) {
        return [
            SELECT Name
            FROM Account
            WHERE ShippingState = :state
            WITH SECURITY_ENFORCED
        ];
    }

    /**
     * @description Demonstrates how to get a limited number of results with a
     * given offset; Ie: get the second set of 10 records.
     *
     * Note: This method has a false-positive PMD warning. Our query
     * includes the keyword 'WITH SECURITY_ENFORCED' which prevents this
     * query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     * @return List<Account>
     * @example
     * System.debug('SOQLRecipes.getSecond10Accounts()');
     **/
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static List<Account> getSecond10Accounts() {
        return [
            SELECT id
            FROM Account
            WITH SECURITY_ENFORCED
            ORDER BY Industry DESC
            LIMIT 10
            OFFSET 10
        ];
    }

    /**
     * @description Demonstrates how to query an object, as well as it's related
     * child objects
     *
     * Note: This method has a false-positive PMD warning. Our query
     * includes the keyword 'WITH SECURITY_ENFORCED' which prevents this
     * query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     * @return List<Account>
     * @example
     * System.debug(SOQLRecipes.getContactsAndAccounts());
     **/
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static List<Account> getContactsAndAccounts() {
        return [
            SELECT Name, (SELECT Name, AccountId FROM Contacts)
            FROM Account
            WITH SECURITY_ENFORCED
        ];
    }

    /**
     * @description Demonstrates how to query fields from a parent object
     * through the relationship field
     *
     * Note: This method has a false-positive PMD warning. Our query
     * includes the keyword 'WITH SECURITY_ENFORCED' which prevents this
     * query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     * @return List<Contact>
     * @example
     * System.debug(SOQLRecipes.getParentDetailsForChild());
     **/
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static List<Contact> getParentDetailsForChild() {
        return [
            SELECT Id, Name, Email, account.Name, account.ShippingState
            FROM Contact
            WHERE account.ShippingState = 'KS'
            WITH SECURITY_ENFORCED
        ];
    }

    /**
     * @description Demonstrates how to write a query that pulls information
     * from two parent objects through a junction object
     *
     * Note: This method has a false-positive PMD warning. Our query
     * includes the keyword 'WITH SECURITY_ENFORCED' which prevents this
     * query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     * @return List<Junction__c>
     * @example
     * System.debug(SOQLRecipes.getDetailsFromBothParents());
     **/
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static List<Junction__c> getDetailsFromBothParents() {
        return [
            SELECT Id, parent1__r.Name, parent2__r.Name
            FROM Junction__c
            WITH SECURITY_ENFORCED
        ];
    }

    /**
     * @description demonstrates how to use aggregate methods, like Sum() or
     * Count() in a SOQL query. This example generates the sum of opportunities
     * associated with a specified Account
     *
     * Note: This method has a false-positive PMD warning. Our query
     * includes the keyword 'WITH SECURITY_ENFORCED' which prevents this
     * query from accessing fields and objects that they don't have permission
     * to access. This is a form of inline CRUD/FLS Check.
     * @param accountId an AccountId
     * @return Double
     * @example
     * Id accountId = [SELECT id FROM Account LIMIT 1].Id;
     * System.debug(SOQLRecipes.getSumOfOpportunities(accountId));
     **/
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static Double getSumOfOpportunities(Id accountId) {
        AggregateResult[] groupedResults = [
            SELECT SUM(Amount) total
            FROM Opportunity
            WHERE accountId = :accountId
            WITH SECURITY_ENFORCED
        ];
        return (double) groupedResults[0].get('total');
    }
}
