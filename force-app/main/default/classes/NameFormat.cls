public class NameFormat {
    public static String formatName(String firstName, String lastName) {
    //code here
        if (String.isBlank(firstName) && String.isBlank(lastName)) {
            return ''; 
        } else if (String.isBlank(firstName)) {
            return lastName; 
        } else if (String.isBlank(lastName)) {
            return firstName;
        } else {
            return lastName + ', ' + firstName; 
        }
}


}