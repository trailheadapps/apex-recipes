@isTest
public class UnreachableStudentsTest {
    @isTest
    static void testUnreachableStudents(){
        
        list<apxio__Student__c> students = new list<apxio__Student__c>();
        students.add(new apxio__Student__c(Name = 'Anil',apxio__Email__c = Null, apxio__Phone__c = Null, apxio__Active__c = true));
        students.add(new apxio__Student__c(Name = 'Vardhan Sagarla', apxio__Active__c = true));
        students.add(new apxio__Student__c(Name = 'srinu', apxio__Active__c = true));
        
        insert students;
        
        List<apxio__Student__c> result = UnreachableStudents.selectUnreachableStudents();
        system.assertEquals(3, result.size(),'There are three records');
        system.assertNotEquals(null,result.size(),'If there are 0 records');
        
    }

}