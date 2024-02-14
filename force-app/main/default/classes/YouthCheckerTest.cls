@isTest
public class YouthCheckerTest {
    @isTest
    static void checkAge(){
        
        string result = YouthChecker.ageGroup(1);
        system.assertEquals('Infant',result,'It is Infant');
        
        string result1 = YouthChecker.ageGroup(10);
        system.assertEquals('Child',result1,'It is Child');
        
        string result2 = YouthChecker.ageGroup(16);
        system.assertEquals('Youth',result2,'It is Youth');
        
        string result3 = YouthChecker.ageGroup(23);
        system.assertEquals('Adult',result3,'It is Adult');
    }
    

}