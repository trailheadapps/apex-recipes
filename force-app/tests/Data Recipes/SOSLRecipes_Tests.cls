@isTest
private class SOSLRecipes_Tests {
    @TestSetup
    static void makeData() {
        Account a1 = new Account(name = 'KS');
        Account a2 = new Account(name = 'bob', shippingState = 'KS');
        Account a3 = new Account(name = 'oz');

        insert new List<Account>{ a1, a2, a3 };

        Contact c1 = new Contact(AccountId = a1.Id, lastname = 'Kansas');
        Contact c2 = new Contact(AccountId = a2.Id, lastname = 'Alaska');
        Contact c3 = new Contact(AccountId = a3.Id, lastname = 'Ted');

        insert new List<Contact>{ c1, c2, c3 };
    }

    @isTest
    static void basicSOSLSearch() {
        Map<Id, Account> fakeResults = new Map<Id, Account>(
            [SELECT Id FROM Account WHERE Name = 'KS']
        );
        Test.setFixedSearchResults(new List<Id>(fakeResults.keyset()));
        Test.startTest();
        List<List<SObject>> results = SOSLRecipes.basicSOSLSearch();
        Test.stopTest();

        System.Assert.areEqual(
            1,
            results[0].size(),
            'Expected to get one account with KS'
        );
    }

    @isTest
    static void inNameFieldsTest() {
        Map<Id, Contact> fakeResults = new Map<Id, Contact>(
            [SELECT Id FROM Contact WHERE lastname = 'Alaska']
        );
        List<Id> ids = new List<Id>(fakeResults.keyset());
        System.assertEquals(1, ids.size(), 'Expected to find a single contact');
        Test.setFixedSearchResults(ids);

        Test.startTest();
        List<List<SObject>> results = SOSLRecipes.NameFieldSearch();
        Test.stopTest();
        System.Assert.areEqual(
            1,
            results[1].size(),
            'Expected to get one contact with Alaska'
        );
    }
}
