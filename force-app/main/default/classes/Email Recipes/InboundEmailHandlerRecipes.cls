/**
 * @description Demonstrates inboundEmailHandler
 * Inbound email address: arinbound@75eb587mjq0etxe2n8j5gpc7o7pwrxu0zs1sxyglm4dqsf2ex.1h-hbd9eag.cs79.apex.sandbox.salesforce.com
 */
public inherited sharing class InboundEmailHandlerRecipes implements Messaging.InboundEmailHandler {
    public Messaging.InboundEmailResult handleInboundEmail(
        Messaging.InboundEmail email,
        Messaging.InboundEnvelope envelope
    ) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String errorMessage = '';
        try {
            // identify contact
            Contact sender = getContactBySender(email.fromAddress);
            createEmailRecord(sender, email);
        } catch (Exception ex) {
            result.success = false;
            errorMessage = ex.getMessage() + ' ' + ex.getStackTraceString();
        }

        if (!result.success) {
            result.message = errorMessage;
        }
        // insert email message
        // create an email record (email object) from email
        //  - associate that email with a contact(sender)
        // handle attachment(s)
        //  - attach
        return result;
    }

    private Contact getContactBySender(String senderAddress) {
        List<Contact> contactList = [
            SELECT AccountId, Email
            FROM Contact
            WHERE Email = :senderAddress
            WITH SECURITY_ENFORCED
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        return contactList.size() > 0
            ? contactList[0]
            : new Contact(Email = senderAddress);
    }

    private void createEmailRecord(
        Contact sender,
        Messaging.InboundEmail email
    ) {
        // guard statement against net-new un-inserted contact
        if (String.isBlank(sender.Id)) {
            return;
        }

        EmailMessage msg = new EmailMessage(
            TextBody = email.plainTextBody,
            HtmlBody = email.htmlBody,
            Headers = String.ValueOf(email.headers),
            Subject = email.subject,
            FromName = email.fromName,
            FromAddress = email.fromAddress,
            ToAddress = String.join(email.toAddresses, ', '),
            // This is a shortcut. You should query User to find the ID of the recipient
            toIds = new List<String>{ UserInfo.getUserId() },
            Incoming = true,
            Status = '0', // '0' -> Draft. No status for received. (yes, it's odd)
            MessageDate = DateTime.now(),
            RelatedToId = sender.AccountId
        );

        insert msg;

        EmailMessageRelation emr = new EmailMessageRelation(
            EmailMessageId = msg.id,
            RelationId = sender.id,
            RelationType = 'FromAddress',
            RelationAddress = sender.email
        );

        insert emr;
    }
}
