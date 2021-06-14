import { LightningElement, api, wire } from 'lwc';
import getRelatedClasses from '@salesforce/apex/RelatedCodeTabsController.getRelatedClasses';

export default class RelatedCodeTabs extends LightningElement {
    @api recipeName;
    relatedClasses;

    @wire(getRelatedClasses, { mainClassName: '$recipeName' })
    // eslint-disable-next-line no-unused-vars
    relatedClassesWireFunc({ error, data }) {
        this.relatedClasses = data;
    }

    get testClassName() {
        return this.recipeName + '_Tests';
    }
}
