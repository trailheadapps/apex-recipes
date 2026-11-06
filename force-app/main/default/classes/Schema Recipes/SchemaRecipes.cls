/**
 * @description Responsible for showing how to use schema and schema tokens
 *
 * @group Schema Recipes
 */
public with sharing class SchemaRecipes {
    /**
     * @description Demonstrates how to use schema field tokens
     * and DescribeFieldResult for schema metadata access.
     */
    public void schemaTokenRecipe() {

        // Retrieve describe information for Account.Name field
        Schema.DescribeFieldResult dfr =
            Schema.SObjectType.Account.fields.Name;

        // Reference a custom field token
        Schema.SObjectField token2 = Junction__c.parent1__c;

        System.assert(dfr.getSObjectField() == Account.Name);

        dfr = dfr.getSobjectField().getDescribe();
    }
}