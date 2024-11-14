/**
 * @description Demonstrates how to implement the Schedulable interface. The
 * methods in this class are designed to be scheduled, similar to a cron job.
 *
 * More on the Schedulable interface:
 * https://sfdc.co/scheduled-apex
 *
 * @group Async Apex Recipes
 * @see ScheduledApexDemo
 * @see BatchApexRecipes
 */
public with sharing class ScheduledApexRecipes implements Schedulable {
    @testVisible // Sets to run at midnight 5/28/2099
    private final static String TEST_CRON_STATEMENT = '0 0 0 28 5 ? 2099';

    /**
     * @description This is the one method required by the Schedulable
     * interface. Key requirements are that it be public, and void.
     * Best practice is to keep your logic in a different class. In this case,
     * we're calling code in the ScheduledApexDemo class.
     *
     * Note: You can use the schedulable interface to schedule Batch Classes
     * but it's generally easier to use System.ScheduleBatch instead. See
     * BatchApexRecipes for more information.
     * @param context Dependency Injected by the System
     * @example
     * ```
     * System.schedule('Friendly Message to identify this job',
     *                  ScheduledApexRecipes.TEST_CRON_STATEMENT,
     *                  new ScheduledApexRecipes());
     * ```
     */
    public void execute(SchedulableContext context) {
        /**
         * Note, this recipe only shows the code needed to *run* code at a
         * scheduled time.It does *not* show you how to set or start the
         * schedule. Please see the tests for information on setting and
         * starting the schedule.
         */
        ScheduledApexDemo demo = new ScheduledApexDemo();
        demo.runAtMidnight();
    }
}
