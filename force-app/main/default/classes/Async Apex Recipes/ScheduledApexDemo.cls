/**
 * @description A demo class to be scheduled by ScheduledApexRecipes
 * @group Async Apex Recipes
 * @see ScheduledApexRecipes
 */
public with sharing class ScheduledApexDemo {
    @testVisible
    private Integer counter = 0;

    /**
     * @description A method demosrating the best practice of separating your
     * logic from
     * the schedulable interface code that executes it.
     * @example
     * ```
     * ScheduledApexDemo.runAtMidnight();
     * ```
     */
    public void runAtMidnight() {
        System.debug(
            LoggingLevel.INFO,
            'this method doesn\'t do anything. It\'s just here to illustrate ' +
            'how to separate the logic from the schedule'
        );
        this.counter++;
    }
}
