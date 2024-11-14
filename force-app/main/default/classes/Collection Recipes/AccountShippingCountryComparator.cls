/**
 * @description An example implementation of the Comparator Interface
 * In this example we show how to sort all the accounts by their country names in alphabetical order
 */

public with sharing class AccountShippingCountryComparator implements Comparator<Account> {
    /**
     * @description This exception class is for throwing a custom exception
     */
    public class ASCComparatorException extends Exception {
    }

    public SortOrder order {
        get;
        set {
            order = value;
        }
    }

    // Asc and Desc are reserved keywords in Apex!
    public enum SortOrder {
        ASCENDING,
        DESCENDING
    }

    /**
     * @description No param constructor. Assigns sort order as ascending by default
     */
    public AccountShippingCountryComparator() {
        order = SortOrder.ASCENDING; // use ascending by default
    }

    /**
     * @description Constructor accepting sort order as ascending/descending. Use
     * this constructor to *control* the sort order.
     * @param sortOrder
     */
    public AccountShippingCountryComparator(
        AccountShippingCountryComparator.SortOrder order
    ) {
        if (order == null) {
            throw new ASCComparatorException('Sort order cannot be null');
        }
        this.order = order;
    }

    public Integer compare(Account a1, Account a2) {
        Integer compareResult;
        // Handle null objects before null field values
        if (a1 == null && a2 == null) {
            compareResult = 0;
        } else if (a1 == null) {
            compareResult = -1;
        } else if (a2 == null) {
            compareResult = 1;
        } else {
            String a1ShippingCountry = a1?.ShippingCountry;
            String a2ShippingCountry = a2?.ShippingCountry;
            // Handle null field values then actual value compares
            if (a1ShippingCountry == null && a2ShippingCountry == null) {
                compareResult = 0;
            } else if (a1ShippingCountry == null) {
                compareResult = -1;
            } else if (a2ShippingCountry == null) {
                compareResult = 1;
            } else {
                compareResult = a1.ShippingCountry.compareTo(
                    a2.ShippingCountry
                );
            }
        }
        if (order == SortOrder.DESCENDING) {
            return compareResult * -1; // Inverse the sorting if the sorting order is descending
        }
        return compareResult;
    }
}
