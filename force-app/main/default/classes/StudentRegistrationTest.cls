@isTest
public class StudentRegistrationTest {
    
    @isTest
    static void registrationTest(){
        
        string result = StudentRegistration.registerStudent('Vardhan','968898','vardhan@gmail.com');
        List<apxio__Student__c> student = [SELECT Id, Name, apxio__Phone__c, apxio__Email__c, apxio__Registration_Number__c FROM apxio__Student__c];
        system.assertEquals(1, student.size() ,'Record inserted');
        
        String result1 = StudentRegistration.registerStudent('Jane Doe', '321-654-1234', 'jane@apexsandbox.io');
		List<apxio__Student__c> students = [SELECT Id, Name, apxio__Phone__c, apxio__Email__c, apxio__Registration_Number__c FROM apxio__Student__c];
		System.assertEquals(2, students.size(), 'One student record expected');
		System.assertEquals(result1, students[1].apxio__Registration_Number__c , 'Incorrect Registration Number returned');
		System.assertEquals('Jane Doe', students[1].Name, 'Incorrect Student Name');
		System.assertEquals('321-654-1234', students[1].apxio__Phone__c, 'Incorrect Student Phone');
		System.assertEquals('jane@apexsandbox.io', students[1].apxio__Email__c, 'Incorrect Student Email');
        
    }

}