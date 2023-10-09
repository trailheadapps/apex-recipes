@isTest
/**
 * @description: Tests the ListSortingRecipes class used in list sorting recipes.
 */
public class ListSortingRecipes_Tests {
    private final static Account A1 = new Account(
        ShippingCountry = 'A',
        NumberOfEmployees = 100
    );
    private final static Account A2 = new Account(
        ShippingCountry = 'A',
        NumberOfEmployees = 50
    );
    private final static Account A3 = new Account(
        ShippingCountry = 'B',
        NumberOfEmployees = 20
    );
    private final static Account A4 = new Account(
        ShippingCountry = 'C',
        NumberOfEmployees = 60
    );
    private final static Account A1NULL = new Account();
    private final static Account A2NULL = new Account();

    @isTest
    private static void testSortAccountsByShippingCountry() {
        List<Account> accounts = new List<Account>{
            A4,
            A2,
            A2NULL,
            A3,
            A1NULL,
            A1
        };
        Test.startTest();
        ListSortingRecipes.sortAccountsByShippingCountry(accounts);
        Test.stopTest();
        List<Account> expected = new List<Account>{
            A2NULL,
            A1NULL,
            A2,
            A1,
            A3,
            A4
        };
        System.Assert.areEqual(expected, accounts);
    }

    @isTest
    private static void testSortAccountsByShippingCountryInDescending() {
        List<Account> accounts = new List<Account>{
            A4,
            A2,
            A2NULL,
            A3,
            A1NULL,
            A1
        };
        Test.startTest();
        ListSortingRecipes.sortAccountsByShippingCountryInDescending(accounts);
        Test.stopTest();
        List<Account> expected = new List<Account>{
            A4,
            A3,
            A2,
            A1,
            A1NULL,
            A2NULL
        };
        System.Assert.areEqual(expected, accounts);
    }

    @isTest
    private static void testASCComparatorException() {
        List<Account> accounts = new List<Account>{
            A4,
            A2,
            A2NULL,
            A3,
            A1NULL,
            A1
        };
        Test.startTest();
        try {
            accounts.sort(new AccountShippingCountryComparator('asc'));
        } catch (exception e) {
            Assert.isInstanceOfType(
                e,
                AccountShippingCountryComparator.ASCComparatorException.class,
                'Expected an instance of ASCComparatorException'
            );
        }
        Test.stopTest();
    }

    @isTest
    private static void testSortAccountsByNumberOfEmployees() {
        List<Account> accounts = new List<Account>{
            A1,
            A2,
            A2NULL,
            A3,
            A1NULL,
            A4
        };
        Test.startTest();
        ListSortingRecipes.sortAccountsByNumberOfEmployees(accounts);
        Test.stopTest();
        List<Account> expected = new List<Account>{
            A1NULL,
            A2NULL,
            A3,
            A2,
            A4,
            A1
        };
        System.Assert.areEqual(expected, accounts);
    }
}
