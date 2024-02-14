@isTest
public class MissingStudentsTest {
    @isTest
    static void checkMissingStudents(){
        
        list<apxio__Student__c> students = new list<apxio__Student__c>();
        
        students.add(new apxio__Student__c(name = 'Vardhan', apxio__Email__c = Null,apxio__Phone__c = '9876648238', apxio__Active__c = true));
        students.add(new apxio__Student__c(name = 'Anil', apxio__Email__c = Null,apxio__Phone__c = null, apxio__Active__c = true));
		students.add(new apxio__Student__c(name = 'Srinu', apxio__Email__c = Null,apxio__Phone__c = null, apxio__Active__c = False));  
        
        insert students;
        
        list<apxio__Student__c> result = MissingStudents.selectStudentsWithoutContactInfo();
        system.assertEquals(2,result.size(),'2 records has been inserted');
    }

}