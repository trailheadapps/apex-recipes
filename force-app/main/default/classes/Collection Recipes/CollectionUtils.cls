/**
 * @description Library of generic, type safe collection methods.
 * @group Collection Recipes
 */
public with sharing class CollectionUtils {
    /**
     * @description This is a generic, reusable but still typesafe method for
     * generating a Map<Id, Some_SObject> from a list. This code is intended to
     * prevent developers from writing countless for loops just to transform a
     * list of sobjects into a map where the key is something other than the
     * object's Id field.
     *
     * In order to maintain type safety, this accepts a generic list of
     * sObjects. It then determines the concrete sObject type of the incoming
     * lists' first object. This is used to create a new map of type
     * Map<Id, firstItemsType> However, to maintain the generic nature of this,
     * that concretely typed map is cast to a Map<id, sObject>. We then use
     * generic sObject methods of .get() and .set() to construct the map.
     *
     * This works for two reasons:
     * * Because we can always go from a concrete type, say `Account` to the
     *   generic sObject type
     * * When you construct a concrete object but cast it to an sObject, even in
     *   a map context, the concrete sObject type is not lost.
     *
     * @param key String representation of the field name to use as the Key.
     * This must be of type Id for this method.
     * @param incomingList Any list of objects that can be cast to a list of
     * sObjects
     * @example
     * ```
     * Contact[] contacts = [SELECT AccountId, firstName, lastName FROM Contact LIMIT 50];
     * Map<Id, Contact> contactsByAccountId = (Map<Id, Contact>) CollectionUtils.idMapFromCollectionByKey('accountId', contacts);
     * ```
     */
    public static Map<Id, SObject> idMapFromCollectionByKey(
        String key,
        List<SObject> incomingList
    ) {
        String objType = getSobjectTypeFromList(incomingList);
        Type dynamicMapType = Type.forName('Map<Id,' + objType + '>');
        Map<Id, SObject> returnValues = (Map<Id, SObject>) dynamicMapType.newInstance();
        for (SObject current : incomingList) {
            if (current.get(key) != null) {
                returnValues.put((Id) current.get(key), current);
            }
        }
        return returnValues;
    }

    /**
     * @description        Method functions as the above methods do, but returns
     * a map whose keys are strings. The key parameter here must be something
     * castable to string. Note, you are responsible for ensuring the uniqueness
     * of the key's value when using this.
     * @param key          String field name of a field who's value is castable to String.
     * @param incomingList List of incoming sObjects to build the map from
     * @example
     * ```
     * Contact[] contacts = [SELECT AccountId, firstName, lastName FROM Contact LIMIT 50];
     * Map<String, Contact> contactsByAccountId = (Map<String, Contact>) CollectionUtils.stringMapFromCollectionByKey('shippingStreet', contacts);
     * ```
     */
    public static Map<String, SObject> stringMapFromCollectionByKey(
        String key,
        List<SObject> incomingList
    ) {
        String objType = getSobjectTypeFromList(incomingList);
        Type dynamicMapType = Type.forName('Map<String,' + objType + '>');
        Map<String, SObject> returnValues = (Map<String, SObject>) dynamicMapType.newInstance();
        for (SObject current : incomingList) {
            if (current.get(key) != null) {
                returnValues.put((String) current.get(key), current);
            }
        }
        return returnValues;
    }

    /**
     * @description        This method accepts an incoming List of sObjects
     * and generates a Map<id,List<sObject>>. Useful for not littering your
     * codebase full of for loops to, for instance, take a list of Contacts
     * and get a Map of AccountIds to a List<Contacts>.
     * @param key          String name of an field that is of the ID type.
     * @param incomingList List of sObjects to build the map from.
     * @example
     * ```
     * Contact[] contacts = [SELECT AccountId, firstName, lastName FROM Contact LIMIT 50];
     * Map<Id, List<Contact>> contactsByAccountId = (Map<Id, List<Contact>>) CollectionUtils.mapFromCollectionWithCollectionValues('accountId', contacts);
     * ```
     */
    public static Map<Id, List<SObject>> mapFromCollectionWithCollectionValues(
        String key,
        List<SObject> incomingList
    ) {
        String objType = getSobjectTypeFromList(incomingList);
        Type listObjType = Type.forName('List<' + objType + '>');
        Type dynamicMapType = Type.forName('Map<Id, List<' + objType + '>>');
        Map<Id, List<SObject>> returnValues = (Map<Id, List<SObject>>) dynamicMapType.newInstance();
        for (SObject current : incomingList) {
            if (current.get(key) != null) {
                if (returnValues.keySet().contains((Id) current.get(key))) {
                    List<SObject> existingList = returnValues.get(
                        (Id) current.get(key)
                    );
                    existingList.add(current);
                    returnValues.put((Id) current.get(key), existingList);
                } else {
                    List<SObject> newList = (List<SObject>) listObjType.newInstance();
                    newList.add(current);
                    returnValues.put((Id) current.get(key), newList);
                }
            }
        }
        return returnValues;
    }

    private static String getSobjectTypeFromList(List<SObject> incomingList) {
        return (!incomingList.isEmpty())
            ? String.valueOf(incomingList[0]?.getSObjectType())
            : 'sObject';
    }
}
