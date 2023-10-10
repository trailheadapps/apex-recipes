# FilesRecipes

Demonstrates how to create, link and share Files


**Group** Files Recipes

## Methods
### `public static void createFileFromStringAttachedToRecord(String text, Id firstLocation)`

creates a file attachment containing the given string and links it to the object specified in firstLocation

#### Parameters

|Param|Description|
|---|---|
|`text`|String to write to the file|
|`firstLocation`|object to immediately link this file to|

#### Example
```apex
Account acct = [SELECT Id FROM Account LIMIT 1];
FilesRecipes.createFileFromStringAttachedToRecord('Hello World', acct.Id);
System.debug('Look for files assoicated with account: ' + acct.id);
```


### `public static Database createFileAttachedToRecord(Blob fileContents, Id attachedTo, String fileName)`

Creates a file and links it to a given record

#### Parameters

|Param|Description|
|---|---|
|`fileContents`|the binary blob of the files contents|
|`attachedTo`|the record to link this file to, initially|
|`fileName`|the name of the file. Note that the system determines  the filetype from the file extension here|

#### Returns

|Type|Description|
|---|---|
|`Database`|`Database.SaveResult`|

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


### `public static Database createFileAttachedToRecord(FilesRecipes toCreate)`

Convenience method for creating a file and linking it to a given record

#### Parameters

|Param|Description|
|---|---|
|`toCreate`|a FileAndLinkObject (inner class above) object representing the file to be created and linked|

#### Returns

|Type|Description|
|---|---|
|`Database`|`Database.SaveResult`|

### `public static List<Database.SaveResult> createFilesAttachedToRecords(List<FilesRecipes.FileAndLinkObject> toCreate)`

Bulk method for inserting multiple files and link them to records

#### Parameters

|Param|Description|
|---|---|
|`toCreate`|List<FilesRecipes.FileAndLinkObject>|

#### Returns

|Type|Description|
|---|---|
|`List<Database.SaveResult>`|`List<Database.SaveResult>`|

### `public static List<ContentVersion> getFilteredAttachmentsForRecord(FilesRecipes genericFileType, Id recordId)`

`SUPPRESSWARNINGS`

Searches for content version records linked to this record Filtering by a generic file type: image, audio, document etc. Note: This method has a false-positive PMD warning. Our Query includes the keyword 'WITH USER_MODE' which prevents this Query from accessing fields and objects that they don't have permission to access. This is a form of inline CRUD/FLS Check.

#### Parameters

|Param|Description|
|---|---|
|`genericFileType`|Enum of image, audio, document|
|`recordId`|Record ID to limit searching to|

#### Returns

|Type|Description|
|---|---|
|`List<ContentVersion>`|`List<ContentVersion>`|

#### Example
```apex
Account acct = [SELECT Id FROM Account LIMIT 1];
FilesRecipes.createFileFromStringAttachedToRecord('Hello World', acct.Id);
System.debug('Found the following ContentVersion Ids: ' + FilesRecipes.getFilteredAttachmentsForRecord(FilesRecipes.GenericFileType.ALL, acct.id));
```


### `public static Database publishContent(ContentDocumentLink cdl)`

Given a content document link, publish the content version

#### Parameters

|Param|Description|
|---|---|
|`cdl`|Content Document link record to publish|

#### Returns

|Type|Description|
|---|---|
|`Database`|`Database.SaveResult`|

#### Throws

|Exception|Description|
|---|---|
|`FilesRecipesException`||

#### Example
```apex
Account acct = [SELECT Id FROM Account LIMIT 1];
FilesRecipes.createFileFromStringAttachedToRecord('Hello World', acct.Id);
ContentDocumentLink cdl = [SELECT LinkedEntityId, ContentDocument.LatestPublishedVersionId FROM ContentDocumentLink WHERE LinkedEntityId = :acct.id LIMIT 1];
System.debug('Found the following ContentVersion Ids: ' + FilesRecipes.getFilteredAttachmentsForRecord(FilesRecipes.GenericFileType.ALL, acct.id));
```


---
## Enums
### GenericFileType

This enum encapsulates a 'generic' filetype a 'filetype'
that may have multiple file extension and mime types associated with it.
For instance, IMAGE encapsulates: jpg, gif, jpeg, & png this allows
developers to say, 'give me all *image* attachments' without worrying
about the actual file extension.


---
## Classes
### FileAndLinkObject

An inner class representing a file to be created and linked to a given record.
Useful for bulk-creating files and linking them.

#### Properties

##### `public attachedTo` → `Id`


##### `public fileContents` → `Blob`


##### `public fileName` → `String`


---

### FilesRecipesException

Internal exception class


**Inheritance**

FilesRecipesException


---
