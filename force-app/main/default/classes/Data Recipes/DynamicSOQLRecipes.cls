/**
 * @description Demonstrates how to construct a SOQL query dynamically, and
 * safely
 *
 * More on dynamic SOQL and SOQL injection:
 * https://sfdc.co/soql-injection
 *
 * @group Data Recipes
 */
public with sharing class DynamicSOQLRecipes {
    /**
     * @description demonstrates a simple dynamic SOQL query where the query is
     * defined in Apex
     * Note: This method has a false-positive PMD warning. Our Query
     * does not include any input parameters so SOQL Injection is not possible.
     * @return Account list with security enforced using `USER_MODE`
     * @example
     * ```
     * System.debug(DynamicSOQLRecipes.simpleDynamicSOQLQuery());
     * ```
     */
    @SuppressWarnings('PMD.ApexSOQLInjection')
    public static List<Account> simpleDynamicSOQLQuery() {
        String queryString = 'SELECT Id FROM Account LIMIT 1';
        return Database.query(queryString, AccessLevel.USER_MODE);
    }

    /**
     * @description Demonstrates the use of a bound variable in a dynamic SOQL
     * query. DANGER Because this method accepts user input (name param), it
     * must be sanitized against SOQL injections
     * @param name Name of the account to search for
     * @example
     * ```
     * System.debug(DynamicSoqlRecipes.simpleBindingSOQLQuery('hello'))
     * ```
     */
    public static List<Account> simpleBindingSOQLQuery(String name) {
        Map<String, Object> nameBind = new Map<String, Object>{
            'name' => name
        };
        String queryString =
            'SELECT Id, Name ' +
            'FROM Account ' +
            'WHERE Name = :name';
        return Database.queryWithBinds(
            queryString,
            nameBind,
            AccessLevel.USER_MODE
        );
    }

    /**
     * @description Demonstrates how to use a field from a passed param in a
     * bound dynamic SOQL queryString. DANGER: because this method accepts user
     * input (name param), it must be sanitized against SOQL injections
     * @param acct Account to base the search off of
     * @example
     * ```
     * Account acct = [SELECT Name FROM Account WHERE Name = 'hello' LIMIT 1];
     * Account[] results = DynamicSOQLRecipes.dynamicFieldsBindingSOQLQuery(acct);
     * System.debug(results);
     * ```
     */
    public static List<Account> dynamicFieldsBindingSOQLQuery(Account acct) {
        Map<String, Object> accountNameBind = new Map<String, Object>{
            'accountName' => acct.Name
        };
        String accountName = acct.Name;
        String queryString =
            'SELECT Id, Name ' +
            'FROM Account ' +
            'WHERE Name = :accountName';
        return Database.queryWithBinds(
            queryString,
            accountNameBind,
            AccessLevel.USER_MODE
        );
    }

    /**
     * @description Demonstrates intelligent typecasting to enforce sanitized
     * dynamic queries DANGER: Because this method accepts user input
     * (name param), it must be sanitized against SOQL injections
     *
     * Note: This method contains a False-Positive PMD warning about SOQL
     * Injection. Developers should always ensure the data you're merging into a
     * query is safe by escaping it. However, Apex is a type safe language, and
     * attempting to pass anything other than an integer to this method will
     * result in an exception being thrown. The purpose of this method is to
     * demonstrate how typecasting a string to an integer can prevent SOQL
     * injection attacks. If you passed in '44'do smething mean' the cast to
     * integer will throw an exception.
     *
     * @param numberOfRecords String to be used as the comparison in the query
     * @example
     * ```
     * System.debug(DynamicSOQLRecipes.typecastDataIntelligently(2).size());
     * ```
     */
    @SuppressWarnings('PMD.ApexSOQLInjection')
    public static List<Account> typecastDataIntelligently(
        String numberOfRecords
    ) {
        String queryString =
            'SELECT Id, Name FROM Account WHERE NumberOfEmployees > ' +
            String.valueOf(Integer.valueOf(numberOfRecords));
        // Because this query has no bound or concatenated strings,
        // escapeSingleQuotes won't do anything.
        // To safeguard against SOQL injection ensure your method only accepts
        // parameters of the appropriate type. In this method it's an Integer.
        // When building your query string, typecast that to a string with the
        // String.valueOf() method.
        return Database.query(queryString, AccessLevel.USER_MODE);
    }

    /**
     * @description Demonstrates the power of Dynamic SOQL to create a SOQL
     * query on the fly
     *
     * Note: This method contains a PMD false-positive report on a possible
     * SOQL injection vulnerability. This method is, in fact, a potentially
     * dangerous one. Be *extremely careful* with queries like this.
     * Whenever possible do not dynamically generate your
     * where clause as a string. Use bind variables.
     * Because the where clause here comes in as a pre-defined
     * string, the calling code *must* sanitize the input.
     * If you try to String.escapeSingleQuotes(whereClause) it will
     * generate a SQL error saying: no viable alternative at character '\'
     * At the very least, typecast it to a string.
     *
     * Please look at:
     * DynamicSOQLRecipes_Tests.simpleQueryBuilderTest_Positive()
     * for details on how to do calling side sanitization of input.
     *
     * This method *also* uses a guard statement to prevent execution
     * contexts where input sanitization is unlikey or impossible.
     *
     * @param fields      A list of String field names to include in the query
     * @param whereClause A string containing the where clause
     * @example
     * ```
     * List<String> fields = new List<String>{
     *       'Name',
     *       'NumberOfEmployees',
     *       'BillingAddress'
     *   };
     * String whereClause =
     *       'id = \'' +
     *       String.escapeSingleQuotes(acctId) +
     *       '\'';
     * List<Account> results = DynamicSOQLRecipes.simpleQueryBuilder(
     *       fields,
     *       whereClause
     *   );
     *   System.debug(results);
     * ```
     */
    @SuppressWarnings('PMD.ApexSOQLInjection')
    public static List<Account> simpleQueryBuilder(
        List<String> fields,
        String whereClause
    ) {
        if (
            !QuiddityGuard.isAcceptableQuiddity(QuiddityGuard.trustedQuiddities)
        ) {
            return new List<Account>();
        }
        String fieldList = String.escapeSingleQuotes(String.join(fields, ', '));
        String queryString =
            'SELECT ' +
            fieldList +
            ' FROM Account WHERE ' +
            String.valueOf(whereClause);
        return Database.query(queryString, AccessLevel.USER_MODE);
    }
}
