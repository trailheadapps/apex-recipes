/* global Prism */
import { LightningElement, api } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import markdownIt from '@salesforce/resourceUrl/markdownIt';
import highlight from '@salesforce/resourceUrl/highlight';
import DOCS_BASE_URL from '@salesforce/resourceUrl/documentation';

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
                this.prism = Prism;
                this.markdownIt = window.markdownit();
            } catch (e) {
                this.error = 'Unable to load Prism or MarkdownIt';
            }
            this.loadDocumentation();
        } catch (error) {
            this.error = error;
        }
    }

    async loadDocumentation() {
        this.clearMarkdown();
        // Don't load docs if libraries are not loaded or no recipe is selected
        if (!this.markdownItInitialized || !this._recipeName) {
            return;
        }
        try {
            const response = await fetch(
                `${DOCS_BASE_URL}/${this.recipeName}.md`
            );
            this.markdownDoc = await response.text();
            this.formatMarkdown();
        } catch (error) {
            this.error = error;
        }
    }

    clearMarkdown() {
        this.template
            .querySelector('div.markdownDoc')
            ?.childNodes.forEach((node) => node.remove());
    }

    formatMarkdown() {
        if (this.markdownDoc && this.markdownItInitialized) {
            const docsHtml = document.createElement('div');
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
        this.applyStyleTo('h2', 'slds-text-heading_medium slds-m-top_large');
        this.applyStyleTo(
            'h3',
            'slds-text-heading_small slds-m-top_xx-large slds-m-bottom_x-small'
        );
        this.applyStyleTo('h4', 'slds-text-title_bold slds-m-top_small');
        this.applyStyleTo('p', 'slds-text-body_regular');
    }

    applyStyleTo(selector, cssClasses) {
        const elements = this.template.querySelectorAll(selector);
        elements.forEach((element) => {
            cssClasses.split(' ').forEach((cssClass) => {
                element.classList.add(cssClass);
            });
        });
    }
}
