@isTest
private class TransformSobjectsInDataWeave_Tests {
    @isTest
    static void testConvertCsvToContacts() {
        // CSV data for Contacts
        String inputCsv = 'first_name,last_name,email\nCodey,"The Bear",codey@salesforce.com';
        Test.startTest();
        List<Contact> results = TransformSobjectsInDataWeave.convertCsvToContacts(
            inputCsv
        );
        Test.stopTest();
        Assert.areEqual(1, results.size());
        Contact codeyContact = results[0];
        Assert.areEqual('Codey', codeyContact.FirstName);
        Assert.areEqual('The Bear', codeyContact.LastName);
        Assert.areEqual('codey@salesforce.com', codeyContact.Email);
    }

    @isTest
    static void testConvertJsonToContacts() {
        // JSON data for Contacts
        String inputJson = '[{"id":1,"first_name":"Codey","last_name":"The Bear","email":"codey@salesforce.com"}]';
        Test.startTest();
        List<Contact> results = TransformSobjectsInDataWeave.convertJsonToContacts(
            inputJson
        );
        Test.stopTest();
        Assert.areEqual(1, results.size());
        Contact codeyContact = results[0];
        Assert.areEqual('Codey', codeyContact.FirstName);
        Assert.areEqual('The Bear', codeyContact.LastName);
        Assert.areEqual('codey@salesforce.com', codeyContact.Email);
    }
}
