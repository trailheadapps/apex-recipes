/**
 * @description Responsible for showing how to use schema and schema tokens
 *
 * @group Schema Recipes
 */
public with sharing class SchemaRecipes {
    /**
     * @description demonstrates how to use a field token for schema access
     */
    public void schemaTokenRecipe() {
        Schema.DescribeFieldResult dfr = Schema.SObjectType.Account.fields.Name;
        Schema.SObjectField token2 = Junction__c.parent1__c;

        System.assert(dfr.getSObjectField() == Account.Name);

        dfr = dfr.getSobjectField().getDescribe();
    }
}
