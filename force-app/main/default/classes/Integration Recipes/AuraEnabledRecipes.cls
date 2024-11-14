/**
 * @description Demonstrates how to expose a class method to Aura and LWC
 * components. Also demonstrates how to return an AuraHandledException.
 * @group Integration Recipes
 */
public with sharing class AuraEnabledRecipes {
    @SuppressWarnings('PMD.ApexCRUDViolation')
    @AuraEnabled
    /**
     * @description Updates a given account's name. Demonstrates how to receive
     * information from an Aura or LWC component and use it to update an
     * account.
     *
     * Note: This method contains a false-positive PMD warning. PMD
     * is not aware of what CanTheUser is doing, and it falsely assumes
     * that this code does not check for FSL / CRUD before querying.
     * Additionally, this query contains 'WITH SECUIRTY_ENFORCED' a
     * form of inline FLS/CRUD checking.
     *
     * @param  accountId Id of the account to update
     * @param  newValue  String of the name to set
     * @example
     * ```
     * Id accountId = [SELECT Id FROM Account LIMIT 1].Id;
     * System.debug(AuraEnabledRecipes.updateAccountName(accountId, 'New value set by AuraEnabled method'));
     * ```
     */
    public static Boolean updateAccountName(Id accountId, String newValue) {
        Account acct = [
            SELECT Id
            FROM Account
            WHERE Id = :accountId
            WITH USER_MODE
            LIMIT 1
        ];
        acct.Name = newValue;

        /**
         * SecurityDecision is a realtively new object type.
         * It is the result object created when you call
         * Security.stripInaccessible() Its methods allow you
         * to, among other things, access a sanitized list of records
         *
         * stripInaccessible() requires an AccessType enum, in this
         * case UPDATABLE, and a list of objects to check.
         */
        try {
            SObjectAccessDecision securityDecision = Security.stripInaccessible(
                AccessType.UPDATABLE,
                new List<Account>{ acct }
            );
            update as user securityDecision.getRecords();
        } catch (DmlException dmle) {
            throw new AuraHandledException('DML Failed: ' + dmle.getMessage());
        }
        return true;
    }

    @AuraEnabled(cacheable=true)
    /**
     * @description Demonstrates how to make a method available to Aura or LWC
     * for read-only operations. This method returns a hard-coded string, but
     * you could do a SOQL query, or other work.
     * @example
     * ```
     * System.debug(AuraEnabledRecipes.getFieldValue());
     * ```
     */
    public static String getFieldValue() {
        return 'hello world';
    }
}
