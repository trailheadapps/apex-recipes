public with sharing class MetadataTriggerService {
    public class MetadataTriggerServiceException extends Exception {
    }
    private String objType = '';

    public MetadataTriggerService(String objectTypeName) {
        this.objType = objectTypeName;
    }

    /**
     * @description This query finds an ordered list trigger handler classes
     * to execute. It ignores any classes that are marked as disabled.
     *
     * Note: It will exclude any `triggerHandler` metadata records for which
     * the user's email address is found in a related `Disabled_for__mdt`
     * record.
     *
     * Admin's and Developers can selectively disable trigger handlers
     * for all or selected individuals *without* deploying.
     */
    @suppressWarnings('PMD.ApexCRUDViolation')
    public List<Metadata_Driven_Trigger__mdt> getMetadataTriggers() {
        return [
            SELECT Class__c
            FROM Metadata_Driven_Trigger__mdt
            WHERE
                Object__r.QualifiedApiName = :this.objType
                AND Enabled__c = TRUE
                AND Id NOT IN (
                    SELECT Metadata_Driven_Trigger__c
                    FROM Disabled_for__mdt
                    /**
                     * Note: The use raised on stream for this feature - to
                     * selectively disable triggers per e-mail is different than
                     * what's implemented here. Email addresses do not have to
                     * be unique, but usernames are. You may want to use email
                     * if, for instance, you want to disable all integration
                     * users who share an email address.
                     *
                     * You can use any of the UserInfo.* methods to make this
                     * kind of decision, so long as the CMT is able to represent
                     * the data. You could use a UserID, but that's not portable
                     * across environments/orgs and it's less likely, in my
                     * estimation, that you'd typo an email address you can read
                     * rather than an ID that is seemingly random
                     *
                     */
                    WHERE User_Email__c = :UserInfo.getUsername()
                )
            ORDER BY Execution_Order__c
        ];
    }

    /**
     * @description This determines the active sObject type by describing the first
     * record in the trigger New / Old list
     */
    public static String getSObjectType() {
        if (Trigger.new != null) {
            return Trigger.new[0].getSObjectType().getDescribe().getName();
        } else if (Trigger.old != null) {
            return Trigger.old[0].getSObjectType().getDescribe().getName();
        }
        throw new MetadataTriggerServiceException(
            'Trigger.new && Trigger.old are both null. Are you excercising this method outside of a trigger context?'
        );
    }
}
