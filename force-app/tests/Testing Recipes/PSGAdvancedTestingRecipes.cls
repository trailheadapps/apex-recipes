@isTest
private class PSGAdvancedTestingRecipes {
    @isTest
    static void testNegativePSGTestsWithMetadata() {
        // any setup you need for this unit test

        Map<String, Permission_Set_Group_Testing_Result__mdt> mapOfPSGResultMetadata = getMapOfPSGResultMetadata(
            'PSGAdvancedTesting.testNegativePSGTestsWithMetadata'
        );

        // get all permission set groups
        List<PermissionSetGroup> permSetGroups = getPermissionSetGroups();
        // start with a minimum access user profile
        User testUser = TestFactory.createMinAccessUser(true);
        Test.startTest();
        System.runAs(testUser) {
            for (PermissionSetGroup psg : permSetGroups) {
                // assign current PSG to user
                /**
                 * *** WARNING ***
                 * This call to assignPermissionSetGroup does both a query, and DML.
                 * This places important limitations on the number of PSGs that can be
                 * tested in any one given unit test. Traditional ways of avoiding
                 * DML/SOQL in loops will not work here, as each iteration of the loop
                 * MUST have it's permission set information reset. Depending on the
                 * number of queries / dml the tested code executes, this could be a
                 * limiting factor preventing the usefulness of this style of bulk-testing.
                 */
                assignPermissionSetGroup(psg, testUser.Id);
                // get relevant expected results from metadata
                Permission_Set_Group_Testing_Result__mdt expectedResult = mapOfPSGResultMetadata.get(
                    psg.developerName
                );

                Boolean didCatchTheRightException = false;
                try {
                    // Execute your code here
                } catch (Exception exp) {
                    if (
                        exp.getMessage()
                            .containsIgnoreCase(
                                expectedResult.expected_exception_match__c
                            )
                    ) {
                        didCatchTheRightException = true;
                    }
                }
                // Assert the proper exception is thrown.
                // System.assert(
                //     didCatchTheRightException,
                //     expectedResult.failure_log_message__c
                // );
            }
        }
        Test.stopTest();
    }

    private static Map<String, Permission_Set_Group_Testing_Result__mdt> getMapOfPSGResultMetadata(
        String testClassAndName
    ) {
        // Query for CustomMetadata Records about this test
        List<Permission_Set_Group_Testing_Result__mdt> results = [
            SELECT
                Permission_Set_Group__c,
                Expected_Exception_Match__c,
                Failure_Log_Message__c
            FROM Permission_Set_Group_Testing_Result__mdt
            WHERE Test_Class_Method_Name__c LIKE :testClassAndName
        ];

        Map<String, Permission_Set_Group_Testing_Result__mdt> resultMap = new Map<String, Permission_Set_Group_Testing_Result__mdt>();
        for (Permission_Set_Group_Testing_Result__mdt result : results) {
            resultMap.put(result.Permission_set_group__c, result);
        }
        return resultMap;
    }

    private static void assignPermissionSetGroup(
        PermissionSetGroup permissionSetGroup,
        Id userId
    ) {
        // delete any existing permission set assignments
        delete [
            SELECT id
            FROM PermissionSetAssignment
            WHERE
                assigneeId = :userId
                AND permissionSetId IN (
                    SELECT Id
                    FROM PermissionSet
                    WHERE IsOwnedByProfile = FALSE
                )
        ];
        insert new PermissionSetAssignment(
            PermissionSetGroupId = PermissionSetGroup.Id,
            AssigneeId = userId
        );
        if (PermissionSetGroup.status != 'Updated') {
            Test.calculatePermissionSetGroup(PermissionSetGroup.Id);
        }
    }

    private static List<PermissionSetGroup> getPermissionSetGroups() {
        return [SELECT Id, DeveloperName, Status FROM PermissionSetGroup];
    }
}
