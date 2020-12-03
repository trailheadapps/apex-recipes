/**
 * @description contains methods and static lists for rapid acceptence of a
 * particular set of quiddities
 */
public with sharing class QuiddityGuard {
    @TestVisible
    private static Quiddity testQuiddityOverride;

    public static List<Quiddity> trustedQuiddities = new List<Quiddity>{
        Quiddity.SYNCHRONOUS,
        Quiddity.QUEUEABLE,
        Quiddity.BATCH_APEX,
        Quiddity.RUNTEST_SYNC,
        Quiddity.RUNTEST_ASYNC,
        Quiddity.RUNTEST_DEPLOY
    };

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

    public static List<Quiddity> anonymous = new List<Quiddity>{
        Quiddity.ANONYMOUS
    };

    public static boolean isAcceptableQuiddity(
        List<Quiddity> acceptableQuiddites
    ) {
        Quiddity q = System.Request.getCurrent().getQuiddity();

        if (testQuiddityOverride != null) {
            q = testQuiddityOverride;
        }
        return acceptableQuiddites.contains(q);
    }
}
