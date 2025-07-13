@isTest
public with sharing class LoggingRecipes_Tests {
    @isTest
    static void testLogWithDataWeaveScript() {
        String jsonInput = '[{"name": "Hare", "isWinner": false}, {"name": "Turtles", "isWinner": true}]';

        Test.startTest();
        String jsonOutput = LoggingRecipes.logWithDataWeaveScript(jsonInput);
        Test.stopTest();

        // While we can assert on the script outcome here, the key part is the logging that occurs
        // to DATAWEAVE_USER_DEBUG
        // You will need to run the test with logging enabled or as anonymous Apex to see the output

        System.debug(jsonOutput);
        /*[
        {
            "name": "Turtles",
            "isWinner": true
        }
        ]*/

        List<Object> jsonList = (List<Object>) JSON.deserializeUntyped(
            jsonOutput
        );
        Assert.areEqual(1, jsonList.size());
        Map<String, Object> jsonMap = (Map<String, Object>) jsonList[0];
        Assert.areEqual('Turtles', jsonMap.get('name'));
        Assert.isTrue((Boolean) jsonMap.get('isWinner'));
    }
}
