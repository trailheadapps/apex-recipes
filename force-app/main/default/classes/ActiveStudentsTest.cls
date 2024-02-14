@isTest
public class ActiveStudentsTest {
    @isTest
    static void testActiveStudens(){
        
        List<apxio__Student__c> students = new list<apxio__Student__c>();
        
		students.add(new apxio__Student__c(Name = 'Gina Woods', apxio__Active__c = true)); 
   	 	  
        
        insert students;
        
        List<apxio__Student__c> result = ActiveStudents.selectActiveStudents();
       	System.assertEquals(1, result.size(), 'Expected to see 1 student records');
            
    }

}