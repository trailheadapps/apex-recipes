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

        System.Assert.areEqual(
            1,
            results.size(),
            'Expected to find a single account'
        );
    }

    @isTest
    static void simpleBindingSOQLQueryTestPositive() {
        String acctName = [SELECT Name FROM Account LIMIT 1].Name;
        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.simpleBindingSOQLQuery(
            acctName
        );
        Test.stopTest();

        System.Assert.areEqual(
            1,
            results.size(),
            'Expected to find a single account'
        );
    }

    @isTest
    static void simpleBindingSOQLQueryTestNegative() {
        String acctName = [SELECT Name FROM Account LIMIT 1].Name + '\'';
        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.simpleBindingSOQLQuery(
            acctName
        );
        Test.stopTest();

        System.Assert.areEqual(
            0,
            results.size(),
            'Expected to fail to find an account'
        );
    }

    @isTest
    static void dynamicFieldsBindingSOQLQueryTestPositive() {
        Account acct = [SELECT Name FROM Account LIMIT 1];
        Test.startTest();
        List<Account> results = DynamicSOQLRecipes.dynamicFieldsBindingSOQLQuery(
            acct
        );
        Test.stopTest();

        System.Assert.areEqual(
            1,
            results.size(),
            'Expected to find an Account'
        );
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

        System.Assert.areEqual(
            1,
            results.size(),
            'Expected to find an Account'
        );
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

        System.Assert.areEqual(
            0,
            results.size(),
            'Expected to not find an Account'
        );
    }

    @isTest
    static void simpleQueryBuilderTestNegativeOverridenQuiddity() {
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
        QuiddityGuard.testQuiddityOverride = Quiddity.FUTURE;
        List<Account> results = DynamicSOQLRecipes.simpleQueryBuilder(
            fields,
            whereClause
        );
        Test.stopTest();

        System.Assert.areEqual(
            0,
            results.size(),
            'Expected to find an empty list'
        );
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

        System.Assert.areEqual(
            1,
            results.size(),
            'Expected to find a single account'
        );
    }
}
