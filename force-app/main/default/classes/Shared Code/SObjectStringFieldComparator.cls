/**
 * Comparator that lets you sort a list of SObject alphabetically based on a String field.
 * @example ListUtils.sort(accounts, new SObjectStringFieldComparator('ShippingCountry'));
 *
 * Tip: don't use this to sort by Name as SObjects are already sorted by Name by default when calling List<SObject>.sort()
 *
 * @group Shared Code
 * @see ListUtils
 */
public class SObjectStringFieldComparator implements ListUtils.Comparator {
    private final String fieldName;

    public SObjectStringFieldComparator(String fieldName) {
        this.fieldName = fieldName;
    }

    public Integer compare(Object o1, Object o2) {
        // Make sure that the two Object instances are SObject instances
        if (!(o1 instanceof SObject && o2 instanceof SObject)) {
            throw new ListUtils.CompareException(
                'Objects must both be SObject in order to be compared: ' +
                    o1 +
                    ' AND ' +
                    o2
            );
        }
        SObject so1 = (SObject) o1;
        SObject so2 = (SObject) o2;

        // We assume that the field value is a String
        // with that, we can cast values to String in order to compare them
        // This cast is required because the Object type cannot be compared with 'greater' operator
        String value1 = (String) so1.get(fieldName);
        String value2 = (String) so2.get(fieldName);
        if (value1 == value2) {
            return 0;
        }
        if (value1 > value2) {
            return 1;
        }
        return -1;
    }
}
