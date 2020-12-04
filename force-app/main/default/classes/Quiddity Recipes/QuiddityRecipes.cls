/**
 * @description Demonstrates the use and functionaly of Quiddity
 */
public with sharing class QuiddityRecipes {
    /**
     * @description demonstrates the code needed to get the current requests
     * Quiddity value.
     */
    public static Quiddity demonstrateGetQuiddity() {
        return Request.getCurrent().getQuiddity();
    }
}
