public class StudentRegistration {
    public static String registerStudent(String name, String phone, String email) {
		apxio__Student__c newStudent = new apxio__Student__c();
        
        newStudent.Name = name;
        newStudent.apxio__Phone__c = phone;
        newStudent.apxio__Email__c = email;
        

         insert newStudent;
            
        newStudent = [SELECT apxio__Registration_Number__c FROM apxio__Student__c WHERE Id = :newStudent.Id LIMIT 1];
        
        return newStudent.apxio__Registration_Number__c;
}

}