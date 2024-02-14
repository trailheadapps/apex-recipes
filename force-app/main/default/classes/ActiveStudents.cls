public class ActiveStudents {
    
    public static List<apxio__Student__c> selectActiveStudents() {
    // code here
    List<apxio__Student__c> Students = [Select Id,name from apxio__Student__c where apxio__Active__c = true];

    return Students;
}

}