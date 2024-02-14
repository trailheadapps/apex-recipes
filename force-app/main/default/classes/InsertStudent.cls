public class InsertStudent {
    
    public static Id insertStudent(String name, String email) {

            apxio__Student__c newStudent = new apxio__Student__c();
            newStudent.Name = name;
            newStudent.apxio__Email__c = email;
            insert newStudent;

            return newStudent.Id;
        }


}