/**
 * @description Demonstrates how to sort lists with custom ordering logic
 *
 * @group Collection Recipes
 * @see ListUtils, SortableAccount, SObjectStringFieldComparator
 */
public with sharing class ListSortingRecipes {
    /**
     * @description Demonstrates how to sort a list of SObject in place
     * (without the need for a return statement).
     * This example shows how to sort Accounts based on the ShippingCountry field.
     * We use a SortableAccount wrapper class in order to implement the
     * Comparable interface so that we can use List.sort() with SObject.
     * @param accounts a list of accounts that will be sorted in place
     **/
    public static void sortAccountsWithSortableWrapper(List<Account> accounts) {
        SortableAccount.sort(accounts);
    }

    /**
     * @description Demonstrates how to sort a list of SObject in place with reusable comparators.
     * This example shows how to sort Accounts based on the ShippingCountry field.
     * We use a generic ListUtils utility class with a SObjectStringFieldComparator class
     * that implements the ListUtils.Comparator interface.
     * @param accounts a list of accounts that will be sorted in place
     **/
    public static void sortAccountsWithComparator(List<Account> accounts) {
        ListUtils.sort(
            accounts,
            new SObjectStringFieldComparator('ShippingCountry')
        );
    }
}
