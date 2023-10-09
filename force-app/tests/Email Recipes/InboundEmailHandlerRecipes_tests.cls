@isTest
private class InboundEmailHandlerRecipes_tests {
    static final String FROM_EMAIL = 'kjp@codefriar.com';

    /**
     * This is a testSetup annotated method, which means
     * that it will be run before each test in this class.
     * It's responsible for creating an account and a contact
     * for use in the tests. Some tests intentionally expect
     * one or more of these objects to not be found in the database,
     * so some tests do a deletion before executing the code.
     */
    @TestSetup
    static void makeData() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        Account testAccount = (Account) TestFactory.createSObject(
            new Account(Name = 'Testing Account'),
            true
        );

        TestFactory.createSObject(
            new Contact(
                email = FROM_EMAIL,
                accountId = testAccount.Id,
                LastName = 'Poorman'
            ),
            true
        );
    }

    private static Messaging.inboundEmail.BinaryAttachment createAttachment(
        String fileName,
        Blob fileBody
    ) {
        Messaging.inboundEmail.BinaryAttachment attachment = new Messaging.inboundEmail.BinaryAttachment();
        attachment.filename = fileName;
        attachment.body = fileBody;
        return attachment;
    }

    private static Messaging.InboundEmail createEmail() {
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        email.fromName = 'Kevin Poorman';
        email.fromAddress = FROM_EMAIL;
        email.toAddresses = new List<String>{ 'invalid@invalid.com.invalid' };
        email.subject = 'Test Email';
        email.plainTextBody = 'Welcome CodeLive Viewers';
        email.binaryAttachments = new List<Messaging.InboundEmail.BinaryAttachment>{
            createAttachment(
                'helloWorld.txt',
                Blob.valueOf('Hello CodeLive Viewers')
            ),
            createAttachment(
                'helloWorld2.txt',
                Blob.valueOf('Hello CodeLive Viewers two')
            )
        };
        return email;
    }

    private static Messaging.InboundEnvelope createEnvelope() {
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        envelope.fromAddress = FROM_EMAIL;
        return envelope;
    }

    @isTest
    static void handleInboundEmailPositiveFailureWhenContactCreationFails() {
        Messaging.InboundEnvelope envelope = createEnvelope();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        email.fromAddress = FROM_EMAIL;

        delete [SELECT Id FROM Contact];
        Test.startTest();
        Messaging.InboundEmailResult result = new InboundEmailHandlerRecipes()
            .handleInboundEmail(email, envelope);
        Test.stopTest();

        System.Assert.isFalse(
            result.success,
            'Expected to find the success property is false.'
        );

        System.Assert.isTrue(
            result.message.containsIgnoreCase('Unable to create new contact'),
            'Expected to receive a InboundEmailHandlerRecipesException with the given message'
        );
    }

    @isTest
    static void handleInboundEmailPositiveNewContactCreatedWhenNoContactFound() {
        Messaging.InboundEnvelope envelope = createEnvelope();
        Messaging.InboundEmail email = createEmail();

        delete [SELECT Id FROM Contact];

        Test.startTest();
        Messaging.InboundEmailResult result = new InboundEmailHandlerRecipes()
            .handleInboundEmail(email, envelope);
        Test.stopTest();

        System.Assert.isTrue(
            result.success,
            'Expected to receive a true success property when a new contact is created.'
        );

        System.Assert.areEqual(
            1,
            [SELECT COUNT() FROM Contact WHERE email = :FROM_EMAIL],
            'Expected to find a new contact has been created with the FROM_EMAIL address.'
        );
    }

    @isTest
    static void integrationTestPositive() {
        Messaging.InboundEnvelope envelope = createEnvelope();
        Messaging.InboundEmail email = createEmail();
        Id contactId = [SELECT Id FROM Contact LIMIT 1].Id;
        Test.startTest();
        Messaging.InboundEmailResult result = new InboundEmailHandlerRecipes()
            .handleInboundEmail(email, envelope);
        Test.stopTest();
        System.Assert.isTrue(
            result.success,
            'Expected result to be positive ' + result.message
        );
        System.Assert.areEqual(
            2,
            [SELECT COUNT() FROM ContentVersion],
            'Expected to find two attachments'
        );
        System.Assert.areEqual(
            1,
            [SELECT COUNT() FROM EmailMessage],
            'Expected to have found an email message'
        );
        System.Assert.areEqual(
            2,
            [SELECT COUNT() FROM EmailMessageRelation],
            'Expected to find two emailMessageRelation objects'
        );
        System.Assert.areEqual(
            2,
            [
                SELECT COUNT()
                FROM ContentDocumentLink
                WHERE LinkedEntityId = :contactId
            ],
            'Expected to find the attachments linked to the contact'
        );
    }
}
