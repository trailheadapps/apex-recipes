@isTest
public class CheckOddorEvenTest {
    @isTest
    static void testOddorEven(){
        
       	string result = CheckOddorEven.evenOrOdd(11);
        system.assertEquals('odd',result,'it is odd');
        
        string result1 = CheckOddorEven.evenOrOdd(12);
        system.assertEquals('even',result1,'it is Even');
        
        String result2 = CheckOddorEven.evenOrOdd(0);
        System.assertEquals('even', result2, '0 should have returned 0');
        
    }  	
}