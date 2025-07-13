trigger PlatformEventRecipesTrigger on Event_Recipes_Demo__e(after insert) {
    // Treat this as a normal trigger
    new PlatformEventRecipesTriggerHandler().run();
}
