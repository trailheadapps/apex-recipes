import { createElement } from 'lwc';
import ApexRecipesContainer from 'c/apexRecipesContainer';

// Mock inner components, as it calls Apex and crashes
jest.mock('../../recipeTreeView/recipeTreeView');
// Mock inner components, as it loads JS libraries, and accessibility test crashes
jest.mock('../../formattedRecipeDisplay/formattedRecipeDisplay');

describe('c-apex-recipes-container', () => {
    // Helper function to mock a resolved fetch call.
    function mockFetch(data) {
        return jest
            .fn()
            .mockImplementation(() =>
                Promise.resolve({ ok: true, json: () => Promise.resolve(data) })
            );
    }

    // Mock the successful fetch call. An empty response value is
    // sufficient, as we only test that fetch is called with the
    // expected parameter.
    // eslint-disable-next-line no-unused-vars
    const fetch = (global.fetch = mockFetch({ items: [] }));

    // Helper function to wait until the microtask queue is empty.
    // This is needed for promise timing.
    async function flushPromises() {
        return Promise.resolve();
    }

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
        const recipeTreeViewEl =
            element.shadowRoot.querySelector('c-recipe-tree-view');
        recipeTreeViewEl.dispatchEvent(
            new CustomEvent('recipeselect', {
                detail: 'SOQLRecipes'
            })
        );

        // Return a promise to wait for any asynchronous DOM updates. Jest
        // will automatically wait for the Promise chain to complete before
        // ending the test and fail the test if the promise rejects.
        return Promise.resolve().then(() => {
            // Select element for validation
            const relatedCodeTabsEl = element.shadowRoot.querySelector(
                'c-related-code-tabs'
            );

            expect(relatedCodeTabsEl.recipeName).toBe('SOQLRecipes');
        });
    });

    it('is accessible on initialization', () => {
        // Create initial element
        const element = createElement('c-apex-recipes-container', {
            is: ApexRecipesContainer
        });
        document.body.appendChild(element);

        return flushPromises().then(() => {
            expect(element).toBeAccessible();
        });
    });
});
