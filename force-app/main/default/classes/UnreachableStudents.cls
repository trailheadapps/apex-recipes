public class UnreachableStudents {
    
    public static List<apxio__Student__c> selectUnreachableStudents() {
        List<apxio__Student__c> unreachableStudents = [SELECT Id, Name
                               FROM apxio__Student__c
                               WHERE apxio__Email__c = NULL AND apxio__Phone__c = NULL
                                     AND apxio__Active__c = true ORDER BY Name];

        return unreachableStudents;
}

}