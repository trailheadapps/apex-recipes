public with sharing class StubExample {
    public Boolean isTrue = false;
    public String greeting = 'hello';
    public Boolean notMocked; // this is null on purpose for testing.

    public Boolean getIsTrue() {
        return this.isTrue;
    }

    public String getGreeting() {
        return this.greeting;
    }

    public void setGreeting(String greeting) {
        this.greeting = greeting;
    }

    public void setGreeting(Integer greeting) {
        this.greeting = String.valueOf(greeting);
    }
}
