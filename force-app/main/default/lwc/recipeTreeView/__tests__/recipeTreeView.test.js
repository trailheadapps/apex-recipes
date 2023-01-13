import { createElement } from 'lwc';
import RecipeTreeView from 'c/recipeTreeView';
import generateTreeData from '@salesforce/apex/RecipeTreeViewController.generateTreeData';

// Mock generateTreeData Apex wire adapter
jest.mock(
    '@salesforce/apex/RecipeTreeViewController.generateTreeData',
    () => {
        const {
            createApexTestWireAdapter
        } = require('@salesforce/sfdx-lwc-jest');
        return {
            default: createApexTestWireAdapter(jest.fn())
        };
    },
    { virtual: true }
);

// Realistic data with a list of records
const mockGenerateTreeData = require('./data/generateTreeData.json');

// Register as Apex wire adapter. Some tests verify that provisioned values trigger desired behavior.

describe('c-recipe-tree-view', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        // Clear mocks so that every test run has a clean implementation
        jest.clearAllMocks();
    });

    it('shows tree data when @wire returns data', () => {
        // Create initial element
        const element = createElement('c-recipe-tree-view', {
            is: RecipeTreeView
        });
        document.body.appendChild(element);

        // Emit data from @wire
        generateTreeData.emit(mockGenerateTreeData);

        // Return a promise to wait for any asynchronous DOM updates. Jest
        // will automatically wait for the Promise chain to complete before
        // ending the test and fail the test if the promise rejects.
        return Promise.resolve().then(() => {
            // Select elements for validation
            const treeEl = element.shadowRoot.querySelector('lightning-tree');
            expect(treeEl.items).toStrictEqual(mockGenerateTreeData);
        });
    });

    it('shows error panel when @wire returns error', () => {
        // Create initial element
        const element = createElement('c-recipe-tree-view', {
            is: RecipeTreeView
        });
        document.body.appendChild(element);

        // Emit error from @wire
        generateTreeData.error();

        // Return a promise to wait for any asynchronous DOM updates. Jest
        // will automatically wait for the Promise chain to complete before
        // ending the test and fail the test if the promise rejects.
        return Promise.resolve().then(() => {
            const errorPanelEl =
                element.shadowRoot.querySelector('c-error-panel');
            expect(errorPanelEl).not.toBeNull();
        });
    });

    it('fires select event when recipe selected', () => {
        // Create initial element
        const element = createElement('c-recipe-tree-view', {
            is: RecipeTreeView
        });
        document.body.appendChild(element);

        // Mock handler for select event
        const handler = jest.fn();

        // Add event listener to catch select event
        element.addEventListener('recipeselect', handler);

        // Emit data from @wire, so that the tree is rendered
        generateTreeData.emit(mockGenerateTreeData);

        // Return a promise to wait for any asynchronous DOM updates. Jest
        // will automatically wait for the Promise chain to complete before
        // ending the test and fail the test if the promise rejects.
        return Promise.resolve().then(() => {
            // Emulate a recipe is selected
            const treeEl = element.shadowRoot.querySelector('lightning-tree');
            treeEl.dispatchEvent(
                new CustomEvent('select', { detail: { name: 'SOQLRecipes' } })
            );

            // Validate select event has been fired
            expect(handler.mock.calls.length).toBe(1);
        });
    });

    it('is accessible when recipe shown', () => {
        // Create initial element
        const element = createElement('c-recipe-tree-view', {
            is: RecipeTreeView
        });
        document.body.appendChild(element);

        // Emit data from @wire
        generateTreeData.emit(mockGenerateTreeData);

        return Promise.resolve().then(() => expect(element).toBeAccessible());
    });

    it('is accessible when error panel shown', () => {
        // Create initial element
        const element = createElement('c-recipe-tree-view', {
            is: RecipeTreeView
        });
        document.body.appendChild(element);

        // Emit error from @wire
        generateTreeData.error();

        return Promise.resolve().then(() => expect(element).toBeAccessible());
    });
});
