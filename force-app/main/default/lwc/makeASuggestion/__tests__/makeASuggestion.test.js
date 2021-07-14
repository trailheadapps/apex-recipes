import { createElement } from 'lwc';
import MakeASuggestion from 'c/makeASuggestion';

// this mock is static - meaning you can only set the mock
// value once per *file*. So this mock exercises the bigger
// of the two code execution paths.
jest.mock(
    '@salesforce/label/c.Github_username',
    () => {
        return { default: 'someGithubUsername' };
    },
    { virtual: true }
);

describe('c-make-a-suggestion', () => {
    it('should render a link to the users fork and the proper file when github username !== trailheadapps', () => {
        // eslint-disable-line max-len
        const element = createElement('c-make-a-suggestion', {
            is: MakeASuggestion
        });

        element.groupName = 'Files Recipes';
        element.recipeName = 'FilesRecipes';
        document.body.appendChild(element);
        return Promise.resolve().then(() => {
            const suggestionEl = element.shadowRoot.querySelector('a');
            expect(suggestionEl.href).not.toContain('CONTRIBUTION.md');
        });
    });
});
