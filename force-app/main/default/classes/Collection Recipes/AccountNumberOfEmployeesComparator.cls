/**
 * @description An example implementation of the Comparator Interface
 * In this example we show how to sort all the accounts by their employee numbers in ascending order
 */

public with sharing class AccountNumberOfEmployeesComparator implements Comparator<Account> {
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
            Integer a1NumberOfEmployees = a1?.NumberOfEmployees;
            Integer a2NumberOfEmployees = a2?.NumberOfEmployees;
            // Handle null field values then actual value compares
            if (a1NumberOfEmployees == null && a2NumberOfEmployees == null) {
                compareResult = 0;
            } else if (a1NumberOfEmployees == null) {
                compareResult = -1;
            } else if (a2NumberOfEmployees == null) {
                compareResult = 1;
            } else if (a1NumberOfEmployees < a2NumberOfEmployees) {
                compareResult = -1;
            } else if (a1NumberOfEmployees > a2NumberOfEmployees) {
                compareResult = 1;
            } else {
                compareResult = 0;
            }
        }
        return compareResult;
    }
}
