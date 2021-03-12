@isTest
private class InboundEmailHandlerRecipes_tests {
    static final String fromEmail = 'kjp@codefriar.com';

    @TestSetup
    static void makeData() {
        Account testAccount = (Account) TestFactory.createSObject(
            new Account(Name = 'Testing Account'),
            true
        );
        Contact testContact = (Contact) TestFactory.createSObject(
            new Contact(
                email = fromEmail,
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
        email.fromAddress = fromEmail;
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
        envelope.fromAddress = fromEmail;
        return envelope;
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
