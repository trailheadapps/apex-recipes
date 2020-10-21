@isTest
public class TestFactory {
    /**
     * @description When we create a list of SObjects, we need to have a unique field for the insert if there isn't an autonumber field.
     * Usually we use the Name field, but some objects don't have a name field.
     */
    private static Map<Schema.SObjectType, Schema.SObjectField> nameFieldMap = new Map<Schema.SObjectType, Schema.SObjectField>{
        Contact.SObjectType => Contact.LastName,
        Case.SObjectType => Case.CaseNumber //this is the autonumber field
    };

    /**
     * @description Creates a single sObject.
     * @param sObj  Type of sObject to create.
     * @return     `SObject`
     */
    public static SObject createSObject(SObject sObj) {
        // Check what type of object we are creating and add any defaults that are needed.
        String objectName = String.valueOf(sObj.getSObjectType());
        // Construct the default values class. Salesforce doesn't allow '__' in class names
        String defaultClassName =
            objectName.replaceAll('__(c|C)$|__', '') + 'Defaults';
        // If there is a class that exists for the default values, then use them
        if (Type.forName('TestFactoryDefaults.' + defaultClassName) != null) {
            sObj = createSObject(
                sObj,
                'TestFactoryDefaults.' + defaultClassName
            );
        }
        return sObj;
    }

    /**
     * @description    Creates a single sObject
     * @param sObj     Type of sObject to create
     * @param doInsert Boolean should this object be inserted?
     * @return        `SObject`
     */
    public static SObject createSObject(SObject sObj, Boolean doInsert) {
        SObject retObject = createSObject(sObj);
        if (doInsert) {
            insert retObject;
        }
        return retObject;
    }

    /**
     * @description            creates a single sObject
     * @param sObj             Type of sObject to create
     * @param defaultClassName Name of the class to provide field defaults
     * @return                `SObject`
     * @exception              TestFactoryException when defaultClassName param is not a valid type.
     */
    public static SObject createSObject(SObject sObj, String defaultClassName) {
        // Create an instance of the defaults class so we can get the Map of field defaults
        Type t = Type.forName(defaultClassName);
        if (t == null) {
            throw new TestFactoryException('Invalid defaults class.');
        }
        FieldDefaults defaults = (FieldDefaults) t.newInstance();
        addFieldDefaults(sObj, defaults.getFieldDefaults());
        return sObj;
    }

    /**
     * @description            Create a single sObject
     * @param sObj             Type of sObject to create
     * @param defaultClassName String name of a class providing default values
     * @param doInsert         Boolean should this method insert the created object?
     * @return                 `SObject`
     */
    public static SObject createSObject(
        SObject sObj,
        String defaultClassName,
        Boolean doInsert
    ) {
        SObject retObject = createSObject(sObj, defaultClassName);
        if (doInsert) {
            insert retObject;
        }
        return retObject;
    }

    /**
     * @description           Creates a list of sObjects
     * @param sObj            Type of sObjects to create
     * @param numberOfObjects Integer number of objects to create
     * @return                `SObject[]`
     */
    public static SObject[] createSObjectList(
        SObject sObj,
        Integer numberOfObjects
    ) {
        return createSObjectList(sObj, numberOfObjects, (String) null);
    }

    /**
     * @description           Creates a list of sObjects
     * @param sObj            Type of sObjects to create
     * @param numberOfObjects Integer number of objects to create
     * @param doInsert         Boolean should this method insert the created object?
     * @return                `SObject[]`
     */
    public static SObject[] createSObjectList(
        SObject sObj,
        Integer numberOfObjects,
        Boolean doInsert
    ) {
        SObject[] retList = createSObjectList(
            sObj,
            numberOfObjects,
            (String) null
        );
        if (doInsert) {
            insert retList;
        }
        return retList;
    }

    /**
     * @description           Creates a list of sObjects
     * @param sObj            Type of sObjects to create
     * @param numberOfObjects Integer number of objects to create
     * @param defaultClassName String name of a class providing defaults
     * @param doInsert         Boolean should this method insert the created object?
     * @return                `SObject[]`
     */
    @SuppressWarnings('PMD.ExcessiveParameterList')
    public static SObject[] createSObjectList(
        SObject sObj,
        Integer numberOfObjects,
        String defaultClassName,
        Boolean doInsert
    ) {
        SObject[] retList = createSObjectList(
            sObj,
            numberOfObjects,
            defaultClassName
        );
        if (doInsert) {
            insert retList;
        }
        return retList;
    }

    /**
     * @description           Creates a list of sObjects
     * @param sObj            Type of sObjects to create
     * @param numberOfObjects Integer number of objects to create
     * @param defaultClassName String name of a class providing defaults
     * @return                `SObject[]`
     */
    public static SObject[] createSObjectList(
        SObject sObj,
        Integer numberOfObjects,
        String defaultClassName
    ) {
        SObject[] sObjs = new List<SObject>{};
        SObject newObj;

        // Get one copy of the object
        if (defaultClassName == null) {
            newObj = createSObject(sObj);
        } else {
            newObj = createSObject(sObj, defaultClassName);
        }

        // Get the name field for the object
        String nameField = String.valueOf(
            nameFieldMap.get(sObj.getSObjectType())
        );
        if (nameField == null) {
            nameField = 'Name';
        }
        Boolean nameIsAutoNumber = sObj.getSObjectType()
            .getDescribe()
            .fields.getMap()
            .get(nameField)
            .getDescribe()
            .isAutoNumber();

        // Clone the object the number of times requested. Increment the name field so each record is unique
        for (Integer i = 0; i < numberOfObjects; i++) {
            SObject clonedSObj = newObj.clone(false, true);
            if (!nameIsAutoNumber) {
                clonedSObj.put(
                    nameField,
                    (String) clonedSObj.get(nameField) +
                    ' ' +
                    i
                );
            }
            sObjs.add(clonedSObj);
        }
        return sObjs;
    }

    /**
     * @description    Sets field defaults on the sObj given the map of defaults.
     * @param sObj     Obj to manipulate.
     * @param defaults Defaults map of sObjectField to Object to use for values.
     */
    private static void addFieldDefaults(
        SObject sObj,
        Map<Schema.SObjectField, Object> defaults
    ) {
        // Loop through the map of fields and if they weren't specifically assigned, fill them.
        Map<String, Object> populatedFields = sObj.getPopulatedFieldsAsMap();
        for (Schema.SObjectField field : defaults.keySet()) {
            if (!populatedFields.containsKey(String.valueOf(field))) {
                sObj.put(field, defaults.get(field));
            }
        }
    }

    /**
     * @description Internal custom exception class
     */
    public class TestFactoryException extends Exception {
    }

    /**
     * @description Use the FieldDefaults interface to set up values you want to default in for all objects
     */
    public interface FieldDefaults {
        /**
         * @description Interface used by implementing classes to define defaults.
         * @return     `Map<Schema.SObjectField, Object>`
         */
        Map<Schema.SObjectField, Object> getFieldDefaults();
    }

    /**
     * @description     creates a test user. Useful for permissions testing
     * @param profileId Profile Id to use when creating a user.
     * @param doInsert  Boolean, should this code insert the user?
     * @return          `User`
     */
    public static User createTestUser(Id profileId, boolean doInsert) {
        User u = new User(
            profileId = profileId,
            LastName = 'last',
            Email = 'Testuser@test.example.com',
            Username = 'Testuser@test.example.com' + Crypto.getRandomInteger(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        if (doInsert) {
            insert u;
        }
        return u;
    }

    /**
     * @description       Creates a test user with a given profile.
     * @param doInsert    Should this code insert the created user?
     * @param profileName Name of the profile to create the user with.
     * @return           `User`
     */
    public static User createTestUser(Boolean doInsert, String profileName) {
        Profile selectedProfile = [
            SELECT Id
            FROM Profile
            WHERE Name = :profileName
        ];
        return createTestUser(selectedProfile.Id, doInsert);
    }

    /**
     * @description    Creates a user with the Minimum Access Profile
     * Relies on the previous method for creating the user.
     * @param doInsert Should this code insert the user?
     * @return        `User`
     */
    public static User createMinAccessUser(Boolean doInsert) {
        Id profileId = [
            SELECT Id
            FROM Profile
            WHERE Name = 'Minimum Access - Salesforce'
        ]
        .Id;
        return TestFactory.createTestUser(profileId, doInsert);
    }

    /**
     * @description       Assigns a permission set to a given user.
     * @param usr         User to assign the permission set to.
     * @param permSetName String name of the permission set.
     */
    public static void assignPermSetToUser(User usr, String permSetName) {
        id permSetId = [
            SELECT Id
            FROM PermissionSet
            WHERE name LIKE :permSetName
            LIMIT 1
        ]
        .Id;
        PermissionSetAssignment psa = new PermissionSetAssignment(
            AssigneeId = usr.Id,
            PermissionSetId = permSetId
        );
        insert psa;
    }

    /**
     * @description    Intentionally invalidates a list of sObjects. This is useful for
     *                  intentionally causing DML errors during testing.
     * @param incoming List of SObjects
     * @return        `List<sObject>`
     */
    public static List<sObject> invalidateSObjectList(List<sObject> incoming) {
        for (sObject obj : incoming) {
            obj.put('name', '');
        }
        return incoming;
    }
}
