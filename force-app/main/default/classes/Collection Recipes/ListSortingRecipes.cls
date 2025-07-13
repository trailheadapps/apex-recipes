/**
 * @description Demonstrates how to sort lists using the Comparator Interface
 *
 * @group Collection Recipes
 * @see AccountShippingCountryComparator
 * @see AccountNumberOfEmployeesComparator
 */
public with sharing class ListSortingRecipes {
    /**
     * @description Demonstrates how to sort a list of Account using Comparator Interface
     * In this example we pass in the implementation class `AccountShippingCountryComparator`
     * as a parameter to the sort method of a list. This method sorts Accounts
     * by shipping address in ascending alphabetical order
     * @param accounts a list of accounts that will be sorted in place
     */
    public static void sortAccountsByShippingCountry(List<Account> accounts) {
        accounts.sort(new AccountShippingCountryComparator());
    }

    /**
     * @description Demonstrates how to sort a list of Account using Comparator Interface
     * In this example we pass in the implementation class `AccountShippingCountryComparator`
     * as a parameter to the sort method of a list. This method sorts Accounts
     * by shipping address in descending alphabetical order
     * @param accounts a list of accounts that will be sorted in place
     */
    public static void sortAccountsByShippingCountryInDescending(
        List<Account> accounts
    ) {
        accounts.sort(
            new AccountShippingCountryComparator(
                AccountShippingCountryComparator.SortOrder.DESCENDING
            )
        );
    }

    /**
     * @description Demonstrates how to sort a list of Account using Comparator Interface
     * In this example we pass in the implementation class `AccountNumberOfEmployeesComparator`
     * as a parameter to the sort method of a list.This method sorts Accounts
     * by employee number in the ascending order
     * @param accounts a list of accounts that will be sorted in place
     */
    public static void sortAccountsByNumberOfEmployees(List<Account> accounts) {
        accounts.sort(new AccountNumberOfEmployeesComparator());
    }
}
