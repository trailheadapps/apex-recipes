/**
 * @description This is a utility class for List operations.
 * It provides a method that allows to sort lists in place with reusable comparators.
 * See SObjectStringFieldComparator for tests.
 *
 * @group Shared Code
 * @see SObjectStringFieldComparator
 */
public class ListUtils {
    /**
     * @description sorts a list of objects using bubble sort algorithm and a comparator
     * @param objects a list of objects that will be sorted
     * @param comparator an instance of the Comparator interface that describes the ordering logic used for sorting
     */
    public static void sort(List<Object> objects, Comparator comparator) {
        final Integer n = objects.size();
        for (Integer i = 0; i < n - 1; i++) {
            for (Integer j = 0; j < n - i - 1; j++) {
                if (comparator.compare(objects[j], objects[j + 1]) > 0) {
                    Object temp = objects[j];
                    objects[j] = objects[j + 1];
                    objects[j + 1] = temp;
                }
            }
        }
    }

    /**
     * @description interface that specifies how two objects should be compared for ordering
     */
    public interface Comparator {
        /**
         * @description compares two objects
         * @returns 0 if objects are equal, 1 first object is 'greater' than the second or 2 otherwise.
         * @exception Throws CompareException if an error occurs while comparing objects. For example, when comparing incompatible object types.
         */
        Integer compare(Object o1, Object o2);
    }

    /**
     * @description Exception thrown when Comparator.compare fails
     */
    public class CompareException extends Exception {
    }
}
