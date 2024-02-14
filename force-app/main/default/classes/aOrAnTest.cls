@isTest
public class aOrAnTest {
    @isTest
    static void testVowel(){
        

        String result = aOrAn.aOrAnVowel('fruit');
        system.assertEquals('a fruit',result,'this starts with a');
        
        String result1 = aOrAn.aOrAnVowel('apple');
        system.assertEquals('an apple',result1,'this starts with an');
        
        String result2 = aOrAn.aOrAnVowel(Null);
        system.assertEquals(null,result2,'This is Null');
        
    }

}