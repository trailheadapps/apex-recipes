import { createElement } from 'lwc';
import FormattedRecipeDisplay from 'c/formattedRecipeDisplay';
import getRecipeCode from '@salesforce/apex/FormattedRecipeDisplayController.getRecipeCode';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';

jest.mock(
    '@salesforce/apex/FormattedRecipeDisplayController.getRecipeCode',
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
const mockGetRecipeCode = require('./data/getRecipeCode.json');

// Sample error for loadScript error
const LOAD_SCRIPT_ERROR = {
    body: { message: 'An internal server error has occurred' },
    ok: false,
    status: 400,
    statusText: 'Bad Request'
};

describe('c-formatted-recipe-display', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        // Clear mocks so that every test run has a clean implementation
        jest.clearAllMocks();
    });

    // Helper function to wait until the microtask queue is empty. This is needed for promise
    // timing when the platformResourceLoader promises.
    async function flushPromises() {
        return Promise.resolve();
    }

    it('load prism library on rendered callback', () => {
        const PRISM_JS = 'highlight/prism.js';
        const PRISM_CSS = 'highlight/prism.css';

        // Create initial element
        const element = createElement('c-formatted-recipe-display', {
            is: FormattedRecipeDisplay
        });
        document.body.appendChild(element);

        // Validation that the loadScript and loadStyle promises are each called once.
        expect(loadScript.mock.calls.length).toBe(1);
        expect(loadStyle.mock.calls.length).toBe(1);
        // Validation that the PRISM js and css static resources are each passed as parameters.
        expect(loadScript.mock.calls[0][1]).toEqual(PRISM_JS);
        expect(loadStyle.mock.calls[0][1]).toEqual(PRISM_CSS);
    });

    it('shows error panel if error loading prism', () => {
        loadScript.mockRejectedValue(LOAD_SCRIPT_ERROR);

        // Create initial element
        const element = createElement('c-formatted-recipe-display', {
            is: FormattedRecipeDisplay
        });
        document.body.appendChild(element);

        // Return a promise to wait for any asynchronous DOM updates. Jest
        // will automatically wait for the Promise chain to complete before
        // ending the test and fail the test if the promise rejects.
        return flushPromises().then(() => {
            const errorPanelEl = element.shadowRoot.querySelector(
                'div.slds-illustration'
            );
            expect(errorPanelEl).not.toBeNull();
        });
    });

    it('shows recipe code when @wire returns data', () => {
        // Create initial element
        const element = createElement('c-formatted-recipe-display', {
            is: FormattedRecipeDisplay
        });
        element.recipeName = 'SOQLRecipes';
        document.body.appendChild(element);

        // Emit data from @wire
        getRecipeCode.emit(mockGetRecipeCode);

        // Return a promise to wait for any asynchronous DOM updates. Jest
        // will automatically wait for the Promise chain to complete before
        // ending the test and fail the test if the promise rejects.
        return Promise.resolve().then(() => {
            // Select elements for validation
            const codeEl = element.shadowRoot.querySelector('code');
            expect(codeEl.textContent).not.toBeNull();
        });
    });

    it('shows error panel when @wire returns error', () => {
        // Create initial element
        const element = createElement('c-formatted-recipe-display', {
            is: FormattedRecipeDisplay
        });
        element.recipeName = 'SOQLRecipes';
        document.body.appendChild(element);

        // Emit error from @wire
        getRecipeCode.error();

        // Return a promise to wait for any asynchronous DOM updates. Jest
        // will automatically wait for the Promise chain to complete before
        // ending the test and fail the test if the promise rejects.
        return Promise.resolve().then(() => {
            const illustrationDivEl = element.shadowRoot.querySelector(
                'div.slds-illustration'
            );
            expect(illustrationDivEl).not.toBeNull();
        });
    });

    it('is accessible when no recipe selected', () => {
        // Create initial element
        const element = createElement('c-formatted-recipe-display', {
            is: FormattedRecipeDisplay
        });

        document.body.appendChild(element);

        return Promise.resolve().then(() => expect(element).toBeAccessible());
    });

    it('is accessible when error panel shown', () => {
        loadScript.mockRejectedValue(LOAD_SCRIPT_ERROR);

        // Create initial element
        const element = createElement('c-formatted-recipe-display', {
            is: FormattedRecipeDisplay
        });
        document.body.appendChild(element);

        return flushPromises().then(() => expect(element).toBeAccessible());
    });

    it('is accessible when recipe shown', () => {
        // Create initial element
        const element = createElement('c-formatted-recipe-display', {
            is: FormattedRecipeDisplay
        });
        element.recipeName = 'SOQLRecipes';
        document.body.appendChild(element);

        // Emit data from @wire
        getRecipeCode.emit(mockGetRecipeCode);

        return Promise.resolve().then(() => expect(element).toBeAccessible());
    });
});
