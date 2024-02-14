@isTest
public class isPassedTest {
    @isTest
    static void passCheckertest(){
        
        boolean result = isPassed.isPassedCheck(false, false, true);
        system.assertEquals(false, result, 'It should return false');
        
        boolean result1 = isPassed.isPassedCheck(false, true, true);
        system.assertEquals(true, result1, 'It should return true');

        boolean result2 = isPassed.isPassedCheck(true, true, true);
        system.assertEquals(true, result2, 'It should return true');
        
        boolean result3 = isPassed.isPassedCheck(true, true, false);
        system.assertEquals(true, result3, 'It should return true');
        
    }

}