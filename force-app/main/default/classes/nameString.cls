public class nameString {
    public static String nameFromEmail(String email) {
 
 String firstName = capitalize(email.substringBefore('.').toLowerCase());

        // Extract last name
        String lastName = capitalize(email.substringBetween('.', '@').toLowerCase());

        // Combine first name and last name with a space
        String fullName = firstName + ' ' + lastName;

        return fullName;
    }

    private static String capitalize(String input) {
        // Capitalize the first letter of a string
        return input.substring(0, 1).toUpperCase() + input.substring(1);
    }

}