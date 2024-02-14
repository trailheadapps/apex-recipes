@isTest
public class WhichTwoTest {
    @isTest
    static void testwhichTwoCheck(){
        
        String result = whichTwo.whichTwoCheck(4, 10, 6);
		System.assertEquals('b', result, 'a and c add up to b');
        
        String result1 = whichTwo.whichTwoCheck(14, 16, 30);
		System.assertEquals('c', result1, 'a and b add up to c');
        
        String result3 = whichTwo.whichTwoCheck(14, -1, 15);
		System.assertEquals('a', result3, 'b and c add up to a');
        
        String result4 = whichTwo.whichTwoCheck(0, -1, 15);
		System.assertEquals('', result4, 'No two numbers add up to a third');
    }

}