# MetadataCatalogRecipes

Demonstrates how to query the Metadata Catalog. This is
sometimes faster that Schema Describe calls especially for large complex orgs


**Group** Data Recipes

## Methods
### `public static Map<String,Map<String,String>> findAllFormulaFields()`

`SUPPRESSWARNINGS`

Demonstrates how to query the EntityDefinition Object to find all formula fields in your Org. This method returns a Map of Object's Qualified API name -&gt; Map of Field Names -&gt; Types Note: This method has a false-positive PMD warning. PMD isn't aware of the purpose or functionality of CanTheUser.* so it doesn't undersatnd that we are, in fact, checking for CRUD / FLS permissions prior to querying.

#### Returns

|Type|Description|
|---|---|
|`Map<String,Map<String,String>>`|Map<String, Map<String, String>>|

#### Example
```apex
Map<String, Map<String, String>> results =
     MetadataCatalogRecipes.findAllFormulaFields();
System.debug(results);
```


### `public static List<MetadataCatalogRecipes.LookupRelationshipDefinition> findAllContactFieldsThatLookupToAccount()`

`SUPPRESSWARNINGS`

Demonstrates how to query the metadata catalog to find all fields on the Contact object that establish a relationship to the Account Object. Note: This method has a false-positive PMD warning. PMD isn't aware of the purpose or functionality of CanTheUser.* so it doesn't undersatnd that we are, in fact, checking for CRUD / FLS permissions prior to querying.

#### Returns

|Type|Description|
|---|---|
|`List<MetadataCatalogRecipes.LookupRelationshipDefinition>`|List<MetadataCatalogRecipes.LookupRelationshipDefinition>|

#### Example
```apex
List<MetadataCatalogRecipes.LookupRelationshipDefinition> results =
     MetadataCatalogRecipes.findAllContactFieldsThatLookupToAccount();
System.debug(results);
```


---
## Classes
### LookupRelationshipDefinition

internal data object for information about a Lookup
Relationship

#### Constructors
##### `public LookupRelationshipDefinition(FieldDefinition fd)`

Constructor that transforms a Field Definition object   into a LookupRelationshipDefinition Object.

###### Parameters

|Param|Description|
|---|---|
|`fd`|a FieldDefinition Object|

###### Example
```apex
FieldDefinition fd = [SELECT Id, DeveloperName, RelationshipNme,
                         DataType
                      FROM FieldDefinition LIMIT 1];
MetadataCatalogRecipes.LookupRelationshipDefinition lrd = new
     MetadataCatalogRecipes.LookupRelationshipDefinition(fd);
System.debug(lrd);
```


---
#### Properties

##### `public dataType` → `String`


Specifies the Data Type Of this Object

##### `public developerName` → `String`


Specifies the name of the Object

##### `public looksUpTo` → `String`


Specifies what object this one looks up to

##### `public relationshipName` → `String`


Specifies the Relationship field name

---

---
