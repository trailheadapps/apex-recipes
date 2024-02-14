@isTest
public class LeapYearTest {
    @isTest
    public static void testLeapYear(){

        boolean result = LeapYear.isLeapYear(2024);
        system.assertEquals(true,result,'Its a leap year');
        
        boolean result1 = LeapYear.isLeapYear(2025);
        system.assertEquals(false,result1,'Its Not a leap year');
    
    }
}