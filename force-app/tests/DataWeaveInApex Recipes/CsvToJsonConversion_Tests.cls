@isTest
private class CsvToJsonConversion_Tests {
    @isTest
    static void testConvertCsvToJsonBasic() {
        String csvPayload =
            'first_name,last_name,company,address\n' +
            'Abel,Maclead,"Rousseaux, Michael Esq","6649 N Blue Gum St,\n' +
            'New Orleans"';
        Test.startTest();
        String jsonResult = CsvToJsonConversion.convertCsvToJsonBasic(
            csvPayload
        );
        Test.stopTest();
        Assert.areNotEqual(
            0,
            jsonResult.trim().length(),
            'Expected to have JSON output from DW script'
        );
        List<Object> jsonList = (List<Object>) JSON.deserializeUntyped(
            jsonResult
        );
        Map<String, Object> jsonMap = (Map<String, Object>) (jsonList[0]);
        Assert.areEqual('Abel', jsonMap.get('first_name'));
        Assert.areEqual('Maclead', jsonMap.get('last_name'));
        Assert.areEqual('Rousseaux, Michael Esq', jsonMap.get('company'));
        Assert.areEqual(
            '6649 N Blue Gum St,\nNew Orleans',
            jsonMap.get('address')
        );
    }

    @isTest
    static void testConvertCsvToJsonContacts() {
        // Load CSV data as a blob from static resource
        Blob data = [
            SELECT Body
            FROM StaticResource
            WHERE Name = 'contacts'
            LIMIT 1
        ]
        .Body;

        Test.startTest();
        List<Contact> contacts = CsvToJsonConversion.convertCsvToJsonContacts(
            data.toString()
        );
        Assert.areEqual(
            51,
            contacts.size(),
            'The static resource contacts.csv has 51 rows of data (less headers)'
        );
        for (Contact c : contacts) {
            Assert.areNotEqual(null, c.FirstName);
            Assert.areNotEqual(null, c.LastName);
            Assert.areNotEqual(null, c.MailingStreet);

            if (c.FirstName == 'Donette' && c.LastName == 'Foller') {
                Assert.isTrue(
                    c.MailingStreet == '34 Center St\n#42' ||
                        c.MailingStreet == '34 Center St\r\n#42'
                );
            }
        }
    }
}
