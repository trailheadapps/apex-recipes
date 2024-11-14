/**
 * @description Demonstrates the use of Security.stripInaccessible()
 * and the SObjectAccessDecision object. This helps developers write
 * secure code that prevents users from seeing and accessing fields
 * they cannot access.
 * @group Security Recipes
 */
public with sharing class StripInaccessibleRecipes {
    /**
     * @description Internal custom exception used by this class.
     */
    public class StripInaccessibleRecipesException extends Exception {
    }

    /**
     * @description Demonstrates how to use stripInaccessible to remove fields
     * and objects from a queries results.
     * @example
     * ```
     * System.debug(StripInaccessibleRecipes.stripInaccessibleFromQuery());
     * ```
     */
    public static List<Campaign> stripInaccessibleFromQuery() {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
            AccessType.READABLE,
            [SELECT Name, BudgetedCost, ActualCost FROM Campaign]
        );
        return (List<Campaign>) securityDecision.getRecords();
    }

    /**
     * @description Demonstrates how to use stripInaccessible to remove fields
     * and objects not only from the primary object in this case account but
     * also from related child objects that are queried in this case contacts.
     * @example
     * ```
     * System.debug(StripInaccessibleRecipes.stripInaccessibleFromSubquery());
     * ```
     */
    public static List<Account> stripInaccessibleFromSubquery() {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
            AccessType.READABLE,
            [
                SELECT Id, Name, Phone, (SELECT LastName FROM Account.Contacts)
                FROM Account
            ]
        );
        return (List<Account>) securityDecision.getRecords();
    }

    /**
     * @description Demonstrates how to use stripInacessible in a pre-DML
     * context. This prevents a user from persisting changes to fields and
     * objects the do not have access to.
     * @param contacts A list of Contacts
     * @example
     * ```
     * Contact[] contacts = new Contact[]();
     * for(Integer i = 0, i < 5; i++){
     *      contacts.add(new Contact(lastName='example last name' + i));
     * }
     * stripInaccessibleRecipes.stripInaccessibleBeforeDML(contacts);
     * System.debug([SELECT Id, lastName FROM Contact WHERE lastName like 'example last name%']);
     * ```
     */
    public static void stripInaccessibleBeforeDML(List<Contact> contacts) {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
            AccessType.CREATABLE,
            contacts
        );
        insert securityDecision.getRecords();
    }

    /**
     * @description Demonstrates how to use stripInaccessible to sanitize
     * untrusted data prior to DML. In this case, the code demonstrates how to
     * deserialize a JSON string, and strip fields / objects that the user has
     * no access to. This pattern is especially useful for `@AuraEnabled` methods!
     * @param  jsonText jsonText description
     * @example
     * ```
     * Account acct = new Account(name='Awesome Strip Inaccessible example');
     * insert acct;
     * acct.ShippingStreet = '123 To Be Updated st.';
     * stripInaccessibleRecipes.stripInaccessibleFromUntrustedData(JSON.serialize(acct));
     * System.debug([SELECT Name, ShippingStreet FROM Account WHERE Id = :acct.id]);
     * ```
     */
    public static void stripInaccessibleFromUntrustedData(String jsonText) {
        List<Account> accounts = (List<Account>) JSON.deserialize(
            jsonText,
            List<Account>.class
        );
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
            AccessType.UPDATABLE,
            accounts
        );

        update as user securityDecision.getRecords();
    }
}
