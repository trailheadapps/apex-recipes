@isTest
private class RecipeTreeViewController_Tests {
    @isTest
    static void testGenerateTreeDataPositive() {
        Map<Id, ApexClass> fakeResults = new Map<Id, ApexClass>(
            [
                SELECT Name, Body
                FROM ApexClass
                WHERE
                    name LIKE 'RecipeTreeViewController'
                    OR name LIKE 'SOQLRecipes'
            ]
        );
        Test.setFixedSearchResults(new List<Id>(fakeResults.keyset()));
        Test.startTest();
        List<RecipeTreeViewController.RecipeTreeData> tree = RecipeTreeViewController.generateTreeData();
        Test.stopTest();

        System.assertEquals(2, tree.size(), 'Expected to find two sub trees');
        System.assert(
            tree[0].name == 'Recipes',
            'Expected Recipes to be the first element'
        );
        System.assert(
            tree[1].name == 'Shared Code',
            'Expected the final element to be Shared code'
        );
        System.assert(
            tree[0].items.size() > 0,
            'expected for recipes to have sub-groups'
        );
        System.assert(
            tree[1].items.size() > 0,
            'expected for shared code to have sub-groups'
        );
    }
}
