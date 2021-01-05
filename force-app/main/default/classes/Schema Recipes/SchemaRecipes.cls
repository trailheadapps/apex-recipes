/**
 * @description Responsible for showing how to use schema and schema tokens
 */
public inherited sharing class SchemaRecipes {
    public void schemaTokenRecipe() {
        Schema.SObjectField token = Account.Name; // A Schema token is the obj.field_api_name
        Schema.DescribeFieldResult dfr = Schema.SObjectType.Account.fields.Name;
        Schema.SObjectField token2 = Junction__c.parent1__c;

        system.assert(dfr.getSObjectField() == Account.Name);

        dfr = dfr.getSobjectField().getDescribe();
        system.debug(dfr);
    }
}
