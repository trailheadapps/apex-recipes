@isTest
private inherited sharing class CustomRestEndpointRecipes_Tests {
    @isTest
    static void httpCalloutGetRecordsToReturnPositive() {
        TestFactory.createSObjectList(new Account(), 5, true);
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'GET';
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.getRecordsToReturn();
        List<Account> accountRecords = (List<Account>) JSON.deserialize(
            calloutResponse,
            List<Account>.class
        );
        Test.stopTest();

        System.Assert.areEqual(
            Account.SObjectType,
            accountRecords.getSObjectType(),
            'Account object was not returned'
        );
        System.Assert.areEqual(
            5,
            accountRecords.size(),
            'The correct number of accounts was not returned, expected 5, got ' +
            accountRecords.size()
        );
    }

    @isTest
    static void httpCalloutGetRecordsToReturnNegativeStringReturn() {
        List<Account> allAccounts = [SELECT Id, Name FROM Account];
        System.Assert.areEqual(
            0,
            allAccounts.size(),
            'Accounts size should be 0 before code execution'
        );

        CustomRestEndpointRecipes.circuitBreaker = new QueryException(
            'testing'
        );
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'GET';
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.getRecordsToReturn();
        Test.stopTest();

        System.Assert.isTrue(
            calloutResponse.containsIgnoreCase('testing'),
            'Expected to have caught a Query exception and returned the query exception string'
        );
    }

    @isTest
    static void httpCalloutDeleteSingleContactPositive() {
        SObject contact = TestFactory.createSObject(
            new Contact(LastName = 'test'),
            true
        );
        RestRequest request = new RestRequest();
        System.debug(LoggingLevel.INFO, contact.Id);
        request.requestUri =
            '/services/apexrest/integration-service/' + contact.Id;
        request.httpMethod = 'DELETE';
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.deleteSingleContact();
        System.debug(LoggingLevel.INFO, calloutResponse);
        Test.stopTest();

        System.Assert.areEqual(
            'Successful Delete',
            calloutResponse,
            'Expected successful delete'
        );
    }

    @isTest
    static void httpCalloutDeleteSingleContactNegativeQueryException() {
        SObject contact = TestFactory.createSObject(
            new Contact(LastName = 'test'),
            true
        );
        RestRequest request = new RestRequest();
        CustomRestEndpointRecipes.circuitBreaker = new QueryException(
            'testing'
        );
        System.debug(LoggingLevel.INFO, contact.Id);
        request.requestUri =
            '/services/apexrest/integration-service/' + contact.Id;
        request.httpMethod = 'DELETE';
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.deleteSingleContact();
        System.debug(LoggingLevel.INFO, calloutResponse);
        Test.stopTest();
        System.Assert.isTrue(
            calloutResponse.containsIgnoreCase('testing'),
            'expected to have caught and handled a query exception'
        );
    }

    @isTest
    static void httpCalloutDeleteSingleContactNegativeDMLException() {
        SObject contact = TestFactory.createSObject(
            new Contact(LastName = 'test'),
            true
        );
        RestRequest request = new RestRequest();
        CustomRestEndpointRecipes.circuitBreaker = new DmlException('testing');
        System.debug(LoggingLevel.INFO, contact.Id);
        request.requestUri =
            '/services/apexrest/integration-service/' + contact.Id;
        request.httpMethod = 'DELETE';
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.deleteSingleContact();
        System.debug(LoggingLevel.INFO, calloutResponse);
        Test.stopTest();
        System.Assert.isTrue(
            calloutResponse.containsIgnoreCase('testing'),
            'expected to have caught and handled a DML exception'
        );
    }

    @isTest
    static void httpCalloutDeleteSingleContactNegativeException() {
        // Insert the contact
        TestFactory.createSObject(new Contact(LastName = 'test'), true);
        RestRequest request = new RestRequest();
        // Do not supply the contactId in the urlPath to test how the system handels a null paramater
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'DELETE';
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.deleteSingleContact();
        System.debug(LoggingLevel.INFO, calloutResponse);
        Test.stopTest();

        Boolean nullObject = calloutResponse.contains(
            'Attempt to de-reference a null object'
        );
        System.Assert.isTrue(nullObject, 'Expected no contact to be found');
    }

    @isTest
    static void httpCalloutDeleteSingleContactNegativeNoAccess() {
        // Insert the contact
        TestFactory.createSObject(new Contact(LastName = 'test'), true);

        User testUser = TestFactory.createMinAccessUser(true);

        RestRequest request = new RestRequest();
        // Do not supply the contactId in the urlPath to test how the system handels a null paramater
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'DELETE';
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse;
        System.runAs(testUser) {
            calloutResponse = CustomRestEndpointRecipes.deleteSingleContact();
            System.debug(LoggingLevel.INFO, calloutResponse);
        }
        Test.stopTest();

        Boolean expectedError = calloutResponse.contains(
            'User does not have permission to delete contacts'
        );
        System.Assert.areEqual(
            500,
            response.statusCode,
            'expected status code to be 500'
        );
        System.Assert.isTrue(expectedError, 'Expected to get error string');
    }

    @isTest
    static void httpCalloutParseAndCreateNewContactsNegativeNoAccess() {
        Contact[] contactList = (Contact[]) TestFactory.createSObjectList(
            new Contact(),
            5,
            true
        );
        User testUser = TestFactory.createMinAccessUser(true);

        RestRequest request = new RestRequest();
        // Do not supply the contactId in the urlPath to test how the system handels a null paramater
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(JSON.serialize(contactList));
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse;
        System.runAs(testUser) {
            calloutResponse = CustomRestEndpointRecipes.parseAndCreateNewContacts();
            System.debug(LoggingLevel.INFO, calloutResponse);
        }
        Test.stopTest();

        Boolean expectedError = calloutResponse.contains(
            'User does not have permission to'
        );
        System.Assert.areEqual(
            500,
            response.statusCode,
            'expected status code to be 500'
        );
        System.Assert.isTrue(expectedError, 'Expected to get error string');
    }

    @isTest
    static void httpCalloutParseAndCreateNewContactsNegativeJSONException() {
        Contact[] contactList = (Contact[]) TestFactory.createSObjectList(
            new Contact(),
            5,
            true
        );

        RestRequest request = new RestRequest();
        // Do not supply the contactId in the urlPath to test how the system handels a null paramater
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(JSON.serialize(contactList));
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        CustomRestEndpointRecipes.circuitBreaker = new JSONException('testing');

        Test.startTest();
        String calloutResponse;
        calloutResponse = CustomRestEndpointRecipes.parseAndCreateNewContacts();
        System.debug(LoggingLevel.INFO, calloutResponse);
        Test.stopTest();

        Boolean expectedError = calloutResponse.contains('test');
        System.Assert.areEqual(
            400,
            response.statusCode,
            'expected status code to be 400'
        );
        System.Assert.isTrue(expectedError, 'Expected to get error string');
    }

    @isTest
    static void httpCalloutParseAndCreateNewContactsNegativeDMLException() {
        Contact[] contactList = (Contact[]) TestFactory.createSObjectList(
            new Contact(),
            5,
            true
        );

        RestRequest request = new RestRequest();
        // Do not supply the contactId in the urlPath to test how the system handels a null paramater
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(JSON.serialize(contactList));
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        CustomRestEndpointRecipes.circuitBreaker = new DMLException('testing');

        Test.startTest();
        String calloutResponse;
        calloutResponse = CustomRestEndpointRecipes.parseAndCreateNewContacts();
        System.debug(LoggingLevel.INFO, calloutResponse);
        Test.stopTest();
        Boolean expectedError = calloutResponse.contains('test');
        System.Assert.areEqual(
            400,
            response.statusCode,
            'expected status code to be 400'
        );
        System.Assert.isTrue(expectedError, 'Expected to get error string');
    }

    @isTest
    static void httpPostParseAndCreateNewContactsPositive() {
        Contact[] contactList = (Contact[]) TestFactory.createSObjectList(
            new Contact(),
            5
        );
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(JSON.serialize(contactList));
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.parseAndCreateNewContacts();
        Test.stopTest();

        System.Assert.areEqual(
            'Successful Insert',
            calloutResponse,
            'Expected response to be: "Successful Insert"'
        );
    }

    @isTest
    static void httpPostParseAndCreateNewContactsNegative() {
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'POST';
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.parseAndCreateNewContacts();
        Test.stopTest();

        Boolean argumentNull = calloutResponse.contains(
            'Argument cannot be null.'
        );
        System.Assert.isTrue(argumentNull, 'No contact records were provided');
    }

    @isTest
    static void httpPutUpsertContactRecordsPositive() {
        TestFactory.createSObjectList(new Contact(), 5, true);
        List<Contact> contactsToUpdate = new List<Contact>();
        for (Contact contact : [SELECT Id FROM Contact LIMIT 5]) {
            contact.ExternalSalesforceId__c = contact.Id;
            contactsToUpdate.add(contact);
        }
        update contactsToUpdate;
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'PUT';
        request.requestBody = Blob.valueOf(JSON.serialize(contactsToUpdate));
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.upsertContactRecords();
        System.debug(LoggingLevel.INFO, calloutResponse);
        Test.stopTest();

        System.Assert.areEqual(
            'Successful Upsert',
            calloutResponse,
            'Expected response to be: "Successful Upsert"'
        );
    }

    @isTest
    static void httpPutUpsertContactRecordsNegativeMinAccess() {
        Contact[] contactList = (Contact[]) TestFactory.createSObjectList(
            new Contact(),
            5,
            true
        );
        User testUser = TestFactory.createMinAccessUser(true);

        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'PUT';
        request.requestBody = Blob.valueOf(JSON.serialize(contactList));
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse;
        System.runAs(testUser) {
            calloutResponse = CustomRestEndpointRecipes.upsertContactRecords();
        }
        Test.stopTest();

        System.Assert.areEqual(
            500,
            response.statusCode,
            'Expected to get a 500 permission error'
        );
        Boolean upsertFailed = calloutResponse.containsIgnoreCase(
            'user does not have create or edit'
        );
        // All upsert failures  are being caught by exception and ignored by the DML Exception
        System.Assert.isTrue(upsertFailed, 'Expected a no permissions return');
    }

    @isTest
    static void httpPutUpsertContactRecordsNegativeJSONException() {
        Contact[] contactList = (Contact[]) TestFactory.createSObjectList(
            new Contact(),
            5,
            true
        );
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'PUT';
        String badJson = JSON.serialize(contactList).right(3);
        request.requestBody = Blob.valueOf(badJson);
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.upsertContactRecords();
        Test.stopTest();

        Boolean upsertFailed = calloutResponse.containsIgnoreCase(
            'malformed JSON:'
        );
        // All upsert failures  are being caught by exception and ignored by the DML Exception
        System.Assert.isTrue(upsertFailed, 'Malformed JSON error Expected.');
    }

    @isTest
    static void httpPutUpsertContactRecordsNegativeDMLException() {
        Contact[] contactList = (Contact[]) TestFactory.createSObjectList(
            new Contact(),
            5,
            true
        );
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'PUT';
        String badJson = JSON.serialize(contactList).right(3);
        request.requestBody = Blob.valueOf(badJson);
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        CustomRestEndpointRecipes.circuitBreaker = new DmlException('Testing');
        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.upsertContactRecords();
        Test.stopTest();

        Boolean upsertFailed = calloutResponse.containsIgnoreCase('test');
        // All upsert failures  are being caught by exception and ignored by the DML Exception
        System.Assert.isTrue(upsertFailed, 'DMLException expected');
    }

    @isTest
    static void httpPutUpsertContactRecordsNegativeException() {
        Contact[] contactList = (Contact[]) TestFactory.createSObjectList(
            new Contact(),
            5,
            true
        );
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'PUT';
        String badJson = JSON.serialize(contactList).right(3);
        request.requestBody = Blob.valueOf(badJson);
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        CustomRestEndpointRecipes.circuitBreaker = new CanTheUser.CanTheUserException(
            'Testing'
        );
        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.upsertContactRecords();
        Test.stopTest();

        Boolean upsertFailed = calloutResponse.containsIgnoreCase('test');
        // All upsert failures  are being caught by exception and ignored by the DML Exception
        System.Assert.isTrue(upsertFailed, 'DMLException expected');
    }

    @isTest
    static void httpPatchUpdateAccountRecordsPositive() {
        TestFactory.createSObjectList(new Account(), 5, true);
        List<Account> accountsToUpdate = new List<Account>();
        for (Account account : [
            SELECT Id, Name, Website
            FROM Account
            LIMIT 5
        ]) {
            account.ExternalSalesforceId__c = account.Id;
            account.Website = 'https://www.' + account.Id + '.com';
            accountsToUpdate.add(account);
        }
        update accountsToUpdate;
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'PATCH';
        request.requestBody = Blob.valueOf(JSON.serialize(accountsToUpdate));
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.updateAccountRecords();
        System.debug(LoggingLevel.INFO, calloutResponse);
        Test.stopTest();

        List<Account> accounts = [
            SELECT Id, Website
            FROM Account
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        Account account = (accounts.size() == 1) ? accounts.get(0) : null;
        System.Assert.areEqual(
            'https://www.' + account.Id + '.com',
            account.Website,
            'Expected account website to be https://www.[accountId].com.'
        );
        System.Assert.areEqual(
            'Successful Update',
            calloutResponse,
            'Expected response to be: "Successful Update"'
        );
    }

    @isTest
    static void httpPatchUpdateAccountRecordsNegative() {
        TestFactory.createSObjectList(new Account(), 5, true);
        List<Account> accountsToUpdate = new List<Account>();
        for (Account account : [
            SELECT Id, Name, Website
            FROM Account
            LIMIT 5
        ]) {
            account.Website = 'https://www.' + account.Id + '.com';
            accountsToUpdate.add(account);
        }
        update accountsToUpdate;
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'PATCH';
        request.requestBody = Blob.valueOf(JSON.serialize(accountsToUpdate));
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.updateAccountRecords();
        System.debug(LoggingLevel.INFO, calloutResponse);
        Test.stopTest();

        Boolean upsertFailed = calloutResponse.contains(
            'Id not specified in an update call:'
        );
        // All upsert failures  are being caught by exception and ignored by the DML Exception
        System.Assert.isTrue(upsertFailed, 'No External Id was provided');
    }

    @isTest
    static void httpPatchUpdateAccountRecordsNegativeCatchException() {
        TestFactory.createSObjectList(new Account(), 5, true);
        List<Account> accountsToUpdate = new List<Account>();
        for (Account account : [
            SELECT Id, Name, Website
            FROM Account
            LIMIT 5
        ]) {
            account.Website = 'https://www.' + account.Id + '.com';
            accountsToUpdate.add(account);
        }
        update accountsToUpdate;
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'PATCH';
        request.requestBody = Blob.valueOf(JSON.serialize(accountsToUpdate));
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        CustomRestEndpointRecipes.circuitBreaker = new CanTheUser.CanTheUserException(
            'Testing'
        );
        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.updateAccountRecords();
        System.debug(LoggingLevel.INFO, calloutResponse);
        Test.stopTest();

        System.assertEquals(
            400,
            response.statusCode,
            'expected a 400 response'
        );
        Boolean upsertFailed = calloutResponse.containsIgnoreCase('test');
        // All upsert failures  are being caught by exception and ignored by the DML Exception
        System.Assert.isTrue(
            upsertFailed,
            'Id not specified in an update call'
        );
    }

    @isTest
    static void httpPatchUpdateAccountRecordsNegativeNoAccess() {
        TestFactory.createSObjectList(new Account(), 5, true);
        List<Account> accountsToUpdate = new List<Account>();
        for (Account account : [
            SELECT Id, Name, Website
            FROM Account
            LIMIT 5
        ]) {
            account.Website = 'https://www.' + account.Id + '.com';
            accountsToUpdate.add(account);
        }
        User testUser = TestFactory.createMinAccessUser(true);
        update accountsToUpdate;
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'PATCH';
        request.requestBody = Blob.valueOf(JSON.serialize(accountsToUpdate));
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;
        String calloutResponse;
        Test.startTest();
        System.runAs(testUser) {
            calloutResponse = CustomRestEndpointRecipes.updateAccountRecords();
            System.debug(LoggingLevel.INFO, calloutResponse);
        }
        Test.stopTest();

        System.Assert.areEqual(
            500,
            response.statusCode,
            'Expected to get a 500 status code'
        );
        Boolean upsertFailed = calloutResponse.containsIgnoreCase(
            'user has no edit access'
        );
        // All upsert failures  are being caught by exception and ignored by the DML Exception
        System.Assert.isTrue(
            upsertFailed,
            'Expected to have handled a no access setup'
        );
    }

    @isTest
    static void httpPatchUpdateAccountRecordsNegativeJSONException() {
        TestFactory.createSObjectList(new Account(), 5, true);
        List<Account> accountsToUpdate = new List<Account>();
        for (Account account : [
            SELECT Id, Name, Website
            FROM Account
            LIMIT 5
        ]) {
            account.Website = 'https://www.' + account.Id + '.com';
            accountsToUpdate.add(account);
        }
        update accountsToUpdate;

        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/integration-service/';
        request.httpMethod = 'PATCH';
        String badJson = JSON.serialize(accountsToUpdate).right(3);
        request.requestBody = Blob.valueOf(badJson);
        RestResponse response = new RestResponse();
        RestContext.request = request;
        RestContext.response = response;

        Test.startTest();
        String calloutResponse = CustomRestEndpointRecipes.updateAccountRecords();
        Test.stopTest();

        Boolean upsertFailed = calloutResponse.containsIgnoreCase(
            'malformed JSON:'
        );
        // All upsert failures  are being caught by exception and ignored by the DML Exception
        System.Assert.isTrue(
            upsertFailed,
            'Expected to find a Malformed JSON error'
        );
    }
}
