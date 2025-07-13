/**
 * @description This class utilizes Custom Metadata objects and the example
 * use case we've established for Apex Recipes.
 *
 * @group Custom Metadata Recipes
 * @see CustomMetadataRecipes_Tests
 */
public with sharing class CustomMetadataUtilties {
    /**
     * Understanding this class, and it's utility requires understanding the use
     * case we've setup for:
     *
     * Our org has the need to periodically act on the value of picklist fields.
     * However, sometimes we need to 'bucket' the values. This is similar to the
     * way Case and Opportunity have 'status' picklists that are 'open' or
     * 'closed'. Open and Closed are 'buckets' that picklist values fall into.
     *
     * For our use case, and to demonstrate CustomMetadata relationships we've
     * Setup three Custom Metadata objects:
     * 1. Bucketed_Picklist__mdt. This metadata has two metadata relationships
     * looking up to an object entity (object__c) and a field entity (field__c)
     * The field lookup is controlled by the object lookup. The purpose of this
     * metadata is to concretely identify object.field references to picklists
     * we want to bucket. Ie: Contact.AttendanceStatus__c is a bucketed picklist
     * because a CMD record exists specifying 'Contact' as the object and
     * 'Attendance__c' as the field.
     * 2. Picklist_Bucket__mdt. This metadata has an metadata relationship to
     * Bucketed_Picklist__mdt. It's label serves not only as the label for the
     * record, but also for the 'bucket' name. Ie, if we were using this setup
     * for Opportunity's open/closed bucketing, the labels would be 'Open', and
     * 'Closed'.
     * 3. Bucketed_Picklist_value__mdt. This metadata has a relationship to
     * Picklist_Bucket__mdt, and represents a value that is understood to be
     * in the bucket it's related too. For instance, given the Opportunity
     * parallel, one value here would be 'closed/Won'. There is generally a 1:1
     * relationship between the picklist values of the field identified by
     * Bucketed_Picklist__mdt, and the values of the
     * Bucketed_Picklist_value__mdt records.
     *
     * Put another way:
     * Bucketed_Picklist__mdt belongs to one object, and one field on that obj
     * Bucketed_Picklist_Value__mdt belongs to a single Picklist_Bucket__mdt rec
     * Picklist_Bucket__mdt has many Bucketed_Picklist_Value__mdt records and
     * belongs to one Bucketed_Picklist__mdt record.
     *
     * This class help you solve for: What Bucket of values does the sObject
     * record belong to in a user-scalable way that doesn't require code updates
     * to update buckets, values or even add new bucketed picklists.
     */

    /**
     * @description Identifies Bucketed Picklists the given object ID has
     * associated with it.
     * @param objId
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public List<Bucketed_Picklist__mdt> getBucketedPicklistsForObject(
        Id objId
    ) {
        if (objId == null) {
            return new List<Bucketed_Picklist__mdt>();
        }
        String obj = String.valueof(objId.getSObjectType());
        return [
            SELECT
                developerName,
                object__r.qualifiedApiName,
                field__r.qualifiedApiName
            FROM Bucketed_Picklist__mdt
            WHERE object__r.qualifiedApiName = :obj
            WITH USER_MODE
        ];
    }

    /**
     * @description  Convenience method accepts a list and send the first
     * entry in the list to it's twin above.
     * @param objIds
     */
    public List<Bucketed_Picklist__mdt> getBucketedPicklistsForObject(
        List<Id> objIds
    ) {
        return this.getBucketedPicklistsForObject(objIds[0]);
    }

    /**
     * @description Returns a list of bucket names that match the given search
     * term, and list of possible fields.
     * @param bPL    Bucketed Picklist list
     * @param search Search String for Bucketed_Picklist_Value__mdt.label
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public List<Picklist_Bucket__mdt> getPicklistBucketWithValues(
        List<Bucketed_Picklist__mdt> bPL,
        String search
    ) {
        return [
            SELECT
                developerName,
                Bucketed_Picklist__c,
                (
                    SELECT developerName, label
                    FROM Bucketed_Picklist_values__r
                    WHERE label = :search
                )
            FROM Picklist_Bucket__mdt
            WHERE
                Bucketed_Picklist__c IN :bPl
                AND Id IN (
                    SELECT Picklist_Bucket__c
                    FROM Bucketed_Picklist_value__mdt
                    WHERE label = :search
                )
            WITH USER_MODE
        ];
    }
}
