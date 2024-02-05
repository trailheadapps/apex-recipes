@isTest
public with sharing class ObjectConversionRecipes_Tests {
    private static final String SAMPLE_CSV =
        'first_name,last_name,email\n' + 'Abel,Maclead,a.m@demo.org';

    private static final String SAMPLE_JSON = '[{ "first_name": "Abel", "last_name": "Maclead", "email": "a.m@demo.org" }]';

    @isTest
    static void testConvertCsvToContacts() {
        Test.startTest();
        List<Contact> contacts = ObjectConversionRecipes.convertCsvToContacts(
            SAMPLE_CSV
        );
        Test.stopTest();

        System.assertEquals(1, contacts.size());
        Contact c = contacts[0];
        System.assertEquals('Abel', c.FirstName);
        System.assertEquals('Maclead', c.LastName);
        System.assertEquals('a.m@demo.org', c.Email);
    }

    @isTest
    static void testConvertJsonToContacts() {
        Test.startTest();
        List<Contact> contacts = ObjectConversionRecipes.convertJsonToContacts(
            SAMPLE_JSON
        );
        Test.stopTest();

        System.assertEquals(1, contacts.size());
        Contact c = contacts[0];
        System.assertEquals('Abel', c.FirstName);
        System.assertEquals('Maclead', c.LastName);
        System.assertEquals('a.m@demo.org', c.Email);
    }

    @isTest
    public static void testConvertCsvToApexObject() {
        Test.startTest();
        List<CsvData> results = ObjectConversionRecipes.convertCsvToApexObject(
            SAMPLE_CSV
        );
        Test.stopTest();

        System.assertEquals(1, results.size());
        CsvData item = results[0];
        System.assertEquals('Abel', item.FirstName);
        System.assertEquals('Maclead', item.LastName);
        System.assertEquals('a.m@demo.org', item.Email);
    }
}
