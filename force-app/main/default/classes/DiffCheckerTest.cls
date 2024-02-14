@isTest
public class DiffCheckerTest {
 @isTest
    Static void TestDiffChecker(){
        
        integer result = DiffChecker.diff(5,6);
        System.assertEquals(1,result,'The result is B is greater than A');
        
        integer result1 = DiffChecker.diff(6,5);
        System.assertEquals(1,result1,'The result is A is greater than B');
        
    }
}