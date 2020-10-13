public inherited sharing class DataFactoryForPackageInstalls {
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
        insert toInsert;

        for (Integer i = 0; i < 50; i++) {
            juctionObjs.add(
                new Junction__c(
                    parent1__c = junction1.get(i).Id,
                    parent2__c = junction2.get(i).Id
                )
            );
        }
        insert juctionObjs;
    }
}
