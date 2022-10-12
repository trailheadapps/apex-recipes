@isTest
class CustomMetadataRecipes_Tests {
    @isTest
    static void testBucketedPicklistsPositive() {
        Test.startTest();
        List<Bucketed_Picklist__mdt> picklists = [
            SELECT Id, Field__c, Object__c, Field__r.QualifiedAPIName
            FROM Bucketed_Picklist__mdt
        ];
        Test.stopTest();
        System.Assert.isTrue(
            picklists.size() >= 1,
            'We expect at least 1 picklist(s) to exist if you have properly setup this repo into an org'
        );
    }

    @isTest
    static void testBucketingContactAttendancePositive() {
        final String asleep = 'Asleep';
        Contact con = (Contact) TestFactory.createSObject(
            new Contact(LastName = 'Testy', AttendanceStatus__c = asleep),
            true
        );
        List<Id> contactIds = new List<Id>{ con.Id };
        CustomMetadataUtilties cmu = new CustomMetadataUtilties();
        Test.startTest();
        List<Bucketed_Picklist__mdt> bucketedPicklists = cmu.getBucketedPicklistsForObject(
            contactIds
        );
        List<Picklist_Bucket__mdt> matchingBuckets = cmu.getPicklistBucketWithValues(
            bucketedPicklists,
            asleep
        );
        Test.stopTest();

        System.Assert.areEqual(
            1,
            bucketedPicklists.size(),
            'Expected to find one matching bucketed picklist field for contact'
        );
        System.Assert.areEqual(
            1,
            matchingBuckets.size(),
            'Expected to find one matching bucket'
        );

        System.Assert.areEqual(
            'Attended',
            matchingBuckets[0].DeveloperName,
            'Expected to get Attended'
        );
        System.Assert.areEqual(
            'Attendance',
            bucketedPicklists[0].DeveloperName,
            'Expected to find the Attendance Bucketed Picklist'
        );
    }
}
