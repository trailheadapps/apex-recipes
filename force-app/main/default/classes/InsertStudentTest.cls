@isTest
public class InsertStudentTest {
    @isTest
    static void StudentTest(){
        
        Id result = InsertStudent.insertStudent('vardhan','vardhan@gmail.com');
        list<apxio__Student__c> newStudent = [Select id, name ,apxio__Email__c from apxio__Student__c];
        system.assertEquals('vardhan',newStudent[0].Name,'it is name ');
        system.assertEquals(result,newStudent[0].Id,'Incorrect Id');
        
        id result1 = InsertStudent.insertStudent('Anil','anil@gmail.com');
        list<apxio__Student__c> Student = [Select id, name ,apxio__Email__c from apxio__Student__c];
        system.assertEquals('Anil',Student[1].Name, 'Name of second student');
        system.assertEquals('anil@gmail.com',Student[1].apxio__Email__c,'Email of the student');
        system.assertEquals(result1,Student[1].id, 'incorrect id' );
           
    }
    
}