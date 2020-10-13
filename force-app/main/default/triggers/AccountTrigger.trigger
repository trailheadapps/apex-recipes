trigger AccountTrigger on Account(
    before insert,
    after insert,
    before update,
    after update,
    before delete,
    after delete,
    after undelete
) {
    // This trigger utilizes a trigger handler pattern & framework.
    // For more information on how the framework operates, see the following classes:
    // * TriggerHandler.cls
    // * AccountTriggerHandler.cls
    new AccountTriggerHandler().run();
}
