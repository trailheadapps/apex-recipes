@isTest
public class NameFormatTest {
    @isTest
    static void Nametest(){
        
        String fullName = NameFormat.formatName('Vardhan', 'Sagarla');
		System.assertEquals('Sagarla, Vardhan', fullName, 'Full name should have been Vardhan, Sagarla');
                
        String fullName1 = NameFormat.formatName('Vardhan', ' ');
		System.assertEquals('Vardhan', fullName1, 'Full name should have been Vardhan');
        
        String fullName2 = NameFormat.formatName(' ', ' ');
		System.assertEquals('', fullName2, 'Full name should have been --');
        
         String fullName3 = NameFormat.formatName('', 'yadav');
		System.assertEquals('yadav', fullName3, 'Full name should have been Vardhan');
        
    }

}