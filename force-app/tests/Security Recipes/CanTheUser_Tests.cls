@isTest
private inherited sharing class CanTheUser_Tests {
    // These tests rely on the assumption that standard FLS/CRUD have not been modified
    // by the user, and use the Account Object for verification of the Can Logic.

    @isTest
    static void canCrudAccountCreatePositive() {
        System.assert(
            CanTheUser.crud(new Account(), CanTheUser.CrudType.CREATE),
            'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
        );
    }

    @isTest
    static void canCrudCreateAccountPositive() {
        System.assert(
            CanTheUser.create(new Account()),
            'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
        );
    }

    @isTest
    static void canCrudAccountReadPositive() {
        System.assert(
            CanTheUser.crud(new Account(), CanTheUser.CrudType.READ),
            'Expected to be able to read accounts'
        );
    }

    @isTest
    static void canCrudReadAccountPositive() {
        System.assert(
            CanTheUser.read(new Account()),
            'Expected to be able to read accounts'
        );
    }

    @isTest
    static void canCrudAccountUpdatePositive() {
        System.assert(
            CanTheUser.crud(new Account(), CanTheUser.CrudType.EDIT),
            'Expected to be able to update accounts'
        );
    }

    @isTest
    static void canCrudEditAccountPositive() {
        System.assert(
            CanTheUser.edit(new Account()),
            'Expected to be able to update accounts'
        );
    }

    @isTest
    static void canCrudAccountDeletePositive() {
        System.assert(
            CanTheUser.crud(new Account(), CanTheUser.CrudType.DEL),
            'Expected to be able to delete accounts'
        );
    }

    @isTest
    static void canCrudDestroyAccountPositive() {
        System.assert(
            CanTheUser.destroy(new Account()),
            'Expected to be able to delete accounts'
        );
    }

    @isTest
    static void getFLSofAccountNamePositive() {
        System.assert(
            CanTheUser.flsAccessible('Account', 'Name'),
            'Expected the name field to be accesible on Account'
        );
    }

    @isTest
    static void getFLSofAccountIDNegative() {
        System.assert(
            CanTheUser.flsUpdatable('Account', 'id') == false,
            'Expected that the ID of an object cannot be updated.'
        );
    }

    @isTest
    static void getBulkFLSAccessibleWithAccountPositive() {
        Set<String> fields = new Set<String>{ 'name', 'id' };
        Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSAccessible(
            'Account',
            fields
        );
        for (String field : bulkCheck.keySet()) {
            System.assert(
                bulkCheck.get(field),
                'Expected the field to be accesible on Account'
            );
        }
    }

    @isTest
    static void getBulkFLSAccessibleWithAccountPositiveWithNegativeResults() {
        Set<String> fields = new Set<String>{ 'name', 'nonExistingField__c' };
        Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSAccessible(
            'Account',
            fields
        );

        System.assert(
            bulkCheck.get('name'),
            'Expected the name ' + 'field to be accesible on Account'
        );

        System.assert(
            !bulkCheck.get('nonExistingField__c'),
            'Expected the name ' + 'field to be accesible on Account'
        );
    }

    @isTest
    static void getBulkFLSUpdatableWithAccountPositive() {
        Set<String> fields = new Set<String>{ 'name', 'ShippingStreet' };
        Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSUpdatable(
            'Account',
            fields
        );
        for (String field : bulkCheck.keySet()) {
            System.assert(
                bulkCheck.get(field),
                'Expected the field to be accesible on Account'
            );
        }
    }

    @isTest
    static void getBulkFLSUpdatableWithAccountPositiveWithNegativeResults() {
        Set<String> fields = new Set<String>{ 'name', 'nonExistingField__c' };
        Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSUpdatable(
            'Account',
            fields
        );

        System.assert(
            bulkCheck.get('name'),
            'Expected the name ' + 'field to be accesible on Account'
        );

        System.assert(
            !bulkCheck.get('nonExistingField__c'),
            'Expected the name ' + 'field to be accesible on Account'
        );
    }

    @isTest
    static void memoizedFLSMDCcomparesAccesibleToUpdatable() {
        Test.startTest();
        CanTheUser.memoizeFLSMDC('Account', CanTheUser.FLSType.UPDATABLE);
        Test.stopTest();

        System.assertNotEquals(
            CanTheUser.accessibleFieldsByObject.get('Account'),
            CanTheUser.updatableFieldsByObject.get('Account'),
            'Expected that the two sets would be different'
        );
    }
}
