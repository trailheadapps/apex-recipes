# MetadataCatalogRecipes Class

Demonstrates how to query the Metadata Catalog. This is 
sometimes faster that Schema Describe calls especially for large complex orgs

**Group** Data Recipes

## Methods
### `findAllFormulaFields()`

`SUPPRESSWARNINGS`

Demonstrates how to query the EntityDefinition Object to 
find all formula fields in your Org. This method returns a Map of 
Object&#x27;s Qualified API name -&gt; Map of Field Names -&gt; Types 
 
Note: This method has a false-positive PMD warning. PMD isn&#x27;t aware of 
the purpose or functionality of CanTheUser.* so it doesn&#x27;t undersatnd 
that we are, in fact, checking for CRUD / FLS permissions prior to 
querying.

#### Signature
```apex
public static Map<String,Map<String,String>> findAllFormulaFields()
```

#### Return Type
**Map&lt;String,Map&lt;String,String&gt;&gt;**

#### Example
```apex
Map<String, Map<String, String>> results =
     MetadataCatalogRecipes.findAllFormulaFields();
System.debug(results);
```

---

### `findAllContactFieldsThatLookupToAccount()`

`SUPPRESSWARNINGS`

Demonstrates how to query the metadata catalog to find all 
fields on the Contact object that establish a relationship to the Account 
Object. 
 
Note: This method has a false-positive PMD warning. PMD isn&#x27;t aware of 
the purpose or functionality of CanTheUser.* so it doesn&#x27;t undersatnd 
that we are, in fact, checking for CRUD / FLS permissions prior to 
querying.

#### Signature
```apex
public static List<MetadataCatalogRecipes.LookupRelationshipDefinition> findAllContactFieldsThatLookupToAccount()
```

#### Return Type
**List&lt;MetadataCatalogRecipes.LookupRelationshipDefinition&gt;**

#### Example
```apex
List<MetadataCatalogRecipes.LookupRelationshipDefinition> results =
     MetadataCatalogRecipes.findAllContactFieldsThatLookupToAccount();
System.debug(results);
```

## Classes
### LookupRelationshipDefinition Class

internal data object for information about a Lookup 
Relationship

#### Properties
##### `looksUpTo`

Specifies what object this one looks up to

###### Signature
```apex
public looksUpTo
```

###### Type
String

---

##### `developerName`

Specifies the name of the Object

###### Signature
```apex
public developerName
```

###### Type
String

---

##### `relationshipName`

Specifies the Relationship field name

###### Signature
```apex
public relationshipName
```

###### Type
String

---

##### `dataType`

Specifies the Data Type Of this Object

###### Signature
```apex
public dataType
```

###### Type
String

#### Constructors
##### `LookupRelationshipDefinition(fd)`

Constructor that transforms a Field Definition object 
into a LookupRelationshipDefinition Object.

###### Signature
```apex
public LookupRelationshipDefinition(FieldDefinition fd)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| fd | FieldDefinition | a FieldDefinition Object |

###### Example
```apex
FieldDefinition fd = [SELECT Id, DeveloperName, RelationshipNme,
                         DataType
                      FROM FieldDefinition LIMIT 1];
MetadataCatalogRecipes.LookupRelationshipDefinition lrd = new
     MetadataCatalogRecipes.LookupRelationshipDefinition(fd);
System.debug(lrd);
```