@isTest
public class FindLargestTest {
    @isTest
    static void LargestTest(){
        
        integer result = FindLargest.findLargestNum(10, 5, 3);
        system.assertEquals(10, result, 'Num1 is the highest');
        
        integer result1 = FindLargest.findLargestNum(1, 5, 3);
        system.assertEquals(5, result1, 'Num2 is the highest');
        
        integer result2 = FindLargest.findLargestNum(1, 2, 3);
        system.assertEquals(3, result2, 'Num3 is the highest');
        
        integer result3 = FindLargest.findLargestNum(Null, Null, Null);
        system.assertEquals(null, result3, 'Null');
                       
    }

}