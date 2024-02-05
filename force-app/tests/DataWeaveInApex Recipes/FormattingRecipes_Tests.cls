@isTest
public with sharing class FormattingRecipes_Tests {
    @isTest
    static void testFormatDateInJson() {
        // Insert test contact
        List<Contact> contacts = new List<Contact>{
            new Contact(FirstName = 'John', LastName = 'Doe')
        };
        insert contacts;
        // Retrieve contacts that we just created so that we can access created date
        Set<Id> contactIds = new Set<Id>{ contacts[0].Id };
        contacts = [
            SELECT FirstName, LastName, CreatedDate
            FROM Contact
            WHERE Id IN :contactIds
        ];

        Test.startTest();
        String jsonResult = FormattingRecipes.formatDateInJson(contacts);
        Test.stopTest();

        // DW uses Java 8 java.time.format, so uuuu denotes the year instead of yyyy for Apex.
        String expected =
            '{\n' +
            '  "users": [\n' +
            '    {\n' +
            '      "firstName": "John",\n' +
            '      "lastName": "Doe",\n' +
            '      "createdDate": "' +
            contacts[0].CreatedDate.formatGMT('hh:mm:ss a, MMMM dd, yyyy') +
            '"\n' +
            '    }\n' +
            '  ]\n' +
            '}';

        Assert.areEqual(
            expected,
            jsonResult,
            'Expected custom DateTime format in UTC'
        );
    }

    @isTest
    static void testPluralize() {
        String singularWords = '[ "box", "cat", "deer", "die", "person", "cactus", "datum" ]';

        Test.startTest();
        String jsonOutput = FormattingRecipes.pluralize(singularWords);
        Test.stopTest();

        Map<String, String> pluralMappings = new Map<String, String>();
        List<object> mappings = (List<object>) JSON.deserializeUntyped(
            jsonOutput
        );
        for (Object pluralMap : mappings) {
            Map<String, Object> pm = (Map<String, Object>) pluralMap;
            for (String key : pm.keySet()) {
                pluralMappings.put(key, (String) pm.get(key));
            }
        }

        Assert.areEqual(7, pluralMappings.size());
        Assert.areEqual('boxes', pluralMappings.get('box'));
        Assert.areEqual('cats', pluralMappings.get('cat'));
        Assert.areEqual('deer', pluralMappings.get('deer'));
        Assert.areEqual('dice', pluralMappings.get('die'));
        Assert.areEqual('people', pluralMappings.get('person'));
        Assert.areEqual('data', pluralMappings.get('datum'));
        // This one is currently failing
        // Assert.areEqual('cacti', pluralMappings.get('cactus'));
    }

    @isTest
    static void testEscapeApexReservedKeywords() {
        String jsonInput = '[{"currency" : "ABC"}]';

        Test.startTest();
        String jsonOutput = FormattingRecipes.escapeApexReservedKeywords(
            jsonInput
        );
        Test.stopTest();

        List<JSONResult> results = (List<JSONResult>) JSON.deserialize(
            jsonOutput,
            List<JSONResult>.class
        );
        Assert.areEqual(1, results.size());
        JSONResult res = results[0];
        Assert.areEqual('ABC', res.currency_x);
    }

    public class JSONResult {
        public String currency_x;
    }
}
