import { LightningElement } from 'lwc';

export default class ApexRecipesContainer extends LightningElement {
    selectedRecipe;

    handleRecipeSelect(event) {
        this.selectedRecipe = event.detail;
    }
}
