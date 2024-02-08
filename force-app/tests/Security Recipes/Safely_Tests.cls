@isTest
private class Safely_Tests {
    @isTest
    static void testConstructorChains() {
        Test.startTest();
        Safely instanceOne = new Safely().allOrNothing();
        Safely instanceTwo = new Safely().throwIfRemovedFields();
        Test.stopTest();

        System.Assert.isTrue(
            instanceOne.allOrNothing,
            'Expected Fluent constructor to have set this to true'
        );
        System.Assert.isFalse(
            instanceOne.throwIfRemovedFields,
            'Expected this to remain false'
        );
        System.Assert.isTrue(
            instanceTwo.throwIfRemovedFields,
            'Expected Fluent constructor to have set this to true'
        );
        System.Assert.isFalse(
            instanceTwo.allOrNothing,
            'Expected this to remain false'
        );
    }

    @isTest
    static void testDoInsertMethodsNoThrowPositive() {
        Account account = (Account) new Account(Name = 'TestAccount');
        Test.startTest();
        List<Database.SaveResult> results = new Safely().doInsert(account);
        Test.stopTest();
        System.Assert.areEqual(
            1,
            results.size(),
            'Expected one save result in the list'
        );
        System.Assert.isTrue(results.get(0).success, 'This dml should succeed');
    }

    @isTest
    static void testDoInsertNegative() {
        User minAccessUser = TestFactory.createMinAccessUser(true);

        System.runAs(minAccessUser) {
            System.Assert.isFalse(CanTheUser.create(new Account()));
            Test.startTest();
            Account account = (Account) new Account(Name = 'TestAccount');
            List<Database.SaveResult> results = new Safely().doInsert(account);
            Test.stopTest();
            System.Assert.areEqual(
                0,
                results.size(),
                'Expected zero delete result in the list'
            );
        }
    }

    @isTest
    static void testMarketingProfileGeneratesInsertExceptionPositive() {
        User marketingUser = TestFactory.createMarketingUser(true);
        Boolean didCatchTheRightException = false;
        Account account = (Account) new Account(
            Name = 'TestAccount',
            TradeStyle = 'invalid'
        );
        Test.startTest();
        System.runAs(marketingUser) {
            try {
                new Safely().throwIfRemovedFields().doInsert(account);
            } catch (Safely.RemovedFieldsException rfe) {
                if (
                    rfe.getMessage()
                        .containsIgnoreCase('and the following fields')
                ) {
                    didCatchTheRightException = true;
                }
            }
        }
        Test.stopTest();
        System.Assert.isTrue(
            didCatchTheRightException,
            'Expected to have caught a removedFieldsException'
        );
    }

    @isTest
    static void testDoUpdateMethodsNoThrowPositive() {
        Account account = (Account) new Account(Name = 'TestAccount');
        insert account;
        account.Name = 'TestAccount2';
        Test.startTest();
        List<Database.SaveResult> results = new Safely().doUpdate(account);
        Test.stopTest();
        System.Assert.areEqual(
            1,
            results.size(),
            'Expected one save result in the list'
        );
        System.assert(results.get(0).success, 'This dml should succeed');
    }

    @isTest
    static void testDoUpdateNegative() {
        User minAccessUser = TestFactory.createMinAccessUser(true);

        PermissionSet ps = new PermissionSet(
            Label = 'testPermSet',
            Name = 'testPermSet'
        );
        insert ps;
        ObjectPermissions op = new ObjectPermissions(
            ParentId = ps.Id,
            SobjectType = 'Account'
        );
        op.PermissionsRead = true;
        op.PermissionsCreate = true;
        op.PermissionsEdit = false;
        insert op;

        insert new PermissionSetAssignment(
            PermissionSetId = ps.Id,
            AssigneeId = minAccessUser.Id
        );
        System.runAs(minAccessUser) {
            Account account = (Account) new Account(name = 'TestAccount');
            System.Assert.isTrue(CanTheUser.create(account));
            TriggerHandler.bypass('AccountTriggerHandler');
            insert account;

            Test.startTest();
            account.Name = 'UpdatedAccount';
            System.Assert.isFalse(CanTheUser.edit(account));
            List<Database.SaveResult> results = new Safely().doUpdate(account);
            Test.stopTest();

            System.Assert.areEqual(
                0,
                results.size(),
                'Expected zero update results in the list'
            );
        }
    }

    @isTest
    static void testMarketingProfileDeleteNegative() {
        User marketingUser = TestFactory.createMarketingUser(true);
        Case c = (Case) new Case(Subject = 'TestCase');
        insert c;

        System.runAs(marketingUser) {
            Test.startTest();

            List<Database.DeleteResult> results = new Safely().doDelete(c);
            Test.stopTest();
            System.Assert.areEqual(
                0,
                results.size(),
                'Expected zero delete result in the list'
            );
        }
    }

    @isTest
    static void testMarketingProfileGeneratesUpdateExceptionPositive() {
        User marketingUser = TestFactory.createMarketingUser(true);
        Boolean didCatchTheRightException = false;
        Account account = (Account) new Account(Name = 'TestAccount');
        insert account;
        account.TradeStyle = 'off limits field';
        Test.startTest();
        System.runAs(marketingUser) {
            try {
                new Safely().throwIfRemovedFields().doUpdate(account);
            } catch (Safely.RemovedFieldsException rfe) {
                if (
                    rfe.getMessage()
                        .containsIgnoreCase('and the following fields')
                ) {
                    didCatchTheRightException = true;
                }
            }
        }
        Test.stopTest();
        System.Assert.isTrue(
            didCatchTheRightException,
            'Expected to have caught a removedFieldsException'
        );
    }

    @isTest
    static void testDoUpsertMethodsNoThrowPositive() {
        Account account = (Account) new Account(Name = 'TestAccount');
        insert account;
        account.Name = 'TestAccount2';
        Account account2 = (Account) new Account(Name = 'TestAccount');
        List<Account> accounts = new List<Account>{ account, account2 };
        Test.startTest();
        List<Database.upsertResult> insertResults = new Safely()
            .doUpsert(account);
        List<Database.UpsertResult> mixedResults = new Safely()
            .doUpsert(accounts);
        Test.stopTest();
        System.Assert.areEqual(
            1,
            insertResults.size(),
            'Expected one save result in the list'
        );
        System.assertEquals(2, mixedResults.size(), 'expected two results');
        System.assert(insertResults.get(0).success, 'This dml should succeed');
        Integer updated = 0;
        Integer inserted = 0;
        for (Database.upsertResult result : mixedResults) {
            System.Assert.isTrue(result.success, 'This dml should succeed');
            if (result.created) {
                inserted++;
            } else {
                updated++;
            }
        }
        System.assert.areEqual(1, updated, 'Expected one to have been updated');
        System.assert.areEqual(
            1,
            inserted,
            'Expected one to have been inserted'
        );
    }

    @isTest
    static void testDoUpsertMethodsNegative() {
        User minAccessUser = TestFactory.createMinAccessUser(true);

        PermissionSet ps = new PermissionSet(
            Label = 'testPermSet',
            Name = 'testPermSet'
        );
        insert ps;
        ObjectPermissions op = new ObjectPermissions(
            ParentId = ps.Id,
            SobjectType = 'Account'
        );
        op.PermissionsRead = true;
        op.PermissionsCreate = true;
        op.PermissionsEdit = false;
        insert op;

        insert new PermissionSetAssignment(
            PermissionSetId = ps.Id,
            AssigneeId = minAccessUser.Id
        );

        System.runAs(minAccessUser) {
            Account account = (Account) new Account(Name = 'TestAccount01');
            Account account2 = (Account) new Account(Name = 'TestAccount02');

            Test.startTest();
            TriggerHandler.bypass('AccountTriggerHandler');
            List<Database.SaveResult> insertResults = new Safely()
                .doInsert(account);
            account.Name = 'TestAccount2';
            List<Account> accounts = new List<Account>{ account, account2 };
            List<Database.UpsertResult> mixedResults = new Safely()
                .doUpsert(accounts);
            Test.stopTest();
            System.Assert.areEqual(
                1,
                insertResults.size(),
                'Expected one save result in the list'
            );
            System.Assert.isTrue(
                insertResults.get(0).success,
                'This dml should succeed but we got: ' +
                insertResults.get(0).errors
            );
            System.assert(mixedResults.isEmpty(), 'expected no updates');
        }
    }

    @isTest
    static void testMarketingProfileGeneratesUpsertExceptionPositive() {
        User marketingUser = TestFactory.createMarketingUser(true);
        Boolean didCatchTheRightException = false;
        Account account = (Account) new Account(Name = 'TestAccount');
        insert account;
        account.TradeStyle = 'off limits field';
        Test.startTest();
        System.runAs(marketingUser) {
            try {
                new Safely().throwIfRemovedFields().doUpsert(account);
            } catch (Safely.RemovedFieldsException rfe) {
                if (
                    rfe.getMessage()
                        .containsIgnoreCase('and the following fields')
                ) {
                    didCatchTheRightException = true;
                }
            }
        }
        Test.stopTest();
        System.Assert.isTrue(
            didCatchTheRightException,
            'Expected to have caught a removedFieldsException'
        );
    }

    @isTest
    static void testDeleteWithRegularProfilePositive() {
        Account account = (Account) new Account(Name = 'TestAccount');
        insert account;
        Test.startTest();
        List<Database.deleteResult> results = new Safely()
            .throwIfRemovedFields()
            .doDelete(account);
        Test.stopTest();
        System.Assert.isTrue(
            results.get(0).success,
            'expected this dml to succeed'
        );
    }

    @isTest
    static void testDeleteWithRegularProfileNegative() {
        User minAccessUser = TestFactory.createMinAccessUser(true);
        Account account = (Account) new Account(Name = 'TestAccount');
        insert account;
        Test.startTest();
        List<Database.deleteResult> results;
        System.runAs(minAccessUser) {
            results = new Safely().throwIfRemovedFields().doDelete(account);
        }

        Test.stopTest();
        System.Assert.isTrue(results.isEmpty(), 'expected this dml to fail');
    }

    @isTest
    static void testDoQueryPositive() {
        Account account = (Account) new Account(Name = 'TestAccount');
        insert account;
        Test.startTest();
        List<Account> accounts = (List<Account>) new Safely()
            .throwIfRemovedFields()
            .doQuery('SELECT Id, Name FROM Account');
        Test.stopTest();
        System.Assert.areEqual(
            1,
            Accounts.size(),
            'expected to find one record'
        );
    }

    @isTest
    static void testDoQueryThrowsRemovedFieldsException() {
        User minAccessUser = TestFactory.createMinAccessUser(true);

        PermissionSet ps = new PermissionSet(
            Label = 'testPermSet',
            Name = 'testPermSet'
        );
        insert ps;
        ObjectPermissions op = new ObjectPermissions(
            ParentId = ps.Id,
            SobjectType = 'Account'
        );
        op.PermissionsRead = true;
        op.PermissionsViewAllRecords = true;
        insert op;
        insert new PermissionSetAssignment(
            PermissionSetId = ps.Id,
            AssigneeId = minAccessUser.Id
        );

        System.runAs(new User(Id = UserInfo.getUserId())) {
            Account account = (Account) new Account(Name = 'TestAccount');
            insert account;
        }
        System.runAs(minAccessUser) {
            Boolean didCatchTheRightException = false;
            Test.startTest();
            Safely saf = new Safely();
            try {
                List<Account> accounts = (List<Account>) saf
                    .throwIfRemovedFields()
                    .doQuery('SELECT Id, Name, TradeStyle FROM Account');
            } catch (Safely.RemovedFieldsException rfe) {
                if (rfe.getMessage().containsIgnoreCase('TradeStyle')) {
                    didCatchTheRightException = true;
                }
            }
            Test.stopTest();
            System.Assert.isTrue(saf.throwIfRemovedFields);
            System.Assert.isTrue(
                didCatchTheRightException,
                'Expected to have caught a removedFieldsException'
            );
        }
    }

    @isTest
    static void emptyCollections() {
        Test.startTest();
        List<Database.SaveResult> insertResults = new Safely()
            .doInsert(new List<Account>());
        List<Database.SaveResult> updateResults = new Safely()
            .doUpdate(new List<Account>());
        List<Database.UpsertResult> upsertResults = new Safely()
            .doUpsert(new List<Account>());
        List<Database.DeleteResult> deleteResults = new Safely()
            .doDelete(new List<Account>());
        Test.stopTest();

        System.Assert.isTrue(insertResults.isEmpty());
        System.Assert.isTrue(updateResults.isEmpty());
        System.Assert.isTrue(upsertResults.isEmpty());
        System.Assert.isTrue(deleteResults.isEmpty());
    }
}
