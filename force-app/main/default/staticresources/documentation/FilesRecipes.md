# FilesRecipes Class

Demonstrates how to create, link and share Files

**Group** Files Recipes

## Methods
### `createFileFromStringAttachedToRecord(text, firstLocation)`

creates a file attachment containing the given string and 
links it to the object specified in firstLocation

#### Signature
```apex
public static void createFileFromStringAttachedToRecord(String text, Id firstLocation)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| text | String | String to write to the file |
| firstLocation | Id | object to immediately link this file to |

#### Return Type
**void**

#### Example
```apex
Account acct = [SELECT Id FROM Account LIMIT 1];
FilesRecipes.createFileFromStringAttachedToRecord('Hello World', acct.Id);
System.debug('Look for files assoicated with account: ' + acct.id);
```

---

### `createFileAttachedToRecord(fileContents, attachedTo, fileName)`

Creates a file and links it to a given record

#### Signature
```apex
public static Database.SaveResult createFileAttachedToRecord(Blob fileContents, Id attachedTo, String fileName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fileContents | Blob | the binary blob of the files contents |
| attachedTo | Id | the record to link this file to, initially |
| fileName | String | the name of the file. Note that the system determines 
the filetype from the file extension here |

#### Return Type
**Database.SaveResult**

#### Example
```apex
Blob fileContents = Blob.valueOf('Hello World 2');
Account acct = [SELECT Id FROM Account LIMIT 1];
 FilesRecipes.createFileAttachedToRecord(
     fileContents,
     firstLocation,
     'AwesomeFile1'
 );
System.debug('Look for files assoicated with account: ' + acct.id);
```

---

### `createFileAttachedToRecord(toCreate)`

Convenience method for creating a file and linking it to a given record

#### Signature
```apex
public static Database.SaveResult createFileAttachedToRecord(FilesRecipes.FileAndLinkObject toCreate)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| toCreate | FilesRecipes.FileAndLinkObject | a FileAndLinkObject (inner class above) object representing the file to be created and linked |

#### Return Type
**Database.SaveResult**

---

### `createFilesAttachedToRecords(toCreate)`

Bulk method for inserting multiple files and link them to records

#### Signature
```apex
public static List<Database.SaveResult> createFilesAttachedToRecords(List<FilesRecipes.FileAndLinkObject> toCreate)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| toCreate | List&lt;FilesRecipes.FileAndLinkObject&gt; |  |

#### Return Type
**List&lt;Database.SaveResult&gt;**

---

### `getFilteredAttachmentsForRecord(genericFileType, recordId)`

`SUPPRESSWARNINGS`

Searches for content version records linked to this record 
Filtering by a generic file type: image, audio, document etc. 
 
Note: This method has a false-positive PMD warning. Our Query 
includes the keyword &#x27;WITH USER_MODE&#x27; which prevents this 
Query from accessing fields and objects that they don&#x27;t have permission 
to access. This is a form of inline CRUD/FLS Check.

#### Signature
```apex
public static List<ContentVersion> getFilteredAttachmentsForRecord(FilesRecipes.GenericFileType genericFileType, Id recordId)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| genericFileType | FilesRecipes.GenericFileType | Enum of image, audio, document |
| recordId | Id | Record ID to limit searching to |

#### Return Type
**List&lt;ContentVersion&gt;**

#### Example
```apex
Account acct = [SELECT Id FROM Account LIMIT 1];
FilesRecipes.createFileFromStringAttachedToRecord('Hello World', acct.Id);
System.debug('Found the following ContentVersion Ids: ' + FilesRecipes.getFilteredAttachmentsForRecord(FilesRecipes.GenericFileType.ALL, acct.id));
```

---

### `publishContent(cdl)`

Given a content document link, publish the content version

#### Signature
```apex
public static Database.SaveResult publishContent(ContentDocumentLink cdl)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| cdl | ContentDocumentLink | Content Document link record to publish |

#### Return Type
**Database.SaveResult**

#### Throws
FilesRecipesException: 

#### Example
```apex
Account acct = [SELECT Id FROM Account LIMIT 1];
FilesRecipes.createFileFromStringAttachedToRecord('Hello World', acct.Id);
ContentDocumentLink cdl = [SELECT LinkedEntityId, ContentDocument.LatestPublishedVersionId FROM ContentDocumentLink WHERE LinkedEntityId = :acct.id LIMIT 1];
System.debug('Found the following ContentVersion Ids: ' + FilesRecipes.getFilteredAttachmentsForRecord(FilesRecipes.GenericFileType.ALL, acct.id));
```

## Classes
### FileAndLinkObject Class

An inner class representing a file to be created and linked to a given record. 
Useful for bulk-creating files and linking them.

#### Properties
##### `fileContents`

###### Signature
```apex
public fileContents
```

###### Type
Blob

---

##### `attachedTo`

###### Signature
```apex
public attachedTo
```

###### Type
Id

---

##### `fileName`

###### Signature
```apex
public fileName
```

###### Type
String

### FilesRecipesException Class

Internal exception class

## Enums
### GenericFileType Enum

This enum encapsulates a &#x27;generic&#x27; filetype a &#x27;filetype&#x27; 
that may have multiple file extension and mime types associated with it. 
For instance, IMAGE encapsulates: jpg, gif, jpeg, &amp; png this allows 
developers to say, &#x27;give me all *image* attachments&#x27; without worrying 
about the actual file extension.

#### Values
| Value | Description |
|-------|-------------|
| IMAGE |  |
| AUDIO |  |
| DOCUMENT |  |
| ALL |  |