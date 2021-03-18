---
layout: default
---
# InboundEmailHandlerRecipes class

Demonstrates inboundEmailHandler Inbound email address: demo@h-1g734z80cz6m6ydd6b7wddc06vaq3vc5v65mt3p2pqkysg5rsx.1f-naxeua0.cs90.apex.sandbox.salesforce.com

---
## Methods
### `createEmailRecord(Contact sender,Messaging.InboundEmail email)` → `void`

Creates a Salesforce Email record and relates that email to the sender&apos;s contact record. This surfaces the Email record on the contact object.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |
|`` | l |

### `createFilesByEmailAttachments(List<Messaging.inboundEmail.BinaryAttachment> inboundAttachments,Id contactId)` → `void`

This helper method bulk saves attachments from the incoming email. It relies on FilesRecipes.cls to do the actual creation of the Files attachments as well as publishing the file to the specified record.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |
|`` | d |

### `getContactBySender(String senderAddress)` → `Contact`

Determines if we have an existing contact record with an email address that matches the sender of this email. If we do not have a contact that matches, return a new contact object with the email address set.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

#### Return

**Type**

Contact

**Description**

`Contact`

### `handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope envelope)` → `Messaging.InboundEmailResult`

Messaging.InboundEmailHandler interface has one required method - handleInboundEmail. This method must return an Messaging.InboundEmailResult object, and you should take care to set that object&apos;s success property. This method is where you will write business logic to ... do whatever it is you want to do with the incoming email. Here you can attach the email to the contact record who sent it, a case or ... The sky&apos;s the limit.

#### Parameters
|Param|Description|
|-----|-----------|
|`email` |     This is dependency injected by the system at runtime. |
|`envelope` |  This is dependency injected by the system at runtime. |

#### Return

**Type**

Messaging.InboundEmailResult

**Description**

`Messaging.InboundEmailResult`

---