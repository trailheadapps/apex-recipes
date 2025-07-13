/**
 * @description This class demonstrates how to construct a Queueable class.
 * The methods in this class are run automatically by the system
 * as the job runs. To enqueue this job, use: `System.enqueueJob(new QueueableRecipes());`
 *
 * More on the Queable interface:
 * https://sfdc.co/queueable-apex
 *
 * @group Async Apex Recipes
 */
public with sharing class QueueableRecipes implements Queueable {
    /**
     * @description This is the only required method to implement Queueable.
     * In our case, it's simply updating account names, but this execute method
     * can be used to execute any asynchronous code. Queueable classes run
     * asynchronously much like `@future` annotated code. However, because they're
     * implementing an interface they can be constructed, and thus accept full
     * objects, not just primitives. Crucially, Queueable classes can also
     * _enqueue_ other Queueable classes. See QueueableChainingRecipes for more
     * details.
     * @param qc dependency injected by the system
     * @example
     * ```
     * System.enqueueJob(new QueueableRecipes());
     * ```
     */
    public static void execute(QueueableContext qc) {
        List<Account> accounts = [
            SELECT Id, Description
            FROM Account
            LIMIT 1000
        ];
        for (Account acct : accounts) {
            acct.Description += ' Edited by Queueable class';
        }
        try {
            update accounts;
        } catch (DmlException dmle) {
            System.debug(
                LoggingLevel.INFO,
                'real life use cases should do more than just logging the error: ' +
                dmle.getMessage()
            );
        }
    }
}
