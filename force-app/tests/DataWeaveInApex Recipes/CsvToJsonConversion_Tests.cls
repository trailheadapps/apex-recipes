@isTest
private class CsvToJsonConversion_Tests {
    @isTest
    static void testConvertCsvToJson() {
        String csvPayload =
            'first_name,last_name,company,address\n' +
            'Abel,Maclead,"Rousseaux, Michael Esq","6649 N Blue Gum St,\n' +
            'New Orleans"';
        Test.startTest();
        String jsonResult = CsvToJsonConversion.convertCsvToJson(csvPayload);
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
}
