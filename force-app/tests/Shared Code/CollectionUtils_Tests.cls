@isTest
private class CollectionUtils_Tests {
    @isTest
    static void testDemonstrateIdMapFromCollectionByKeyPositiveWithList() {
        List<Account> accounts = (List<Account>) TestFactory.createSObjectList(
            new Account(),
            5,
            true
        );
        List<Contact> contacts = (List<Contact>) TestFactory.createSObjectList(
            new Contact(),
            5,
            true
        );

        Test.startTest();
        Map<Id, Account> checkAccountMap = (Map<Id, Account>) CollectionUtils.idMapFromCollectionByKey(
            'id',
            accounts
        );
        Map<Id, Contact> checkContactMap = (Map<Id, Contact>) CollectionUtils.idMapFromCollectionByKey(
            'id',
            contacts
        );
        Test.stopTest();

        System.Assert.areEqual(
            5,
            checkAccountMap.keySet().size(),
            'Expected to get 5 accounts back'
        );
        System.Assert.areEqual(
            5,
            checkContactMap.keySet().size(),
            'Expected to get 5 contacts back'
        );

        for (id accountId : checkAccountMap.keySet()) {
            System.Assert.areEqual(
                Account.getSObjectType(),
                checkAccountMap.get(accountId).getSObjectType(),
                'We expected the map to have accounts'
            );
        }

        for (id contactId : checkContactMap.keySet()) {
            System.Assert.areEqual(
                Contact.getSObjectType(),
                checkContactMap.get(contactId).getSObjectType(),
                'We expected the map to have Contact'
            );
        }
    }

    @isTest
    static void testDemonstrateStringMapFromCollectionByKeyPositiveWithList() {
        List<Account> accounts = (List<Account>) TestFactory.createSObjectList(
            new Account(),
            5,
            true
        );
        for (Account acct : accounts) {
            acct.name = acct.id;
        }
        update accounts;
        Test.startTest();
        Map<String, Account> checkAccountMap = (Map<String, Account>) CollectionUtils.stringMapFromCollectionByKey(
            'name',
            accounts
        );

        Test.stopTest();

        System.Assert.areEqual(
            5,
            checkAccountMap.keySet().size(),
            'Expected to get 5 accounts back'
        );

        for (id accountId : checkAccountMap.keySet()) {
            System.Assert.areEqual(
                Account.getSObjectType(),
                checkAccountMap.get(accountId).getSObjectType(),
                'We expected the map to have accounts'
            );
        }
    }

    @isTest
    static void testMapFromCollectionWithListOfValuesPostive() {
        List<Account> accounts = (List<Account>) TestFactory.createSObjectList(
            new Account(),
            5,
            true
        );

        List<Contact> contactList = new List<Contact>();
        for (Account acct : accounts) {
            contactList.addAll(
                (List<Contact>) TestFactory.createSObjectList(
                    new Contact(accountId = acct.id),
                    5,
                    false
                )
            );
        }
        insert contactList;

        Test.startTest();
        Map<Id, List<Contact>> checkResults = (Map<Id, List<Contact>>) CollectionUtils.mapFromCollectionWithCollectionValues(
            'AccountId',
            contactList
        );
        Test.stopTest();

        System.Assert.areEqual(
            5,
            checkResults.keyset().size(),
            'Expected to find 5 accountIds'
        );

        for (Id accountId : checkResults.keySet()) {
            System.Assert.areEqual(
                Account.getSObjectType(),
                accountId.getSobjectType(),
                'Expected keys to be accounts'
            );
            System.Assert.areEqual(
                5,
                checkResults.get(accountId).size(),
                'Expected to find 5 entries in the list '
            );
            for (Contact contact : checkResults.get(accountId)) {
                System.Assert.areEqual(
                    Contact.getSObjectType(),
                    contact.getSObjectType(),
                    'Expected to find contacts'
                );
            }
        }
    }
}
