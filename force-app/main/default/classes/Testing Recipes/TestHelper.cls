@IsTest
/**
 * @description This class serves as a library of useful methods for writing
 * more expressive, cleaner unit tests. Initialy this class contains a method
 * for identifying the name of an object's class expressed as a string.
 * @group Testing Recipes
 */
public class TestHelper {
    /**
     * @description It can be useful to know what the type of an object
     * is at runtime. This is especially useful when you're dynamically
     * instantiating objects in code from the name of a class.
     *
     * I'm not generally a fan of relying on an exception to make logic
     * decisions, but in this case I'll make an exception as this is the
     * cleanest method I've yet found for efficently determining an objects
     * class name that covers edge cases where the object is of an inner class'
     * type.
     *
     * This method parses a TypeException for the true name of a class.
     * It generates the exception by forcing a cast from the Object parameter
     * to DateTime. If no typeException occurs, we know it's a dateTime object.
     * @param obj
     */
    public static String getUnknownObjectType(Object obj) {
        String result = 'DateTime';
        try {
            DateTime typeCheck = (DateTime) obj;
        } catch (System.TypeException expectedTypeException) {
            String message = expectedTypeException.getMessage()
                .substringAfter('Invalid conversion from runtime type ');
            result = message.substringBefore(' to Datetime');
        }

        return result;
    }
}
