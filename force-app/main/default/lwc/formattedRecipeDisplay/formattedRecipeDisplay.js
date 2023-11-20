import { LightningElement, api, wire } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import highlight from '@salesforce/resourceUrl/highlight';
import getRecipeCode from '@salesforce/apex/FormattedRecipeDisplayController.getRecipeCode';

export default class FormattedRecipeDisplay extends LightningElement {
    @api recipeName = ''; // = 'SOQLRecipes';
    recipe;
    prism;
    error;
    description;
    prismInitialized = false;

    @wire(getRecipeCode, { recipeName: '$recipeName' })
    recipeFunc({ error, data }) {
        if (data) {
            this.recipe = data;
            this.error = undefined;
            this.description = this.extractDescription();
        } else if (error) {
            this.error = error;
            this.recipe = undefined;
        }
    }

    renderedCallback() {
        this.loadPrism();
    }

    loadPrism() {
        this.prismInitialized = true;
        if (this.prism === undefined) {
            Promise.all([
                loadStyle(this, highlight + '/prism.css'),
                loadScript(this, highlight + '/prism.js')
            ])
                .then(() => {
                    this.error = undefined;
                    // eslint-disable-next-line no-undef
                    this.prism = Prism;
                    this.highlightCodeSegment();
                })
                .catch((error) => {
                    this.error = error;
                });
        } else {
            this.highlightCodeSegment();
        }
    }

    highlightCodeSegment() {
        if (this.recipe && this.prism) {
            const codeBlock = this.template.querySelector('code.language-java');
            if (codeBlock !== undefined) {
                codeBlock.textContent = this.recipe.body;
            }
            this.prism.highlightElement(
                this.template.querySelector('code.language-java')
            );
        }
    }

    extractDescription() {
        var description = '';
        if (this.recipe) {
            const regex = /\/\*{2,2}([\s\S]*?)\*\//m;
            description = regex.exec(this.recipe.body);
            if (description && description[0]) {
                description = description[0]
                    .replace('/**', '')
                    .replace('@description', '')
                    .replace('*/', '')
                    .replace(/\*/g, '')
                    .replace(/@group.*/, '')
                    .replace(/@see.*/g, '')
                    .replace(/ {2,}/, '')
                    .replace('\n', '');
            }
        }
        return description;
    }

    get githubUrl() {
        return (
            'https://github.com/trailheadapps/apex-recipes/edit/master/force-app/main/default/classes/' +
            this.recipe.groupName +
            '/' +
            this.recipe.name +
            '.cls'
        );
    }
}
