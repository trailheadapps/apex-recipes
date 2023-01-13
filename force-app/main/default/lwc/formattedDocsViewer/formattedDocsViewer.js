import { LightningElement, api } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import markdownIt from '@salesforce/resourceUrl/markdownIt';
import highlight from '@salesforce/resourceUrl/highlight';
import docs from '@salesforce/resourceUrl/documentation';

export default class FormattedDocsViewer extends LightningElement {
    _recipeName;
    markdownDoc;
    markdownIt;
    prism;
    error;
    markdownItInitialized = false;

    @api
    get recipeName() {
        return this._recipeName;
    }
    set recipeName(value) {
        this._recipeName = value;
        this.loadDocumentation();
    }

    async renderedCallback() {
        try {
            await Promise.all([
                loadScript(this, markdownIt),
                loadStyle(this, highlight + '/prism.css'),
                loadScript(this, highlight + '/prism.js')
            ]);
            this.markdownItInitialized = true;
            this.error = undefined;
            try {
                this.prism = Prism; // eslint-disable-line no-undef
                this.markdownIt = window.markdownit();
            } catch (e) {
                this.error = 'Unable to load Prism or MarkdownIt';
            }
            this.formatMarkdown();
        } catch (error) {
            this.error = error;
        }
    }

    async loadDocumentation() {
        try {
            this.clearMarkdown();
            const response = await fetch(
                docs + '/docs/docs/' + this.recipeName + '.md'
            );
            const text = await response.text();
            const textArray = text.split('\n');
            textArray.splice(0, 2);
            this.markdownDoc = textArray.join('\n');
            this.formatMarkdown();
        } catch (error) {
            this.error = error;
        }
    }

    clearMarkdown() {
        this.template
            .querySelector('div.markdownDoc')
            .childNodes.forEach((node) => node.remove());
    }

    formatMarkdown() {
        if (this.markdownDoc && this.markdownItInitialized) {
            let docsHtml = document.createElement('div');
            docsHtml.innerHTML = this.markdownIt.render(this.markdownDoc); // eslint-disable-line
            this.template
                .querySelector('div.markdownDoc')
                .appendChild(docsHtml);
            this.applyStyling();
            const codeElements =
                this.template.querySelectorAll('code.language-java');
            codeElements.forEach((element) => {
                this.prism.highlightElement(element);
            });
        }
    }

    applyStyling() {
        this.applyStyleTo('h1', 'slds-text-heading_large');
        this.applyStyleTo('h2', 'slds-text-heading_medium');
        this.applyStyleTo(
            'h3',
            'slds-text-heading_small slds-m-top_large slds-m-bottom_x-small'
        );
        this.applyStyleTo('h4', 'slds-text-title_bold');
        this.applyStyleTo('p', 'slds-text-body_regular');
    }

    applyStyleTo(selector, attr) {
        const templateElements = this.template.querySelectorAll(selector);
        templateElements.forEach((element) => {
            element.setAttribute('class', attr);
        });
    }
}
