# AuraEnabledRecipes

Demonstrates how to expose a class method to Aura and LWC
components. Also demonstrates how to return an AuraHandledException.


**Group** Integration Recipes

## Methods
### `public static Boolean updateAccountName(Id accountId, String newValue)`

`SUPPRESSWARNINGS`

`AURAENABLED`

Updates a given account's name. Demonstrates how to receive information from an Aura or LWC component and use it to update an account. Note: This method contains a false-positive PMD warning. PMD is not aware of what CanTheUser is doing, and it falsely assumes that this code does not check for FSL / CRUD before querying. Additionally, this query contains 'WITH SECUIRTY_ENFORCED' a form of inline FLS/CRUD checking.

#### Parameters

|Param|Description|
|---|---|
|`accountId`|Id of the account to update|
|`newValue`|String of the name to set|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

#### Example
```apex
Id accountId = [SELECT Id FROM Account LIMIT 1].Id;
System.debug(AuraEnabledRecipes.updateAccountName(accountId, 'New value set by AuraEnabled method'));
```


### `public static String getFieldValue()`

`AURAENABLED`

Demonstrates how to make a method available to Aura or LWC for read-only operations. This method returns a hard-coded string, but you could do a SOQL query, or other work.

#### Returns

|Type|Description|
|---|---|
|`String`|return description|

#### Example
```apex
System.debug(AuraEnabledRecipes.getFieldValue());
```


---
