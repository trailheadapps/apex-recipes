public with sharing class MetadataTriggerHandler extends TriggerHandler {
    override public void run() {
        if (!validateRun()) {
            return;
        }

        addToLoopCount();

        // what kind of object we're dealing with.
        // triggers will always have the same object type.
        String objType = getSobjectType();
        List<Metadata_Driven_Trigger__mdt> tryggers = [
            SELECT Class__c
            FROM Metadata_Driven_Trigger__mdt
            WHERE
                Object__c = :objType
                AND Enabled__c = TRUE
                AND Id NOT IN (
                    SELECT Metadata_Driven_Trigger__c
                    FROM Disabled_for__mdt
                    WHERE UserEmail__c = :UserInfo.getUserEmail()
                )
            ORDER BY Execution_Order__c
        ];

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

    private String getSObjectType() {
        if (Trigger.new != null) {
            return Trigger.new[0].getSObjectType().getDescribe().getName();
        } else {
            return Trigger.old[0].getSObjectType().getDescribe().getName();
        }
    }
}
