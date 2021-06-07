/**
 * @description This is a simple trigger handler class for Account that is used
 * to demonstrate the custom metadata trigger handler approach to multiple
 * trigger handler classes ordered by and controlled by custom metadata.
 *
 * @see MetadataTriggerHandler
 */
public with sharing class MDTSecondAccountTriggerHandler extends TriggerHandler {
    override public void beforeUpdate() {
        for (Account acct : (List<Account>) Trigger.new) {
            Acct.ShippingState = 'IN';
        }
    }
}
