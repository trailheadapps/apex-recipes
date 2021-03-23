public with sharing class StubExampleConsumer {
    StubExample stub;

    public StubExampleConsumer(StubExample stub) {
        this.stub = stub;
    }

    public Boolean getIsTrue() {
        return this.stub.getIsTrue();
    }

    public String getGreeting() {
        return this.stub.getGreeting();
    }

    public void setGreeting(String greeting) {
        this.stub.setGreeting(greeting);
    }

    public void setGreeting(Integer someInt) {
        this.stub.setGreeting(someInt);
    }

    public void setGreeting(Boolean someBoolean) {
        this.stub.setGreeting(String.valueOf(someBoolean));
    }
}
