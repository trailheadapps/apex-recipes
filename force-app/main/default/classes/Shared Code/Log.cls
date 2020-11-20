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

    /**
        Add a message to the buffer without publishing it.
     */
    public void add(String messageToLog) {
        this.add(messageToLog, null);
    }

    public void add(String messageToLog, LogSeverity severity) {
        LogMessage msg = new LogMessage(messageToLog);
        if (severity != null) {
            msg.severity = severity;
        }
        buffer.add(msg);
    }

    /**
        Add an formated exception message to the buffer without publishing it.
     */
    public void add(Exception exceptionToLog) {
        this.add(exceptionToLog, null);
    }

    public void add(Exception exceptionToLog, LogSeverity severity) {
        LogMessage msg = new LogMessage(exceptionToLog);
        if (severity != null) {
            msg.severity = severity;
        }
        buffer.add(msg);
    }

    /**
        Publish any messages currently in the buffer, without adding any new ones. 
     */
    public void publish() {
        List<SObject> rawLogs = new List<SObject>();
        for (LogMessage msg : this.buffer) {
            rawLogs.add(msg.toEvent());
        }
        EventBus.publish(rawLogs);
        this.buffer.clear();
    }

    /**
        Auto-format exception details, add it to the log buffer, and then publish the current buffer.
    */
    public void publish(Exception exceptionToLog) {
        this.buffer.add(new LogMessage(exceptionToLog));
        this.publish();
    }

    /**
        Auto-format a custom log message string, add it to the log buffer, and then publish the current buffer.
        Use the equivelent add method if you intend to add multiple messages rapidly to minimize DML usage.
    */
    public void publish(String messageToLog) {
        this.buffer.add(new LogMessage(messageToLog));
        this.publish();
    }
}
