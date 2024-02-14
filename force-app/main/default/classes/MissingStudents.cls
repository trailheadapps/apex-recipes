public class MissingStudents {
    public static List<apxio__Student__c> selectStudentsWithoutContactInfo() {
    // code here
    List<apxio__Student__c> Students = [Select id, name from apxio__Student__c
                                            where (apxio__Email__c = Null Or apxio__Phone__c = Null) 
                                            and apxio__Active__c = true 
                                            ORDER by name];

                                            return Students;
}

}