# InboundEmailHandlerRecipes Class

`SUPPRESSWARNINGS`

Demonstrates how to use the inboundEmailHandler 
interface to create custom logic and automation on the reception 
of an email. This class demonstrates saving the email 
to an EmailMessage Object along with Attachments. 
 
NOTE: This class *does not* specify a sharing model. 
This is on purpose - When this class is executed, by the inbound 
email system, it will execute in a system context and pieces of 
this class need to be able to *read* all contacts - which is a 
common use case. Because of this, we&#x27;re suppressing the PMD 
ApexSharingViolation warning.

**Group** Email Recipes

**See** [Safely](https://github.com/trailheadapps/apex-recipes/wiki/Safely)

**See** [FilesRecipes](https://github.com/trailheadapps/apex-recipes/wiki/FilesRecipes)

**Implements**

Messaging.InboundEmailHandler

## Methods
### `handleInboundEmail(email, envelope)`

Messaging.InboundEmailHandler interface has one required 
method - `handleInboundEmail` . This method must return an 
 `Messaging.InboundEmailResult` object, and you should take care to set that 
object&#x27;s success property. This method is where you will write business 
logic to ... do whatever it is you want to do with the incoming email. 
Here you can attach the email to the contact record who sent it, a case 
or ... The sky&#x27;s the limit.

#### Signature
```apex
public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| email | Messaging.InboundEmail | This is an `Messaging.InboundEmail` Object that is 
dependency injected by the system at runtime. Aside from testing, you 
should not need to call this method or worry about its params. |
| envelope | Messaging.InboundEnvelope | This is an `Messaging.InboundEnvelope` object that is 
dependency injected by the system at runtime. Aside form testing, you 
should not need to call this method or worry about its params. |

#### Return Type
**Messaging.InboundEmailResult**

---

### `createFilesByEmailAttachments(inboundAttachments, contactId)`

This helper method bulk saves attachments from 
the incoming email. It relies on FilesRecipes.cls to do the actual 
creation of the Files attachments as well as publishing the file to the 
specified record.

#### Signature
```apex
private void createFilesByEmailAttachments(List<Messaging.inboundEmail.BinaryAttachment> inboundAttachments, Id contactId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| inboundAttachments | List&lt;Messaging.inboundEmail.BinaryAttachment&gt; |  |
| contactId | Id |  |

#### Return Type
**void**

---

### `getContactBySender(email)`

Determines if we have an existing contact record 
with an email address that matches the sender of this email. 
If we do not have a contact that matches, return a new contact object 
with the email address set.

#### Signature
```apex
private Contact getContactBySender(Messaging.InboundEmail email)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| email | Messaging.InboundEmail |  |

#### Return Type
**Contact**

---

### `createEmailRecord(sender, email)`

Creates a Salesforce Email record and relates that email to 
the sender&#x27;s contact record. This surfaces the Email record on the 
contact object.

#### Signature
```apex
private void createEmailRecord(Contact sender, Messaging.InboundEmail email)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sender | Contact |  |
| email | Messaging.InboundEmail |  |

#### Return Type
**void**

## Classes
### InboundEmailHandlerRecipesException Class