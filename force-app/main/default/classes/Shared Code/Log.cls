public with sharing class Log {
    private static Log currentInstance;

    private List<LogMessage> buffer;

    private Log() {
        buffer = new List<LogMessage>();
    }

    public static Log get() {
        if (currentInstance == null) {
            currentInstance = new Log();
        }
        return currentInstance;
    }

    public void add(String messageToLog) {
        buffer.add(new LogMessage(messageToLog));
    }

    public void add(Exception exceptionToLog) {
        buffer.add(new LogMessage(exceptionToLog));
    }

    public void publish() {
        List<SObject> rawLogs = new List<SObject>();
        for (LogMessage msg : this.buffer) {
            rawLogs.add(msg.toEvent());
        }
        EventBus.publish(rawLogs);
        this.buffer.clear();
    }

    public void publish(Exception exceptionToLog) {
        this.buffer.add(new LogMessage(exceptionToLog));
        this.publish();
    }

    public void publish(String messageToLog) {
        this.buffer.add(new LogMessage(messageToLog));
        this.publish();
    }
}
