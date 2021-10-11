import { LightningElement, api } from 'lwc';
import githubUsername from '@salesforce/label/c.Github_username';

export default class MakeASuggestion extends LightningElement {
    @api groupName;
    @api recipeName;

    labels = {
        githubUsername
    };

    get githubUrl() {
        if (
            this.labels.githubUsername &&
            this.labels.githubUsername !== 'trailheadapps'
        ) {
            return (
                'https://github.com/' +
                this.labels.githubUsername +
                '/apex-recipes/edit/master/force-app/main/default/classes/' +
                this.groupName +
                '/' +
                this.recipeName +
                '.cls'
            );
        }
        return 'https://github.com/trailheadapps/apex-recipes/blob/main/CONTRIBUTION.md';
    }
}
