/**
 * @description Demonstrates how to use the inboundEmailHandler
 * interface to create custom logic and automation on the reception
 * of an email. This class demonstrates saving the email
 * to an EmailMessage Object along with Attachments.
 *
 * NOTE: This class *does not* specify a sharing model.
 * This is on purpose - When this class is executed, by the inbound
 * email system, it will execute in a system context and pieces of
 * this class need to be able to *read* all contacts - which is a
 * common use case. Because of this, we're suppressing the PMD
 * ApexSharingViolation warning.
 *
 * @group Email Recipes
 * @see Safely
 * @see FilesRecipes
 */
@SuppressWarnings('PMD.ApexSharingViolations')
public class InboundEmailHandlerRecipes implements Messaging.InboundEmailHandler {
    public class InboundEmailHandlerRecipesException extends Exception {
    }
    /**
     * @description    Messaging.InboundEmailHandler interface has one required
     * method - `handleInboundEmail`. This method must return an
     * `Messaging.InboundEmailResult` object, and you should take care to set that
     * object's success property. This method is where you will write business
     * logic to ... do whatever it is you want to do with the incoming email.
     * Here you can attach the email to the contact record who sent it, a case
     * or ... The sky's the limit.
     * @param email    This is an `Messaging.InboundEmail` Object that is
     * dependency injected by the system at runtime. Aside from testing, you
     * should not need to call this method or worry about its params.
     * @param envelope This is an `Messaging.InboundEnvelope` object that is
     * dependency injected by the system at runtime. Aside form testing, you
     * should not need to call this method or worry about its params.
     * @see FilesRecipes
     */
    public Messaging.InboundEmailResult handleInboundEmail(
        Messaging.InboundEmail email,
        Messaging.InboundEnvelope envelope
    ) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        try {
            // identify contact
            Contact sender = getContactBySender(email);
            createFilesByEmailAttachments(email.binaryAttachments, sender.Id);
            createEmailRecord(sender, email);
            result.success = true;
            /**
             * I'm not generally a fan of catching generic Exception.
             * But in this case, all the concrete exception types we
             * could catch (InboundEmailHandlerRecipesException,
             * DMLException) are all handled the same way - by setting
             * the error message and result success flag to false.
             *
             * For the sake of not repeating code, this code just
             * catches Exception.
             */
        } catch (Exception error) {
            result.success = false;
            result.message =
                error?.getMessage() +
                ' ' +
                error?.getStackTraceString();
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
     */
    private Contact getContactBySender(Messaging.InboundEmail email) {
        List<Contact> contactList = [
            SELECT AccountId, Email
            FROM Contact
            WHERE Email = :email.fromAddress
            WITH USER_MODE
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];

        if (contactList.size() > 0) {
            return contactList[0];
        }
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
            email = email.fromAddress,
            lastName = attemptedLastName
        );
        new Safely().doInsert(newContact);

        return newContact;
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
            Status = '3', // 3 = sent. 0 = draft
            IsClientManaged = true, // '0' -> Draft. No status for received. (yes, it's odd)
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
