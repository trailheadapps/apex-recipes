public class InsertCourse {
    public static Id insertCourse(String name, String details, Integer credits) {
 if (!isValidCredits(credits)) {
                // Invalid credits value, return null
                return null;
            }

            // Create a new Course record
            apxio__Course__c newCourse = new apxio__Course__c();
            newCourse.Name = name;
            newCourse.apxio__Course_Details__c = details;
            newCourse.apxio__Credits__c = String.valueOf(credits); // Convert credits to String for picklist

            // Insert the new Course record
            insert newCourse;

            // Return the Id of the newly created record
            return newCourse.Id;


}
    public static boolean isValidCredits(integer credits){
        return(credits >= 1 && credits <= 4);
    }

}