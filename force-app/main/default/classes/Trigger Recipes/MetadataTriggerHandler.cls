/**
 * @description This class exists as a unified, trigger handler class. It
 * uses Custom Metadata, and introspection of the Trigger.new variable to
 * determine what trigger handler classes should be called, and in what order.
 *
 * Metadata_Driven_Trigger__mdt has three fields:
 *  * Object__c - is a metadata entity look up to an sObject ie: Account
 *  * Execution_Order__c - is an integer and determines the order the trigger
 *  *   handlers are executed
 *  * Class__c - is a String holding the name of the Trigger Handler to execute
 *
 * Note: This Trigger framework works like this:
 *
 * An .trigger for a sObject invokes this class via:
 * new MetadataTriggerHandler().run();
 *
 * This trigger handler class extends TriggerHandler - all the trigger handler
 * classes _must_ extend trigger handler. Most classes will only overwrite the
 * context methods like afterUpdate(). This class, however, overrides the run
 * method. This class is responsible for determining which other trigger
 * handler classes to instantiate and run.
 *
 * Concrete example:
 * AccountTrigger.trigger (in this org) - invokes this class.
 * This class queries the custom metadata and will find (at least) one metadata
 * record tied to Account and the metadata record's Class__c specifies
 * AccountTriggerHandler. This class then loops over the returned metadata
 * records, instantiating the classes specified. It then calls the appropriate
 * context methods on those classes.
 *
 * Note: The TriggerHandler framework below does *not* give you the ability to
 * order, or re-arrange the trigger work of managed packages. It also does not
 * allow you to declare the *order of methods* within the triggerHandler classes
 * themselves. When using the MetadataTriggerHandler, it's better to have a
 * high number of singularly focused trigger handler classes than a few classes
 * with multiple methods.
 *
 * @group Trigger Recipes
 */
public inherited sharing class MetadataTriggerHandler extends TriggerHandler {
    /**
     * @description Overrides the standard Run() method, which allows this
     * metadata based trigger handler can be an incremental update / sit beside
     * other trigger handlers classes that are directly invoked by a trigger
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    override public void run() {
        /**
         * This is standard validation checking for triggers / triggerhandlers
         */
        if (!validateRun()) {
            return;
        }

        addToLoopCount();

        /**
         * End standard validation
         */

        String objType = getSobjectType();
        /**
         * This query finds an ordered list trigger handler classes
         * to execute. It ignores any classes that are marked as disabled.
         *
         * Note: It will exclude any triggerHandler metadata records for which
         * the user's email address is found in a related disabled_for__mdt
         * record.
         *
         * Admin's and Developers can selectively disable trigger handlers
         * for all or selected individuals *without* deploying.
         *
         */
        List<Metadata_Driven_Trigger__mdt> tryggers = [
            SELECT Class__c
            FROM Metadata_Driven_Trigger__mdt
            WHERE
                Object__c = :objType
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
                     * rather than an id that is seemingly random
                     *
                     */
                    WHERE User_Email__c = :UserInfo.getUsername()
                )
            ORDER BY Execution_Order__c
        ];

        /**
         * This loop is responsible for instantiating the trigger
         * handler classes identified by the query above, and then calling the
         * proper context methods.
         */
        for (Metadata_Driven_Trigger__mdt trygger : tryggers) {
            TriggerHandler handler;
            try {
                handler = (TriggerHandler) Type.forName(trygger.class__c)
                    .newInstance();
            } catch (Exception e) {
                continue;
            }

            switch on context {
                when BEFORE_INSERT {
                    handler.beforeInsert();
                }
                when BEFORE_UPDATE {
                    handler.beforeUpdate();
                }
                when AFTER_INSERT {
                    handler.afterInsert();
                }
                when AFTER_UPDATE {
                    handler.afterUpdate();
                }
                when BEFORE_DELETE {
                    handler.beforeDelete();
                }
                when AFTER_DELETE {
                    handler.afterDelete();
                }
                when AFTER_UNDELETE {
                    handler.afterUndelete();
                }
            }
        }
    }

    /**
     * @description This determines the active sObject type by describing the first
     * record in the trigger New / Old list
     * @return      `String`
     */
    private String getSObjectType() {
        if (Trigger.new != null) {
            return Trigger.new[0].getSObjectType().getDescribe().getName();
        } else {
            return Trigger.old[0].getSObjectType().getDescribe().getName();
        }
    }
}
