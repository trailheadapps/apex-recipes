import { LightningElement } from 'lwc';

export default class ApexRecipesContainer extends LightningElement {
    selectedRecipe;

    handleSelect(event) {
        this.selectedRecipe = event.detail.name;
    }
}
