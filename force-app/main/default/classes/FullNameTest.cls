@isTest
public class FullNameTest {
    @isTest
    static void TestNameFormat(){
        
       string result = FullName.formatName('Vinnu','Yadav');
       system.assertEquals('Vinnu Yadav',result,'Concatinated');
        
       string result1 = FullName.formatName(' ','Yadav');
       system.assertEquals('  Yadav',result1,'Concatinated with --');
    }

}