@isTest
public class AscendingOrderTest {
    @isTest
    static void TestAscOrder(){
        
        Boolean result = AscendingOrder.ascendingOrderCheck(1, 2, 3);
        system.assertEquals(true, result, 'It is in Asc order');
        
        Boolean result1 = AscendingOrder.ascendingOrderCheck(1, 1, 3);
        system.assertNotEquals(false, result1, 'It is Not in Asc order');
        
        Boolean result2 = AscendingOrder.ascendingOrderCheck(7, 6, 5);
        system.assertEquals(false, result2, 'It is Not in Asc order');

    }
    

}