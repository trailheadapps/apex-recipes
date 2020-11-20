/**
 * @description Demonstrates the use and functionaly of Quiddity
 */
public with sharing class QuiddityRecipes {
    public static void demonstrateGetQuiddity() {
        Request reqInfo = Request.getCurrent();
        System.debug(reqInfo.getQuiddity());
    }
}
