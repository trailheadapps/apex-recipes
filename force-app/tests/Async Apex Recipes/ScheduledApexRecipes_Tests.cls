@IsTest
private inherited sharing class ScheduledApexRecipes_Tests {
    @IsTest
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
            WHERE Id = :scheduledJobId
            LIMIT 1
        ];
        System.Assert.areEqual(
            ScheduledApexRecipes.TEST_CRON_STATEMENT,
            checkCronTrigger.CronExpression,
            'These two cron statements should be equal'
        );

        System.Assert.areEqual(
            0,
            checkCronTrigger.timesTriggered,
            'Expected this cron trigger to never have been fired'
        );

        // String.valueOf(Datetime) adds 543 to the year for a user with the
        // th_TH locale; format with a pattern writes the year as stored.
        System.Assert.areEqual(
            '2099-05-28 00:00:00',
            checkCronTrigger.nextFireTime.format('yyyy-MM-dd HH:mm:ss'),
            'Expected the next fire time to be set to 5/28/2099 at midnight'
        );
    }
}
