@isTest
private inherited sharing class ScheduledApexRecipes_Tests {
    @isTest
    static void scheduledExecutionTimeIsCorrectPositive() {
        // Schedule the job @ the TEST_CRON_STATEMENT
        // query for the job to make sure it's scheduled at the right time/date

        Test.startTest();
        String scheduledJobId = System.schedule(
            'ScheduledApexRecipes-Test',
            ScheduledApexRecipes.TEST_CRON_STATEMENT,
            new ScheduledApexRecipes()
        );
        Test.stopTest();

        CronTrigger checkCronTrigger = [
            SELECT CronExpression, timesTriggered, nextFireTime
            FROM CronTrigger
            WHERE id = :scheduledJobId
            LIMIT 1
        ];
        System.assertEquals(
            checkCronTrigger.CronExpression,
            ScheduledApexRecipes.TEST_CRON_STATEMENT,
            'These two cron statements should be equal'
        );

        System.assertEquals(
            checkCronTrigger.timesTriggered,
            0,
            'Expected this cron trigger to never have been fired'
        );

        System.assertEquals(
            String.valueOf(checkCronTrigger.nextFireTime),
            '2099-05-28 00:00:00',
            'Expected the next fire time to be set to 5/28/2099 at midnight'
        );
    }
}
