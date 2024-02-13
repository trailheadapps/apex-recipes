@isTest
public class CsvToJsonConversionRecipes_Tests {
    private static final String SAMPLE_CSV =
        'first_name,last_name,company,address\n' +
        'Abel,Maclead,"Rousseaux, Michael Esq","6649 N Blue Gum St,\n' +
        'New Orleans"';

    @isTest
    static void testConvertCsvToJson() {
        Test.startTest();
        String jsonResult = CsvToJsonConversionRecipes.convertCsvToJson(
            SAMPLE_CSV
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
    static void testConvertCsvToJsonWithFieldRenaming() {
        Test.startTest();
        String jsonResult = CsvToJsonConversionRecipes.convertCsvToJsonWithFieldRenaming(
            SAMPLE_CSV
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
        Assert.areEqual('Abel', jsonMap.get('FirstName'));
        Assert.areEqual('Maclead', jsonMap.get('LastName'));
        Assert.areEqual('Rousseaux, Michael Esq', jsonMap.get('Company'));
        Assert.areEqual(
            '6649 N Blue Gum St,\nNew Orleans',
            jsonMap.get('MailingStreet')
        );
    }

    @isTest
    static void testConvertCsvWithCustomSeparatorToJson() {
        // Note the use of the ; separator rather than ,
        String csvPayload = 'col1;col2\na;b';

        Test.startTest();
        String jsonResult = CsvToJsonConversionRecipes.convertCsvWithCustomSeparatorToJson(
            csvPayload
        );
        Test.stopTest();

        Assert.isTrue(
            jsonResult.contains('"col1": "a",'),
            'Expected first record header and value.'
        );
        Assert.isTrue(
            jsonResult.contains('"col2": "b"'),
            'Expected first record header and second value'
        );
    }
}
