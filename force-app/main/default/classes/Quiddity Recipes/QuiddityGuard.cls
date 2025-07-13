/**
 * @description contains methods and static lists for rapid acceptence of a
 * particular set of quiddities
 *
 * @group Quiddity Recipes
 */
public with sharing class QuiddityGuard {
    /**
     * @description a private testvisible variable allowing developers to
     * inject a custom quiddity value during test execution.
     */
    @TestVisible
    private static Quiddity testQuiddityOverride;

    /**
     * @description a non-exhaustive list of Quiddities that do not include user
     * situations where users could be injecting malicious data.
     */
    public static List<Quiddity> trustedQuiddities = new List<Quiddity>{
        Quiddity.SYNCHRONOUS,
        Quiddity.QUEUEABLE,
        Quiddity.BATCH_APEX,
        Quiddity.RUNTEST_SYNC,
        Quiddity.RUNTEST_ASYNC,
        Quiddity.RUNTEST_DEPLOY
    };

    /**
     * @description An exaustive list of quiddities that are valid for a test
     * execution
     */
    public static List<Quiddity> trustedTestQuiddities = new List<Quiddity>{
        Quiddity.RUNTEST_SYNC,
        Quiddity.RUNTEST_ASYNC,
        Quiddity.RUNTEST_DEPLOY
    };

    /**
     * @description A list of quiddities that may include user-defined data and
     * therefore should not be trusted without manual FLS/CRUD checks
     */
    public static List<Quiddity> untrustedQuiddities = new List<Quiddity>{
        Quiddity.AURA,
        Quiddity.DISCOVERABLE_LOGIN,
        Quiddity.INBOUND_EMAIL_SERVICE,
        Quiddity.INVOCABLE_ACTION,
        Quiddity.IOT,
        Quiddity.QUICK_ACTION,
        Quiddity.REMOTE_ACTION,
        Quiddity.REST,
        Quiddity.SOAP,
        Quiddity.VF
    };

    /**
     * @description A method to determine if the current Quiddity context is
     * within a caller-supplied list of acceptable quiddity values.
     * @param acceptableQuiddites A list of quiddities to check against
     */
    public static Boolean isAcceptableQuiddity(
        List<Quiddity> acceptableQuiddites
    ) {
        Quiddity q = System.Request.getCurrent().getQuiddity();

        if (testQuiddityOverride != null) {
            q = testQuiddityOverride;
        }
        return acceptableQuiddites.contains(q);
    }

    public static Boolean isNotAcceptableQuiddity(
        List<Quiddity> acceptableQuiddites
    ) {
        return !QuiddityGuard.isAcceptableQuiddity(acceptableQuiddites);
    }
}
