/**
 * @description Wrapper class around Account that provides an implementation of
 * Comparable based on the ShippingCountry field and an 'in place' sort method.
 */
public class SortableAccount implements Comparable {
    private final Account account;

    public SortableAccount(Account account) {
        this.account = account;
    }

    /**
     * @description compares accounts based on ShippingCountry
     * @param otherObject object used for comparision with this instance
     * @returns 0 if objects are equal, 1 this object is "greater" than `otherObject` or 2 otherwise.
     * @exception Throws SortException if an error occurs while sorting the list. For example, when comparing with an incompatible object type.
     */
    public Integer compareTo(Object otherObject) {
        // For additional type safety, check if otherObject is a SortableAccount
        // if not, throw a SortException
        if (!(otherObject instanceof SortableAccount)) {
            throw new SortException('Can\'t sort with incompatible type');
        }
        // Cast otherObject to SortableAccount and compare it
        SortableAccount other = (SortableAccount) otherObject;
        if (this.account.ShippingCountry == other.account.ShippingCountry) {
            return 0;
        }
        if (this.account.ShippingCountry > other.account.ShippingCountry) {
            return 1;
        }
        return -1;
    }

    /**
     * @description sorts a list of Account records using SortableAccount.compareTo
     * @param accounts list of account to sort
     */
    public static void sort(List<Account> accounts) {
        // Convert List<Account> into List<SortableAccount>
        List<SortableAccount> sortableAccounts = new List<SortableAccount>();
        for (Account acc : accounts) {
            sortableAccounts.add(new SortableAccount(acc));
        }

        // Sort accounts using SortableAccount.compareTo
        sortableAccounts.sort();

        // Overwrite the account list provided in the input parameter
        // with the sorted list. Doing this avoids a return statement
        // and is less verbose for the method user.
        for (Integer i = 0; i < accounts.size(); i++) {
            accounts[i] = sortableAccounts[i].account;
        }
    }

    /**
     * @description Exception thrown when SortableAccount.compareTo fails
     */
    public class SortException extends Exception {
    }
}
