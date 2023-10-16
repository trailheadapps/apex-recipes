/**
 * @description An example implementation of Comparator Interface
 * In this example we show how to sort all the accounts by their country names in alphabetical order
 **/

public with sharing class AccountShippingCountryComparator implements Comparator<Account> {
    /**
     * @description This exception is for throwing a custom exception to
     */
    public class ASCComparatorException extends Exception {
    }

    private String sortOrder;

    private static final Set<String> VALIDSORTORDER = new Set<String>{
        'ascending',
        'descending'
    };

    /**
     * @description No param constructor. Assigns sort order as ascending by default
     */
    public AccountShippingCountryComparator() {
        this.sortOrder = 'ascending'; // use ascending by default
    }

    /**
     * @description    Constructor accepting sort order as ascending/descending. Use
     * this constructor to *control* the sort order.
     * @param sortOrder
     */
    public AccountShippingCountryComparator(String sortOrder) {
        if (!VALIDSORTORDER.contains(sortOrder)) {
            throw new ASCComparatorException('Invalid sort order provided');
        }
        this.sortOrder = sortOrder;
    }

    public Integer compare(Account a1, Account a2) {
        if (a1?.ShippingCountry == null && a2?.ShippingCountry == null) {
            return 0;
        } else if (a1?.ShippingCountry == null) {
            return this.sortOrder == 'descending' ? 1 : -1;
        } else if (a2?.ShippingCountry == null) {
            return this.sortOrder == 'descending' ? -1 : 1;
        }
        return this.sortOrder == 'descending'
            ? a2.ShippingCountry.compareTo(a1.ShippingCountry)
            : a1.ShippingCountry.compareTo(a2.ShippingCountry);
    }
}
