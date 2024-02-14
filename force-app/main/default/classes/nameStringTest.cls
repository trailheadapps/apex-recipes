@isTest
public class nameStringTest {
    @isTest
    static void testNameString(){
        
        string result = nameString.nameFromEmail('vardhan.sagarla@gmail.com');
        system.assertEquals('Vardhan Sagarla',result,'Succeded');

        string result1 = nameString.nameFromEmail('vardhan.nani@gmail.com');
        system.assertEquals('Vardhan Nani',result1,'Succeded');
        
        
    }

}