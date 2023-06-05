/**
 * @description Class generates data for installation cases where we cannot
 * create example data via a Salesforce CLI call
 *
 * @group Shared Code
 *
 */
public with sharing class DataFactoryForPackageInstalls {
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
        SObject[] toInsert = new List<SObject>{};
        toInsert.addAll(junction1);
        toInsert.addAll(junction2);
        insert as user toInsert;

        for (Integer i = 0; i < 50; i++) {
            juctionObjs.add(
                new Junction__c(
                    parent1__c = junction1.get(i).Id,
                    Parent2__c = junction2.get(i).Id
                )
            );
        }
        insert as user juctionObjs;
    }
}
