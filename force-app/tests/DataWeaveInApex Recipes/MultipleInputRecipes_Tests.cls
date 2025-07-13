@isTest
public with sharing class MultipleInputRecipes_Tests {
    @isTest
    public static void testRunScriptWithMultipleInputs() {
        String products = '[ { "type": "book", "price": 30, "properties": { "title": "Everyday Italian", "author": [ "Giada De Laurentiis" ], "year": 2005 } }, { "type": "book", "price": 29.99, "properties": { "title": "Harry Potter", "author": [ "J K. Rowling" ], "year": 2005 } }, { "type": "book", "price": 41.12, "properties": { "title": "Mule in Action", "author": [ "David Dossot", "John D\'Emic" ], "year": 2009 } }, { "type": "book", "price": 49.99, "properties": { "title": "XQuery Kick Start", "author": [ "James McGovern", "Per Bothner", "Kurt Cagle", "James Linn", "Kurt Cagle", "Vaidyanathan Nagarajan" ], "year": 2003 } }, { "type": "book", "price": 39.95, "properties": { "title": "Learning XML", "author": [ "Erik T. Ray" ], "year": 2003 } }]';
        String attributes = '{ "publishedAfter": 2004 }';
        String exchangeRates = '{ "USD": [ {"currency": "EUR", "ratio":0.92}, {"currency": "ARS", "ratio":8.76}, {"currency": "GBP", "ratio":0.66} ]}';

        Test.startTest();
        String output = MultipleInputRecipes.runScriptWithMultipleInputs(
            products,
            attributes,
            exchangeRates
        );
        Test.stopTest();

        Assert.isTrue(output.contains('<author>Giada De Laurentiis</author>'));
        Assert.isTrue(output.contains('<price currency="ARS">262.8</price>'));
    }
}
