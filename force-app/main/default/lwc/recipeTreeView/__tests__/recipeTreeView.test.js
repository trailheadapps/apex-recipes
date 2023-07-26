import { createElement } from 'lwc';
import RecipeTreeView from 'c/recipeTreeView';
import generateTreeData from '@salesforce/apex/RecipeTreeViewController.generateTreeData';

// Mock generateTreeData Apex wire adapter
jest.mock(
    '@salesforce/apex/RecipeTreeViewController.generateTreeData',
    () => {
        return {
            default: jest.fn()
        };
    },
    { virtual: true }
);

// Realistic data with a list of records
const mockGenerateTreeData = require('./data/generateTreeData.json');

// Helper function to wait until the microtask queue is empty. This is needed for promise
// timing when the platformResourceLoader promises.
async function flushPromises() {
    return Promise.resolve();
}

describe('c-recipe-tree-view', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        // Clear mocks so that every test run has a clean implementation
        jest.clearAllMocks();
    });

    it('shows tree data when generateTreeData returns data', async () => {
        generateTreeData.mockResolvedValue(mockGenerateTreeData);

        // Create initial element
        const element = createElement('c-recipe-tree-view', {
            is: RecipeTreeView
        });
        document.body.appendChild(element);

        // Wait for any asynchronous DOM updates
        await flushPromises();
        await flushPromises();

        // Select elements for validation
        const treeEl = element.shadowRoot.querySelector('lightning-tree');
        expect(treeEl.items).toStrictEqual(mockGenerateTreeData);
    });

    it('shows error panel when generateTreeData returns error', async () => {
        generateTreeData.mockRejectedValue('mockError');

        // Create initial element
        const element = createElement('c-recipe-tree-view', {
            is: RecipeTreeView
        });
        document.body.appendChild(element);

        // Wait for any asynchronous DOM updates
        await flushPromises();
        await flushPromises();

        // Check for error panel
        const errorPanelEl = element.shadowRoot.querySelector('c-error-panel');
        expect(errorPanelEl).not.toBeNull();
    });

    it('fires select event when recipe selected', async () => {
        generateTreeData.mockResolvedValue(mockGenerateTreeData);

        // Create initial element
        const element = createElement('c-recipe-tree-view', {
            is: RecipeTreeView
        });
        document.body.appendChild(element);

        // Mock handler for select event
        const handler = jest.fn();

        // Add event listener to catch select event
        element.addEventListener('recipeselect', handler);

        // Wait for any asynchronous DOM updates
        await flushPromises();
        await flushPromises();

        // Emulate a recipe is selected
        const treeEl = element.shadowRoot.querySelector('lightning-tree');
        treeEl.dispatchEvent(
            new CustomEvent('select', { detail: { name: 'SOQLRecipes' } })
        );

        // Validate select event has been fired
        expect(handler).toHaveBeenCalled();
    });

    it('is accessible when recipe shown', async () => {
        generateTreeData.mockResolvedValue(mockGenerateTreeData);

        // Create initial element
        const element = createElement('c-recipe-tree-view', {
            is: RecipeTreeView
        });
        document.body.appendChild(element);

        // Wait for any asynchronous DOM updates
        await flushPromises();
        await flushPromises();

        // Check accessibility
        await expect(element).toBeAccessible();
    });

    it('is accessible when error panel shown', async () => {
        generateTreeData.mockRejectedValue('mockError');

        // Create initial element
        const element = createElement('c-recipe-tree-view', {
            is: RecipeTreeView
        });
        document.body.appendChild(element);

        // Wait for any asynchronous DOM updates
        await flushPromises();
        await flushPromises();

        // Check accessibility
        await expect(element).toBeAccessible();
    });
});
