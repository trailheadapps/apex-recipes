/**
 * @description Demonstrates how to use the inboundEmailHandler
 * interface to create custom logic and automation on the reception
 * of an email. This class demonstrates saving the email
 * to an EmailMessage Object along with Attachments.
 * @group Email Recipes
 * @see Safely, FilesRecipes
 */
public inherited sharing class InboundEmailHandlerRecipes implements Messaging.InboundEmailHandler {
    public class InboundEmailHandlerRecipesException extends Exception {
    }
    /**
     * @description    Messaging.InboundEmailHandler interface has one required
     * method - handleInboundEmail. This method must return an
     * Messaging.InboundEmailResult object, and you should take care to set that
     * object's success property. This method is where you will write business
     * logic to ... do whatever it is you want to do with the incoming email.
     * Here you can attach the email to the contact record who sent it, a case
     * or ... The sky's the limit.
     * @param email    This is dependency injected by the system at runtime.
     * @param envelope This is dependency injected by the system at runtime.
     * @return         `Messaging.InboundEmailResult`
     * @see FilesRecipes
     */
    public Messaging.InboundEmailResult handleInboundEmail(
        Messaging.InboundEmail email,
        Messaging.InboundEnvelope envelope
    ) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String errorMessage = '';
        try {
            // identify contact
            Contact sender = getContactBySender(email);
            createFilesByEmailAttachments(email.binaryAttachments, sender.Id);
            createEmailRecord(sender, email);
            result.success = true;
        } catch (InboundEmailHandlerRecipesException iehre) {
            result.success = false;
            errorMessage =
                iehre.getMessage() +
                ' ' +
                iehre.getStackTraceString();
        }

        if (!result.success) {
            result.message = errorMessage;
        }

        return result;
    }

    /**
     * @description              This helper method bulk saves attachments from
     * the incoming email. It relies on FilesRecipes.cls to do the actual
     * creation of the Files attachments as well as publishing the file to the
     * specified record.
     * @param inboundAttachments
     * @param contactId
     */
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

    /**
     * @description         Determines if we have an existing contact record
     * with an email address that matches the sender of this email.
     * If we do not have a contact that matches, return a new contact object
     * with the email address set.
     * @param senderAddress
     * @return              `Contact`
     */
    private Contact getContactBySender(Messaging.InboundEmail email) {
        List<Contact> contactList = [
            SELECT AccountId, Email
            FROM Contact
            WHERE Email = :email.fromAddress
            WITH SECURITY_ENFORCED
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];

        if (contactList.size() > 0) {
            return contactList[0];
        } else {
            /**
             * Note: This attemptedLastName calcuation makes
             * a series of assumptions about the nature and
             * style of a 'last name'. Maybe don't use in prod.
             */

            String attemptedLastName;
            if (String.isNotBlank(email.fromName)) {
                attemptedLastName = email.fromName.split(' ')[1];
            } else {
                throw new InboundEmailHandlerRecipesException(
                    'Unable to create new contact for this sender, because the email fromName is blank'
                );
            }

            Contact newContact = new Contact(
                email = (email.fromAddress != null) ? email.fromAddress : '',
                lastName = attemptedLastName
            );
            new Safely().doInsert(newContact);

            return newContact;
        }
    }

    /**
     * @description  Creates a Salesforce Email record and relates that email to
     * the sender's contact record. This surfaces the Email record on the
     * contact object.
     * @param sender
     * @param email
     */
    private void createEmailRecord(
        Contact sender,
        Messaging.InboundEmail email
    ) {
        // guard statement against net-new un-inserted contact
        if (String.isBlank(sender.Id)) {
            return;
        }

        EmailMessage emailMessage = new EmailMessage(
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

        new Safely().doInsert(emailMessage);

        EmailMessageRelation emailRelationshipObj = new EmailMessageRelation(
            EmailMessageId = emailMessage.id,
            RelationId = sender.id,
            RelationType = 'FromAddress',
            RelationAddress = sender.email
        );

        new Safely().doInsert(emailRelationshipObj);
    }
}
