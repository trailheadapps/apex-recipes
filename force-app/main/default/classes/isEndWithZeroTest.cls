@isTest
public class isEndWithZeroTest {
    @isTest
    Static void TestIsEndZero(){
        
        boolean result = isEndWithZero.isEndWithZeroCheck(12);
        System.assertEquals(false , result, 'Ends with 2');
        
        boolean result1 = isEndWithZero.isEndWithZeroCheck(120);
        assert.isTrue(result1, 'Ends with 0');
        
        boolean result2 = isEndWithZero.isEndWithZeroCheck(99);
        assert.isFalse(result2, 'Ends with 0');
        
               
    }

}