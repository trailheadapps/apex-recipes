@isTest
private class InboundEmailHandlerRecipes_tests {
    static final String FROM_EMAIL = 'kjp@codefriar.com';

    @TestSetup
    static void makeData() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        Account testAccount = (Account) TestFactory.createSObject(
            new Account(Name = 'Testing Account'),
            true
        );
        Contact testContact = (Contact) TestFactory.createSObject(
            new Contact(
                email = FROM_EMAIL,
                accountId = testAccount.Id,
                Lastname = 'Poorman'
            ),
            true
        );
    }

    private static Messaging.inboundEmail.BinaryAttachment createAttachment(
        String fileName,
        Blob fileBody
    ) {
        Messaging.inboundEmail.BinaryAttachment attatchment = new Messaging.inboundEmail.BinaryAttachment();
        attatchment.filename = fileName;
        attatchment.body = fileBody;
        return attatchment;
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
    static void handleInboundEmailNegativeNoContactFound() {
        Messaging.InboundEnvelope envelope = createEnvelope();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        email.fromAddress = FROM_EMAIL;

        delete [SELECT id FROM Contact];
        Test.startTest();
        Messaging.InboundEmailResult result = new InboundEmailHandlerRecipes()
            .handleInboundEmail(email, envelope);
        Test.stopTest();

        System.assertEquals(
            false,
            result.success,
            'Expected to receive a false success property.'
        );

        System.assert(
            result.message.containsIgnoreCase('Unable to create new contact'),
            'Expected to recieve a InboudEmailHandlerRecipesException with the given message'
        );
    }

    @isTest
    static void handleInboundEmailNegativeNewContactCreated() {
        Messaging.InboundEnvelope envelope = createEnvelope();
        Messaging.InboundEmail email = createEmail();

        delete [SELECT id FROM Contact];

        Test.startTest();
        Messaging.InboundEmailResult result = new InboundEmailHandlerRecipes()
            .handleInboundEmail(email, envelope);
        Test.stopTest();

        System.assertEquals(
            true,
            result.success,
            'Expected to receive a true success property when a new contact is created.'
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
        System.assert(
            result.success,
            'Expected result to be positive ' + result.message
        );
        System.assertEquals(
            2,
            [SELECT COUNT() FROM ContentVersion],
            'Expected to find two attachments'
        );
        System.assertEquals(
            1,
            [SELECT COUNT() FROM EmailMessage],
            'Expected to have found an email message'
        );
        System.assertEquals(
            2,
            [SELECT COUNT() FROM EmailMessageRelation],
            'Expected to find two emailmessagerelation objects'
        );
        System.assertEquals(
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
