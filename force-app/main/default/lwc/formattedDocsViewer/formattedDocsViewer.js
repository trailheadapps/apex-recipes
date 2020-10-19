import { LightningElement, api } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import markdownIt from '@salesforce/resourceUrl/markdownIt';
import highlight from '@salesforce/resourceUrl/highlight';
import docs from '@salesforce/resourceUrl/documentation';

export default class FormattedDocsViewer extends LightningElement {
    @api recipeName;
    markdownDoc;
    markdownIt;
    prism;
    error;
    markdownItInitialized = false;

    renderedCallback() {
        Promise.all([
            loadScript(this, markdownIt),
            fetch(docs + '/docs/docs/' + this.recipeName + '.md').then(
                (response) => {
                    return response.text().then((text) => {
                        let textArray = text.split('\n');
                        textArray.splice(0, 2);
                        this.markdownDoc = textArray.join('\n');
                    });
                }
            ),
            loadStyle(this, highlight + '/prism.css'),
            loadScript(this, highlight + '/prism.js')
        ])
            .then(() => {
                this.markdownItInitialized = true;
                this.error = undefined;
                this.prism = Prism;
                this.markdownIt = window.markdownit();
                this.formatMarkdown();
                this.highlightCodeSegments();
            })
            .catch((error) => {
                this.error = error;
            });
    }

    formatMarkdown() {
        if (this.markdownDoc && this.markdownItInitialized) {
            let docsHtml = document.createElement('div');
            docsHtml.innerHTML = this.markdownIt.render(this.markdownDoc);
            this.template
                .querySelector('div.markdownDoc')
                .appendChild(docsHtml);
            this.applyStyling();
        }
    }

    highlightCodeSegments() {
        const codeElements = this.template.querySelectorAll(
            'code.language-java'
        );
        codeElements.forEach((element) => {
            this.prism.highlightElement(element);
        });
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
