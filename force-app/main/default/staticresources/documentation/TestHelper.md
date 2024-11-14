# TestHelper Class

`ISTEST`

This class serves as a library of useful methods for writing 
more expressive, cleaner unit tests. Initialy this class contains a method 
for identifying the name of an object&#x27;s class expressed as a string.

**Group** Testing Recipes

## Methods
### `getUnknownObjectType(obj)`

It can be useful to know what the type of an object 
is at runtime. This is especially useful when you&#x27;re dynamically 
instantiating objects in code from the name of a class. 
 
I&#x27;m not generally a fan of relying on an exception to make logic 
decisions, but in this case I&#x27;ll make an exception as this is the 
cleanest method I&#x27;ve yet found for efficently determining an objects 
class name that covers edge cases where the object is of an inner class&#x27; 
type. 
 
This method parses a TypeException for the true name of a class. 
It generates the exception by forcing a cast from the Object parameter 
to DateTime. If no typeException occurs, we know it&#x27;s a dateTime object.

#### Signature
```apex
public static String getUnknownObjectType(Object obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | Object |  |

#### Return Type
**String**