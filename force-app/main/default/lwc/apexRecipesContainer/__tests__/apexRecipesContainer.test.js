import { createElement } from 'lwc';
import ApexRecipesContainer from 'c/apexRecipesContainer';

// Mock inner components, as it calls Apex and crashes
jest.mock('../../recipeTreeView/recipeTreeView');
// Mock inner components, as it loads JS libraries, and accessibility test crashes
jest.mock('../../formattedRecipeDisplay/formattedRecipeDisplay');

describe('c-apex-recipes-container', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('shows correct recipe when selected', () => {
        // Create initial element
        const element = createElement('c-apex-recipes-container', {
            is: ApexRecipesContainer
        });
        document.body.appendChild(element);

        // Emulate selecting a recipe
        const recipeTreeViewEl = element.shadowRoot.querySelector(
            'c-recipe-tree-view'
        );
        recipeTreeViewEl.dispatchEvent(
            new CustomEvent('select', {
                detail: { name: 'SOQLRecipes' }
            })
        );

        // Return a promise to wait for any asynchronous DOM updates. Jest
        // will automatically wait for the Promise chain to complete before
        // ending the test and fail the test if the promise rejects.
        return Promise.resolve().then(() => {
            // Select element for validation
            const formattedRecipeDisplayEl = element.shadowRoot.querySelector(
                'c-formatted-recipe-display'
            );

            expect(formattedRecipeDisplayEl.recipeName).toBe('SOQLRecipes');
        });
    });

    it('is accessible on initialization', () => {
        // Create initial element
        const element = createElement('c-apex-recipes-container', {
            is: ApexRecipesContainer
        });
        document.body.appendChild(element);

        return Promise.resolve().then(() => expect(element).toBeAccessible());
    });
});
