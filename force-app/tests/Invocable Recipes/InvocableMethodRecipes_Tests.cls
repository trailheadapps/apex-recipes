@isTest
private class InvocableMethodRecipes_Tests {
    @isTest
    static void contactSearchRequestConstructorPositive() {
        Test.startTest();
        InvocableMethodRecipes.ContactSearchRequest request = new InvocableMethodRecipes.ContactSearchRequest();
        request.inputs = new List<Account>{ new Account(name = 'test') };
        Test.stopTest();

        System.Assert.areEqual(
            1,
            request.inputs.size(),
            'Expected to find one account'
        );
    }

    @isTest
    static void endToEndInvocableMethodTestAccountPositive() {
        Account account = (Account) TestFactory.createSObject(
            new Account(name = 'Test'),
            true
        );
        Contact contact = (Contact) TestFactory.createSObject(
            new Contact(lastName = 'Nomical', accountId = account.Id),
            true
        );
        List<InvocableMethodRecipes.ContactSearchRequest> requests = new List<InvocableMethodRecipes.ContactSearchRequest>();
        InvocableMethodRecipes.ContactSearchRequest request = new InvocableMethodRecipes.ContactSearchRequest();
        request.inputs = new List<SObject>{ account };
        requests.add(request);

        Test.startTest();
        List<InvocableMethodRecipes.ContactSearchResult> results = InvocableMethodRecipes.findRelatedContacts(
            requests
        );
        Test.stopTest();

        System.Assert.areEqual(
            1,
            results.size(),
            'Expected to receive one contact'
        );
        System.Assert.areEqual(
            contact.Id,
            results[0].output.Id,
            'Expected the returned contact to be the one we created'
        );
    }

    @isTest
    static void endToEndInvocableMethodTestTaskPositive() {
        Account account = (Account) TestFactory.createSObject(
            new Account(name = 'Test'),
            true
        );
        Contact contact = (Contact) TestFactory.createSObject(
            new Contact(lastName = 'Nomical', accountId = account.Id),
            true
        );
        Task task = (Task) TestFactory.createSObject(
            new Task(whoId = contact.Id, subject = 'test'),
            true
        );
        List<InvocableMethodRecipes.ContactSearchRequest> requests = new List<InvocableMethodRecipes.ContactSearchRequest>();
        InvocableMethodRecipes.ContactSearchRequest request = new InvocableMethodRecipes.ContactSearchRequest();
        request.inputs = new List<SObject>{ task };
        requests.add(request);

        Test.startTest();
        List<InvocableMethodRecipes.ContactSearchResult> results = InvocableMethodRecipes.findRelatedContacts(
            requests
        );
        Test.stopTest();

        System.Assert.areEqual(
            1,
            results.size(),
            'Expected to receive one contact'
        );
        System.Assert.areEqual(
            contact.Id,
            results[0].output.Id,
            'Expected the returned contact to be the one we created'
        );
    }
}
