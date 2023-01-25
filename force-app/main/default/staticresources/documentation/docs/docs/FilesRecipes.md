---
layout: default
---
# FilesRecipes class

Demonstrates how to create, link and share Files

---
## Enums
### GenericFileType


This enum encapsulates a &apos;generic&apos; filetype a &apos;filetype&apos; that may have multiple file extension and mime types associated with it. For instance, IMAGE encapsulates: jpg, gif, jpeg, &amp; png this allows developers to say, &apos;give me all *image* attachments&apos; without worrying about the actual file extension.

---
## Methods
### `createFileAttachedToRecord(Blob fileContents,Id attachedTo,String fileName)` → `Database.SaveResult`

Creates a file and links it to a given record

#### Parameters

| Param | Description |
| ----- | ----------- |
|`fileContents` |  the binary blob of the files contents |
|`attachedTo` |    the record to link this file to, initially |
|`fileName` |      the name of the file. Note that the system determines |

#### Return

**Type**

Database.SaveResult

**Description**

`Database.SaveResult`

#### Example
```java
Blob fileContents = Blob.valueOf('Hello World 2');
Account acct = [SELECT id FROM Account LIMIT 1];
 FilesRecipes.createFileAttachedToRecord(
     fileContents,
     firstLocation,
     'AwesomeFile1'
 );
System.debug('Look for files assoicated with account: ' + acct.id);
```

### `createFileAttachedToRecord(FilesRecipes.FileAndLinkObject toCreate)` → `Database.SaveResult`

Convenience method for creating a file and linking it to a given record

#### Parameters

| Param | Description |
| ----- | ----------- |
|`toCreate` |  a FileAndLinkObject (inner class above) object representing the file to be created and linked |

#### Return

**Type**

Database.SaveResult

**Description**

`Database.SaveResult`

### `createFileFromStringAttachedToRecord(String text,Id firstLocation)` → `void`

creates a file attachment containing the given string and links it to the object specified in firstLocation

#### Parameters

| Param | Description |
| ----- | ----------- |
|`text` |           String to write to the file |
|`firstLocation` |  object to immediately link this file to |

#### Example
```java
Account acct = [SELECT id FROM Account LIMIT 1];
FilesRecipes.createFileFromStringAttachedToRecord('Hello World', acct.Id);
System.debug('Look for files assoicated with account: ' + acct.id);
```

### `createFilesAttachedToRecords(List<FilesRecipes.FileAndLinkObject> toCreate)` → `List<Database.SaveResult>`

Bulk method for inserting multiple files and link them to records

#### Parameters

| Param | Description |
| ----- | ----------- |
|`toCreate` |  List&lt;FilesRecipes.FileAndLinkObject&gt; |

#### Return

**Type**

List&lt;Database.SaveResult&gt;

**Description**

`List&lt;Database.SaveResult&gt;`

### `getFilteredAttachmentsForRecord(FilesRecipes.GenericFileType genericFileType,Id recordId)` → `List<ContentVersion>`

Searches for content version records linked to this record Filtering by a generic file type: image, audio, document etc. Note: This method has a false-positive PMD warning. Our Query includes the keyword &apos;WITH USER_MODE&apos; which prevents this Query from accessing fields and objects that they don&apos;t have permission to access. This is a form of inline CRUD/FLS Check.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`genericFileType` |  Enum of image, audio, document |
|`recordId` |         Record id to limit searching to |

#### Return

**Type**

List&lt;ContentVersion&gt;

**Description**

`List&lt;ContentVersion&gt;`

#### Example
```java
Account acct = [SELECT id FROM Account LIMIT 1];
FilesRecipes.createFileFromStringAttachedToRecord('Hello World', acct.Id);
System.debug('Found the following ContentVersion Ids: ' + FilesRecipes.getFilteredAttachmentsForRecord(FilesRecipes.GenericFileType.ALL, acct.id));
```

### `publishContent(ContentDocumentLink cdl)` → `Database.SaveResult`

Given a content document link, publish the content version

#### Parameters

| Param | Description |
| ----- | ----------- |
|`cdl` |    Content Document link record to publish |

#### Return

**Type**

Database.SaveResult

**Description**

`Database.SaveResult`

#### Example
```java
Account acct = [SELECT id FROM Account LIMIT 1];
FilesRecipes.createFileFromStringAttachedToRecord('Hello World', acct.Id);
ContentDocumentLink cdl = [SELECT LinkedEntityId, ContentDocument.LatestPublishedVersionId FROM ContentDocumentLink WHERE LinkedEntityId = :acct.id LIMIT 1];
System.debug('Found the following ContentVersion Ids: ' + FilesRecipes.getFilteredAttachmentsForRecord(FilesRecipes.GenericFileType.ALL, acct.id));
```

---
## Inner Classes

### FilesRecipes.FileAndLinkObject class

 An inner class representing a file to be created and linked to a given record. Useful for bulk-creating files and linking them.

---
#### Properties

##### `attachedTo` → `Id`

##### `fileContents` → `Blob`

##### `fileName` → `String`

---
### FilesRecipes.FilesRecipesException class

Internal exception class

---
