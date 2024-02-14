@isTest
public class SumEqualsTest {
    @isTest
    static void TestSumEquals(){
        
        boolean result = SumEquals.giveSumEquals(1,2,3);
        System.assertNotEquals(false,result, 'Sum Equals' );
        
        boolean result1 = SumEquals.giveSumEquals(5,6,3);
        System.assertEquals(false,result1, 'Sum Not Equals' );
        
        boolean result2 = SumEquals.giveSumEquals(3,3,6);
        System.assertEquals(True,result2, 'Sum Equals' );
        
    }
    

}