@IsTest
private inherited sharing class CanTheUser_Tests {
    // These tests rely on the assumption that standard FLS/CRUD have not been modified
    // by the user, and use the Account Object for verification of the Can Logic.

    @IsTest
    static void canCrudAccountCreatePositive() {
        System.Assert.isTrue(
            CanTheUser.crud(new Account(), CanTheUser.CrudType.CREATE),
            'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
        );
    }

    @IsTest
    static void canCrudCreateAccountPositive() {
        System.Assert.isTrue(
            CanTheUser.create(new Account()),
            'Unless scratch org defaults have been changed by the user, this test should pass - asserting that users can create accounts'
        );
    }

    @IsTest
    static void canCrudAccountReadPositive() {
        System.Assert.isTrue(
            CanTheUser.crud(new Account(), CanTheUser.CrudType.READ),
            'Expected to be able to read accounts'
        );
    }

    @IsTest
    static void canCrudReadAccountPositive() {
        System.Assert.isTrue(
            CanTheUser.read(new Account()),
            'Expected to be able to read accounts'
        );
    }

    @IsTest
    static void canCrudAccountUpdatePositive() {
        System.Assert.isTrue(
            CanTheUser.crud(new Account(), CanTheUser.CrudType.EDIT),
            'Expected to be able to update accounts'
        );
    }

    @IsTest
    static void canCrudEditAccountPositive() {
        System.Assert.isTrue(
            CanTheUser.edit(new Account()),
            'Expected to be able to update accounts'
        );
    }

    @IsTest
    static void canCrudAccountDeletePositive() {
        System.Assert.isTrue(
            CanTheUser.crud(new Account(), CanTheUser.CrudType.DEL),
            'Expected to be able to delete accounts'
        );
    }

    @IsTest
    static void canCrudDestroyAccountPositive() {
        System.Assert.isTrue(
            CanTheUser.destroy(new Account()),
            'Expected to be able to delete accounts'
        );
    }

    @IsTest
    static void getFLSofAccountNamePositive() {
        System.Assert.isTrue(
            CanTheUser.flsAccessible('Account', 'Name'),
            'Expected the name field to be accesible on Account'
        );
    }

    @IsTest
    static void getFLSofAccountIDNegative() {
        System.Assert.isFalse(
            CanTheUser.flsUpdatable('Account', 'id'),
            'Expected that the ID of an object cannot be updated.'
        );
    }

    @IsTest
    static void getBulkFLSAccessibleWithAccountPositive() {
        Set<String> fields = new Set<String>{ 'name', 'id' };
        Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSAccessible(
            'Account',
            fields
        );
        for (String field : bulkCheck.keySet()) {
            System.Assert.isTrue(
                bulkCheck.get(field),
                'Expected the field to be accesible on Account'
            );
        }
    }

    @IsTest
    static void getBulkFLSAccessibleWithAccountPositiveWithNegativeResults() {
        Set<String> fields = new Set<String>{ 'name', 'nonExistingField__c' };
        Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSAccessible(
            'Account',
            fields
        );

        System.Assert.isTrue(
            bulkCheck.get('name'),
            'Expected the name ' + 'field to be accesible on Account'
        );

        System.Assert.isFalse(
            bulkCheck.get('nonExistingField__c'),
            'Expected the name ' + 'field to be accesible on Account'
        );
    }

    @IsTest
    static void getBulkFLSUpdatableWithAccountPositive() {
        Set<String> fields = new Set<String>{ 'name', 'ShippingStreet' };
        Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSUpdatable(
            'Account',
            fields
        );
        for (String field : bulkCheck.keySet()) {
            System.Assert.isTrue(
                bulkCheck.get(field),
                'Expected the field to be accesible on Account'
            );
        }
    }

    @IsTest
    static void getBulkFLSUpdatableWithAccountPositiveWithNegativeResults() {
        Set<String> fields = new Set<String>{ 'name', 'nonExistingField__c' };
        Map<String, Boolean> bulkCheck = CanTheUser.bulkFLSUpdatable(
            'Account',
            fields
        );

        System.Assert.isTrue(
            bulkCheck.get('name'),
            'Expected the name ' + 'field to be accesible on Account'
        );

        System.Assert.isFalse(
            bulkCheck.get('nonExistingField__c'),
            'Expected the name ' + 'field to be accesible on Account'
        );
    }

    @IsTest
    static void memoizedFLSMDCcomparesAccesibleToUpdatable() {
        Test.startTest();
        CanTheUser.memoizeFLSMDC('Account', CanTheUser.FLSType.UPDATABLE);
        Test.stopTest();

        System.Assert.areNotEqual(
            CanTheUser.accessibleFieldsByObject.get('Account'),
            CanTheUser.updatableFieldsByObject.get('Account'),
            'Expected that the two sets would be different'
        );
    }
}
