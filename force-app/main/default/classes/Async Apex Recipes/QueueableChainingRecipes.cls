/**
 * @description Demonstrates how to use the Queueable interface
 * to chain multiple queueable instances together. The methods in this class,
 * with the exception of the constructor, are run automatically by the system
 * as the job runs. To enqueue this job, use:
 * `System.enqueueJob(new QueueableChainingRecipes());`
 *
 * More on the Queuable interface:
 * https://sfdc.co/queueable-apex
 *
 * @group Async Apex Recipes
 * @see QueueableRecipes
 */
public with sharing class QueueableChainingRecipes implements Queueable {
    /**
     * @description This recipe demonstrates how one queuable (this one) can
     * enqueue a second Queueable class.
     * If the second queueable class utilizes a constructor, information can be
     * passed through to the next Queueable.
     * @param context Dependency Injected by the System
     * @example
     * ```
     * System.enqueueJob(new QueueableChainingRecipes());
     * ```
     */
    public static void execute(QueueableContext context) {
        List<Account> accounts = [SELECT Id, Description FROM Account];
        for (Account acct : accounts) {
            acct.Description += ' Edited by first chained Queuable';
        }
        try {
            update accounts;
        } catch (DmlException dmle) {
            System.debug(
                LoggingLevel.INFO,
                'Failed to update accounts. Error is: ' + dmle.getMessage()
            );
        }

        // This is how you construct and enqueue an additional Queueable job
        // Note: You can only enqueue ONE job from a queueable
        QueueableRecipes recipe = new QueueableRecipes();
        System.enqueueJob(recipe);
    }
}
