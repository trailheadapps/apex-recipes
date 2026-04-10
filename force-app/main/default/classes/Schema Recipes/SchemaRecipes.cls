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
    } /**
     * @description Demonstrates how to get all field names for a given object
     * @param objectName The API name of the SObject (e.g. 'Account')
     * @return List of field API names
     * @example
     * List<String> fields = SchemaRecipes.getFieldsForObject('Account');
     */
    public static List<String> getFieldsForObject(String objectName) {
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        if (objType == null) {
            return new List<String>();
        }
        Map<String, Schema.SObjectField> fieldsMap = objType.getDescribe()
            .fields.getMap();
        return new List<String>(fieldsMap.keySet());
    }

    /**
     * @description Demonstrates how to get picklist values for a field
     * @param objectName The API name of the SObject (e.g. 'Account')
     * @param fieldName The API name of the picklist field (e.g. 'Industry')
     * @return List of picklist values
     * @example
     * List<String> values = SchemaRecipes.getPicklistValues('Account', 'Industry');
     */
    public static List<String> getPicklistValues(
        String objectName,
        String fieldName
    ) {
        List<String> values = new List<String>();
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        if (objType == null) {
            return values;
        }
        Schema.SObjectField field = objType.getDescribe()
            .fields.getMap()
            .get(fieldName);
        if (field == null) {
            return values;
        }
        for (
            Schema.PicklistEntry entry : field.getDescribe().getPicklistValues()
        ) {
            if (entry.isActive()) {
                values.add(entry.getValue());
            }
        }
        return values;
    }

    /**
     * @description Demonstrates how to check if an SObject exists in the org
     * @param objectName The API name of the SObject to check
     * @return true if the object exists, false otherwise
     * @example
     * Boolean exists = SchemaRecipes.doesObjectExist('Account');
     */
    public static Boolean doesObjectExist(String objectName) {
        return Schema.getGlobalDescribe().containsKey(objectName);
    }
}
