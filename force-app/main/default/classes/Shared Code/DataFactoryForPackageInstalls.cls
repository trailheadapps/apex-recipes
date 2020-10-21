/**
 * @description Class generates data for installation cases where we cannot
 * create example data via a sfdx cli call
 */
public inherited sharing class DataFactoryForPackageInstalls {
    /**
     * @description generates three sets of data, used to demonstrate how
     * junction objects work. It creates two lists of parent records and a list
     * of junction objects.
     *
     * Note: This is intended as a setup script, and as such, it supresses
     * the PMD ApexCrudViolation.
     */
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static void generateData() {
        List<Junction_Demo_1__c> junction1 = new List<Junction_Demo_1__c>();
        List<Junction_Demo_2__c> junction2 = new List<Junction_Demo_2__c>();
        List<Junction__c> juctionObjs = new List<Junction__c>();

        for (Integer i = 0; i < 50; i++) {
            junction1.add(new Junction_Demo_1__c());
            junction2.add(new Junction_Demo_2__c());
        }
        sObject[] toInsert = new List<sObject>{};
        toInsert.addAll(junction1);
        toInsert.addAll(junction2);
        if (
            CanTheUser.create(junction1[0]) && CanTheUser.create(junction2[0])
        ) {
            insert toInsert;
        }

        for (Integer i = 0; i < 50; i++) {
            juctionObjs.add(
                new Junction__c(
                    parent1__c = junction1.get(i).Id,
                    parent2__c = junction2.get(i).Id
                )
            );
        }
        if (CanTheUser.create(juctionObjs[0])) {
            insert juctionObjs;
        }
    }
}
