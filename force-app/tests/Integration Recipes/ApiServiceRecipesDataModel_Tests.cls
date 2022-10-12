@isTest
public class ApiServiceRecipesDataModel_Tests {
    @testVisible
    public static String testJSONBad =
        '[' +
        '  {\"exampleArray\": [' +
        '    1,' +
        '    2,' +
        '    3' +
        '  ],' +
        '  \"exampleBoolean\": true,' +
        '  \"exampleColor\": \"Green\",' +
        '  \"exampleCouldBeNull\": null,' +
        '  \"exampleNumber\": 8675309,' +
        '  \"exampleObject\": {';

    @testVisible
    public static String testJSON =
        '[' +
        '  {\"exampleArray\": [' +
        '    1,' +
        '    2,' +
        '    3' +
        '  ],' +
        '  \"exampleBoolean\": true,' +
        '  \"exampleColor\": \"Green\",' +
        '  \"exampleCouldBeNull\": null,' +
        '  \"exampleNumber\": 8675309,' +
        '  \"exampleObject\": {' +
        '    \"a\": \"b\",' +
        '    \"c\": \"d\"' +
        '  },' +
        '  \"exampleString\": \"Hello World\"},' +
        '  {\"exampleArray\": [' +
        '    1,' +
        '    2,' +
        '    3' +
        '  ],' +
        '  \"exampleBoolean\": true,' +
        '  \"exampleColor\": \"Blue\",' +
        '  \"exampleCouldBeNull\": \"Not null this time\",' +
        '  \"exampleNumber\": 123,' +
        '  \"exampleObject\": {' +
        '    \"a\": \"b\",' +
        '    \"c\": \"d\"' +
        '  },' +
        '  \"exampleString\": \"Hello World\"}]';
    static testMethod void testParse() {
        List<ApiServiceRecipesDataModel> obj = ApiServiceRecipesDataModel.parse(
            ApiServiceRecipesDataModel_Tests.testJSON
        );
        System.Assert.isNotNull(
            obj,
            'Expected the example data to properly parse'
        );
    }
}
