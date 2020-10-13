@isTest
private inherited sharing class DynamicSOQLRecipes_Tests {
    // Test Setup methods are called before every test method
    @TestSetup
    static void makeData() {
        Account acct = TestDataHelpers.genAccountWithOptions(true, 'MX');
        insert acct;
    }

    @isTest
    static void simpleDynamicSOQLQueryTest() {
        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.simpleDynamicSOQLQuery();
        Test.stopTest();

        System.assert(results.size() == 1, 'Expected to find a single account');
    }

    @isTest
    static void simpleBindingSOQLQueryTestPositive() {
        String acctName = [SELECT Name FROM Account LIMIT 1].Name;
        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.simpleBindingSOQLQuery(
            acctName
        );
        Test.stopTest();

        System.assert(results.size() == 1, 'Expected to find a single account');
    }

    @isTest
    static void simpleBindingSOQLQueryTestNegative() {
        String acctName = [SELECT Name FROM Account LIMIT 1].Name + '\'';
        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.simpleBindingSOQLQuery(
            acctName
        );
        Test.stopTest();

        System.assert(
            results.size() == 0,
            'Expected to fail to find an account'
        );
    }

    @isTest
    static void resolvedDynamicFieldsSOQLQueryTestPositive() {
        Account acct = [SELECT Name FROM Account LIMIT 1];
        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.resolvedDynamicFieldsSOQLQuery(
            acct
        );
        Test.stopTest();

        System.assert(results.size() == 1, 'Expected to find an Account');
    }

    @isTest
    static void typecastDataIntelligentlyTestPositive() {
        Account acct = [SELECT Name FROM Account LIMIT 1];
        acct.NumberOfEmployees = 55;
        update acct;

        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.typecastDataIntelligently(
            '50'
        );
        Test.stopTest();

        System.assert(results.size() == 1, 'Expected to find an Account');
    }

    @isTest
    static void typecastDataIntelligentlyTestNoResult() {
        Account acct = [SELECT Name FROM Account LIMIT 1];
        acct.NumberOfEmployees = 55;
        update acct;

        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.typecastDataIntelligently(
            '500'
        );
        Test.stopTest();

        System.assert(results.size() == 0, 'Expected to not find an Account');
    }

    @isTest
    static void simpleQueryBuilderTestPositive() {
        Id acctId = [SELECT Id FROM Account LIMIT 1].Id;
        List<String> fields = new List<String>{
            'Name',
            'NumberOfEmployees',
            'BillingAddress'
        };
        String whereClause =
            'id = \'' +
            String.escapeSingleQuotes(acctId) +
            '\'';
        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.simpleQueryBuilder(
            fields,
            whereClause
        );
        Test.stopTest();

        System.assert(results.size() == 1, 'Expected to find a single account');
    }
}
