/**
 * @description Demonstrates how to query the Metadata Catalog. This is
 * sometimes faster that Schema Describe calls especially for large complex orgs
 * @group Data Recipes
 */
public with sharing class MetadataCatalogRecipes {
    /**
     * @description internal data object for information about a Lookup
     * Relationship
     */
    public class LookupRelationshipDefinition {
        /**
         * @description Specifies what object this one looks up to
         */
        public String looksUpTo { get; set; }
        /**
         * @description Specifies the name of the Object
         */
        public String developerName { get; set; }
        /**
         * @description Specifies the Relationship field name
         */
        public String relationshipName { get; set; }
        /**
         * @description Specifies the Data Type Of this Object
         */
        public String dataType { get; set; }

        /**
         * @description Constructor that transforms a Field Definition object
         *   into a LookupRelationshipDefinition Object.
         * @param fd a FieldDefinition Object
         * @example
         * ```
         * FieldDefinition fd = [SELECT Id, DeveloperName, RelationshipNme,
         *                          DataType
         *                       FROM FieldDefinition LIMIT 1];
         * MetadataCatalogRecipes.LookupRelationshipDefinition lrd = new
         *      MetadataCatalogRecipes.LookupRelationshipDefinition(fd);
         * System.debug(lrd);
         * ```
         */
        public LookupRelationshipDefinition(FieldDefinition fd) {
            this.looksUpTo = String.valueOf(fd.EntityDefinition.DeveloperName);
            this.developerName = String.valueOf(fd.DeveloperName);
            this.relationshipName = String.valueOf(fd.RelationshipName);
            this.dataType = String.valueOf(fd.DataType);
        }
    }

    /**
     * @description Demonstrates how to query the EntityDefinition Object to
     * find all formula fields in your Org. This method returns a Map of
     * Object's Qualified API name -> Map of Field Names -> Types
     *
     * Note: This method has a false-positive PMD warning. PMD isn't aware of
     * the purpose or functionality of CanTheUser.* so it doesn't undersatnd
     * that we are, in fact, checking for CRUD / FLS permissions prior to
     * querying.
     *
     * @example
     * ```
     * Map<String, Map<String, String>> results =
     *      MetadataCatalogRecipes.findAllFormulaFields();
     * System.debug(results);
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static Map<String, Map<String, String>> findAllFormulaFields() {
        List<EntityDefinition> objects = [
            SELECT
                QualifiedApiName,
                (
                    SELECT DeveloperName, DataType
                    FROM Fields
                    WHERE IsCalculated = TRUE
                )
            FROM EntityDefinition
        ];
        Map<String, Map<String, String>> objectToFormulaFieldsToDataTypeMap = new Map<String, Map<String, String>>();
        for (EntityDefinition e : objects) {
            for (FieldDefinition f : e.getSObjects('Fields')) {
                if (
                    objectToFormulaFieldsToDataTypeMap.containsKey(
                        String.valueOf(e)
                    )
                ) {
                    objectToFormulaFieldsToDataTypeMap.get(
                            String.valueOf(e.QualifiedApiName)
                        )
                        .put(f.DeveloperName, f.DataType);
                } else {
                    objectToFormulaFieldsToDataTypeMap.put(
                        String.valueOf(e.QualifiedApiName),
                        new Map<String, String>{ f.DeveloperName => f.DataType }
                    );
                }
            }
        }
        return objectToFormulaFieldsToDataTypeMap;
    }

    /**
     * @description Demonstrates how to query the metadata catalog to find all
     * fields on the Contact object that establish a relationship to the Account
     * Object.
     *
     * Note: This method has a false-positive PMD warning. PMD isn't aware of
     * the purpose or functionality of CanTheUser.* so it doesn't undersatnd
     * that we are, in fact, checking for CRUD / FLS permissions prior to
     * querying.
     * @example
     * ```
     * List<MetadataCatalogRecipes.LookupRelationshipDefinition> results =
     *      MetadataCatalogRecipes.findAllContactFieldsThatLookupToAccount();
     * System.debug(results);
     * ```
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static List<MetadataCatalogRecipes.LookupRelationshipDefinition> findAllContactFieldsThatLookupToAccount() {
        List<FieldDefinition> looksUpToAccount = [
            SELECT
                EntityDefinition.DeveloperName,
                DeveloperName,
                RelationshipName,
                DataType
            FROM FieldDefinition
            WHERE
                EntityDefinition.DeveloperName = 'Contact'
                AND RelationshipName = 'Account'
        ];
        List<LookupRelationshipDefinition> relationships = new List<LookupRelationshipDefinition>();
        for (FieldDefinition f : looksUpToAccount) {
            relationships.add(new LookupRelationshipDefinition(f));
        }
        return relationships;
    }
}
