---
layout: default
---
# MetadataCatalogRecipes class

Demonstrates how to query the Metadata Catalog. This is sometimes faster that Schema Describe calls especially for large complex orgs

---
## Methods
### `findAllContactFieldsThatLookupToAccount()` → `List<MetadataCatalogRecipes.LookupRelationshipDefinition>`

Demonstrates how to query the metadata catalog to find all fields on the Contact object that establish a relationship to the Account Object. Note: This method has a false-positive PMD warning. PMD isn&apos;t aware of the purpose or functionality of CanTheUser.* so it doesn&apos;t undersatnd that we are, in fact, checking for CRUD / FLS permissions prior to querying.

#### Return

**Type**

List&lt;MetadataCatalogRecipes.LookupRelationshipDefinition&gt;

**Description**

List&lt;MetadataCatalogRecipes.LookupRelationshipDefinition&gt;

#### Example
```java
List<MetadataCatalogRecipes.LookupRelationshipDefinition> results =
     MetadataCatalogRecipes.findAllContactFieldsThatLookupToAccount();
System.debug(results);
```

### `findAllFormulaFields()` → `Map<String, String>>`

Demonstrates how to query the EntityDefinition Object to find all formula fields in your Org. This method returns a Map of Object&apos;s Qualified API name -&gt; Map of Field Names -&gt; Types Note: This method has a false-positive PMD warning. PMD isn&apos;t aware of the purpose or functionality of CanTheUser.* so it doesn&apos;t undersatnd that we are, in fact, checking for CRUD / FLS permissions prior to querying.

#### Return

**Type**

Map&lt;String, String&gt;&gt;

**Description**

Map&lt;String, Map&lt;String, String&gt;&gt;

#### Example
```java
Map<String, Map<String, String>> results =
     MetadataCatalogRecipes.findAllFormulaFields();
System.debug(results);
```

---
## Inner Classes

### MetadataCatalogRecipes.LookupRelationshipDefinition class

internal data object for information about a Lookup Relationship

---
#### Constructors
##### `LookupRelationshipDefinition(FieldDefinition fd)`

Constructor that transforms a Field Definition object into a LookupRelationshipDefinition Object.
###### Parameters

| Param | Description |
| ----- | ----------- |
|`fd` |  a FieldDefinition Object |

###### Example
```java
FieldDefinition fd = [SELECT Id, DeveloperName, RelationshipNme,
                         DataType
                      FROM FieldDefinition LIMIT 1];
MetadataCatalogRecipes.LookupRelationshipDefinition lrd = new
     MetadataCatalogRecipes.LookupRelationshipDefinition(fd);
System.debug(lrd);
```

---
#### Properties

##### `dataType` → `String`

Specifies the Data Type Of this Object

##### `developerName` → `String`

Specifies the name of the Object

##### `looksUpTo` → `String`

Specifies what object this one looks up to

##### `relationshipName` → `String`

Specifies the Relationship field name

---
