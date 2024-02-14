@isTest
public class AgeCheckerTest {
    @isTest
    Static Void testIsTeenager(){
        
		Boolean result = AgeChecker.isTeenager(0);
		System.assertEquals(false, result, '0 years old is not a teenager');
        
        
        Boolean result1 = AgeChecker.isTeenager(13);
        System.assertEquals(True, result1, '13 years old is a teenager');
            
    }
}