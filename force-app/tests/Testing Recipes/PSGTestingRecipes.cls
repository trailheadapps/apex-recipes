@isTest
private class PSGTestingRecipes {
    @isTest
    static void testRecalculatePSG() {
        // get the PSG by name
        PermissionSetGroup psg = [
            SELECT Id, Status
            FROM PermissionSetGroup
            WHERE DeveloperName = 'Permission_Set_Group_for_testing'
        ];

        // Get a second Permission Set and add it to the Permission Set Group
        // programmatically.
        PermissionSet ps = [
            SELECT Id
            FROM PermissionSet
            WHERE Name = 'Read_access_to_Account_Shipping_Address'
            LIMIT 1
        ];

        // add the Permission Set to the Permission Set Group
        insert new PermissionSetGroupComponent(
            PermissionSetGroupId = psg.Id,
            PermissionSetId = ps.Id
        );

        // Force the Permission Set Group to recalculate after adding
        // the Permission Set.
        Test.calculatePermissionSetGroup(psg.Id);

        // Create a TestUser, using helper method from Apex Recipes
        User testUser = TestFactory.createMinAccessUser(true);

        // assign PSG to current user (this fails if PSG is Outdated)
        insert new PermissionSetAssignment(
            PermissionSetGroupId = psg.Id,
            AssigneeId = testUser.Id
        );

        System.runAs(testUser) {
            // This uses the CanTheUser library from Apex Recipes
            System.Assert.isTrue(
                CanTheUser.read(new Account()),
                'Expected to be able to read accounts'
            );

            System.Assert.isTrue(
                CanTheUser.flsAccessible('Account', 'ShippingStreet'),
                'Expected a min-access profile with the Sales Persona PSG to have access to shippingStreet field'
            );
        }

    }
}
