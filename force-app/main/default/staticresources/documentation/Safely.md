# Safely Class

Class wraps DML Calls in FLS / Crud checks. Library is baseed on 
a fluent api system. All calls are constructed, then chained with options. 
For instances. `new Safely().allOrNothing().doInsert(List<sObject>);` 
 
Notable chainable methods include: 
- allOrNothing() - this enforces the AllOrNothing DML flag. All DML is 
eventually executed via Database.* methods which accept an allOrNothing 
parameter requiring all of the records to succeed or fail. 
- throwIfRemovedFields() - this method, if called, will result in an 
exception being thrown if any record being modified has fields removed 
by the security decision.

## Fields
### `allOrNothing`

`TESTVISIBLE`

#### Signature
```apex
private allOrNothing
```

#### Type
Boolean

---

### `throwIfRemovedFields`

`TESTVISIBLE`

#### Signature
```apex
private throwIfRemovedFields
```

#### Type
Boolean

## Methods
### `allOrNothing()`

#### Signature
```apex
public Safely allOrNothing()
```

#### Return Type
**[Safely](Safely.md)**

---

### `throwIfRemovedFields()`

#### Signature
```apex
public Safely throwIfRemovedFields()
```

#### Return Type
**[Safely](Safely.md)**

---

### `doInsert(records)`

#### Signature
```apex
public List<Database.SaveResult> doInsert(List<SObject> records)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| records | List&lt;SObject&gt; |  |

#### Return Type
**List&lt;Database.SaveResult&gt;**

---

### `doInsert(record)`

#### Signature
```apex
public List<Database.SaveResult> doInsert(SObject record)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject |  |

#### Return Type
**List&lt;Database.SaveResult&gt;**

---

### `doUpdate(records)`

#### Signature
```apex
public List<Database.SaveResult> doUpdate(List<SObject> records)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| records | List&lt;SObject&gt; |  |

#### Return Type
**List&lt;Database.SaveResult&gt;**

---

### `doUpdate(record)`

#### Signature
```apex
public List<Database.SaveResult> doUpdate(SObject record)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject |  |

#### Return Type
**List&lt;Database.SaveResult&gt;**

---

### `doUpsert(records)`

#### Signature
```apex
public List<Database.UpsertResult> doUpsert(List<SObject> records)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| records | List&lt;SObject&gt; |  |

#### Return Type
**List&lt;Database.UpsertResult&gt;**

---

### `doUpsert(record)`

#### Signature
```apex
public List<Database.UpsertResult> doUpsert(Sobject record)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | Sobject |  |

#### Return Type
**List&lt;Database.UpsertResult&gt;**

---

### `doDelete(records)`

#### Signature
```apex
public List<Database.DeleteResult> doDelete(List<SObject> records)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| records | List&lt;SObject&gt; |  |

#### Return Type
**List&lt;Database.DeleteResult&gt;**

---

### `doDelete(record)`

#### Signature
```apex
public List<Database.DeleteResult> doDelete(SObject record)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject |  |

#### Return Type
**List&lt;Database.DeleteResult&gt;**

---

### `doQuery(query)`

#### Signature
```apex
public List<SObject> doQuery(String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String |  |

#### Return Type
**List&lt;SObject&gt;**

---

### `doDML(accessType, records)`

#### Signature
```apex
private List<Database.SaveResult> doDML(System.AccessType accessType, List<SObject> records)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accessType | System.AccessType |  |
| records | List&lt;SObject&gt; |  |

#### Return Type
**List&lt;Database.SaveResult&gt;**

---

### `guardAgainstRemovedFields(accessType, records)`

#### Signature
```apex
private SObjectAccessDecision guardAgainstRemovedFields(System.AccessType accessType, List<SObject> records)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| accessType | System.AccessType |  |
| records | List&lt;SObject&gt; |  |

#### Return Type
**SObjectAccessDecision**

## Classes
### RemovedFieldsException Class