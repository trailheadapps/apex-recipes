trigger LogTrigger on Log__e(after insert) {
    new logTriggerHandler().run();
}
