@isTest
public class InsertCourseTest {
    @isTest
    static void testCourse(){
    
    Id result = InsertCourse.insertCourse('Apex Programming 101', 'Basics of apex programming.', 3);
	List<apxio__Course__c> courses = [SELECT Id, Name, apxio__Course_Details__c, apxio__Credits__c FROM apxio__Course__c];
	System.assertEquals(1, courses.size(), 'One course record expected');
	System.assertEquals(result, courses[0].Id, 'Incorrect Id returned');
	System.assertEquals('Apex Programming 101', courses[0].Name, 'Incorrect Course Name');
	System.assertEquals('Basics of apex programming.', courses[0].apxio__Course_Details__c, 'Incorrect Course Details returned');
        
	Id result1 = InsertCourse.insertCourse('Apex Programming 102', 'Advanced Apex Programming', 5);
	System.assertEquals(null, result1, 'Returned ID should have been null');
	List<apxio__Course__c> coursesNull = [SELECT Id, Name, apxio__Course_Details__c, apxio__Credits__c FROM apxio__Course__c];
	System.assertEquals(1, coursesNull.size(), 'No course records expected in the database');
    }
}