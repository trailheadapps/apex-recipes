import { createElement } from 'lwc';
import FormattedDocsViewer from 'c/formattedDocsViewer';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';

const mockFetch = (data) => {
    return jest
        .fn()
        .mockImplementation(() =>
            Promise.resolve({ ok: true, text: () => Promise.resolve(data) })
        );
};

describe('c-formatted-docs-viewer', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        jest.clearAllMocks();
    });

    async function flushPromises() {
        return Promise.resolve();
    }

    // it loads markdownIt on rendered callback
    it('should load markdown-it on rendered callback', async () => {
        const MARKDOWN_IT = 'markdownIt';
        const PRISM_JS = 'highlight/prism.js';
        const PRISM_CSS = 'highlight/prism.css';

        //create initial element
        const element = createElement('c-formatted-docs-viewer', {
            is: FormattedDocsViewer
        });
        // eslint-disable-next-line no-unused-vars
        const fetch = (global.fetch = mockFetch(
            'Foo\n Bar\n Baz\n Recipe Docs'
        ));

        document.body.appendChild(element);
        expect(fetch).toHaveBeenCalledTimes(1);
        expect(fetch.mock.calls[0][0]).toBe(
            'documentation/docs/docs/undefined.md'
        );
        expect(loadScript.mock.calls.length).toBe(2);
        expect(loadScript.mock.calls[0][1]).toBe(MARKDOWN_IT);
        expect(loadScript.mock.calls[1][1]).toBe(PRISM_JS);
        expect(loadStyle.mock.calls[0][1]).toEqual(PRISM_CSS);

        await flushPromises();
        const docsEl = element.shadowRoot.querySelector('div.markdownDoc');
        expect(docsEl.textContent).toBe('');
    });
});
