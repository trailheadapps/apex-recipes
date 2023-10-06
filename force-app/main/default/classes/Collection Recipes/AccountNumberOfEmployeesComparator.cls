/**
 * @description An example implementation of Comparator Interface
 * In this example we show how to sort all the accounts by their employee numbers in ascending order
 **/

public with sharing class AccountNumberOfEmployeesComparator implements Comparator<Account> {
    public Integer compare(Account a1, Account a2) {
        // Guard against null operands for ‘<’ or ‘>’ operators because
        // they will always return false and produce inconsistent sorting
        Integer result;
        if (a1?.NumberOfEmployees == null && a2?.NumberOfEmployees == null) {
            result = 0;
        } else if (a1?.NumberOfEmployees == null) {
            result = -1;
        } else if (a2?.NumberOfEmployees == null) {
            result = 1;
        } else if (a1.NumberOfEmployees < a2.NumberOfEmployees) {
            result = -1;
        } else if (a1.NumberOfEmployees > a2.NumberOfEmployees) {
            result = 1;
        } else {
            result = 0;
        }
        return result;
    }
}
