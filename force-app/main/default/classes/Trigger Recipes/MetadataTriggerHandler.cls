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
 * @see TriggerHandler
 */
public with sharing class MetadataTriggerHandler extends TriggerHandler {
    @testVisible
    private MetadataTriggerService mts;

    @testVisible
    private List<Metadata_Driven_Trigger__mdt> tryggers;

    @testVisible
    private TriggerHandler activeHandler;

    /**
     * @description Constructor used by live triggers.
     */
    public MetadataTriggerHandler() {
        this.mts = new MetadataTriggerService(
            MetadataTriggerService.getSobjectType()
        );
    }

    public MetadataTriggerHandler(MetadataTriggerService mts) {
        this.mts = mts;
    }

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

        this.tryggers = this.mts.getMetadataTriggers();

        /**
         * @description This loop is responsible for instantiating the trigger
         * handler classes identified by the query above, and then calling the
         * proper context methods.
         */
        for (Metadata_Driven_Trigger__mdt trygger : tryggers) {
            try {
                activeHandler = (TriggerHandler) Type.forName(trygger.class__c)
                    .newInstance();
            } catch (Exception e) {
                continue;
            }

            switch on context {
                when BEFORE_INSERT {
                    activeHandler.beforeInsert();
                }
                when BEFORE_UPDATE {
                    activeHandler.beforeUpdate();
                }
                when AFTER_INSERT {
                    activeHandler.afterInsert();
                }
                when AFTER_UPDATE {
                    activeHandler.afterUpdate();
                }
                when BEFORE_DELETE {
                    activeHandler.beforeDelete();
                }
                when AFTER_DELETE {
                    activeHandler.afterDelete();
                }
                when AFTER_UNDELETE {
                    activeHandler.afterUndelete();
                }
            }
        }
    }
}
