/**
 * @description Demonstrates inboundEmailHandler
 * Inbound email address: demo@h-1g734z80cz6m6ydd6b7wddc06vaq3vc5v65mt3p2pqkysg5rsx.1f-naxeua0.cs90.apex.sandbox.salesforce.com
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
            createFilesByEmailAttachments(email.binaryAttachments, sender.Id);
            createEmailRecord(sender, email);
            result.success = true;
        } catch (Exception ex) {
            result.success = false;
            errorMessage = ex.getMessage() + ' ' + ex.getStackTraceString();
        }

        if (!result.success) {
            result.message = errorMessage;
        }

        return result;
    }

    private void createFilesByEmailAttachments(
        List<Messaging.inboundEmail.BinaryAttachment> inboundAttachments,
        Id contactId
    ) {
        // guard against invalid data
        if (inboundAttachments == null || contactId == null) {
            return;
        }
        List<FilesRecipes.FileAndLinkObject> toCreate = new List<FilesRecipes.FileAndLinkObject>();
        for (
            Messaging.inboundEmail.BinaryAttachment currentAttachment : inboundAttachments
        ) {
            FilesRecipes.FileAndLinkObject newFile = new FilesRecipes.FileAndLinkObject();
            newFile.fileContents = currentAttachment.body;
            newFile.fileName = currentAttachment.fileName;
            newFile.attachedTo = contactId;
            toCreate.add(newFile);
        }
        FilesRecipes.createFilesAttachedToRecords(toCreate);
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
