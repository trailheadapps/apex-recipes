/**
 * @description An example implementation of Comparator Interface
 * In this example we show how to sort all the accounts by their country names in alphabetical order
 **/

public with sharing class AccountShippingCountryComparator implements Comparator<Account> {
    public Integer compare(Account a1, Account a2) {
        if (a1?.ShippingCountry == null && a2?.ShippingCountry == null) {
            return 0;
        } else if (a1?.ShippingCountry == null) {
            return -1;
        } else if (a2?.ShippingCountry == null) {
            return 1;
        }
        return a1.ShippingCountry.compareTo(a2.ShippingCountry);
    }
}
