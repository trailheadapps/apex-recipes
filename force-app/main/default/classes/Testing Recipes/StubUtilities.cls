@isTest
public with sharing class StubUtilities {
    /**
     * @description a static incrementing counter tied to transaction
     * a new comment
     */
    private static Integer counter {
        get {
            if (counter == null) {
                counter = 0;
            }
            counter++;

            return counter;
        }
        set;
    }
    /**
     * @description             Used when you want a MockedMethod to return a
     * set of IDs of a given sObject Type
     * @param sObjectTypeString Name of type: ie: `Account`
     * @param size              Number of valid Ids to return
     * @return                  `List<Id>`
     */
    public static List<Id> generateSObjectIds(
        String sObjectTypeString,
        Integer size
    ) {
        SObjectType sObjectType = ((SObject) Type.forName(sObjectTypeString)
                .newInstance())
            .getSObjectType();

        String keyPrefix = sObjectType.getDescribe().getKeyPrefix();
        List<Id> ids = new List<Id>();

        for (Integer i = 0; i < size; i++) {
            Integer uniqueCounter = counter;
            ids.add(
                keyPrefix +
                '0'.repeat(12 - String.valueOf(uniqueCounter).length()) +
                uniqueCounter
            );
        }

        return ids;
    }
}
