import { LightningElement, wire } from 'lwc';
import generateTreeData from '@salesforce/apex/RecipeTreeViewController.generateTreeData';

function isTreeNode(nodes, targetName) {
    let isNode;
    for (let i = 0; isNode === undefined && i < nodes.length; i++) {
        const item = nodes[i];
        if (item.name === targetName) {
            isNode = item.items.length > 0;
        } else if (item.items) {
            isNode = isTreeNode(item.items, targetName);
        }
    }
    return isNode;
}

export default class RecipeTreeView extends LightningElement {
    @wire(generateTreeData)
    treeData;

    handleTreeItemSelect(event) {
        event.preventDefault();
        let selectedItemName = event.detail.name;
        // Prevent selection of tree nodes
        if (isTreeNode(this.treeData.data, selectedItemName)) {
            selectedItemName = undefined;
        }
        const recipeSelectionEvent = new CustomEvent('recipeselect', {
            detail: selectedItemName
        });
        this.dispatchEvent(recipeSelectionEvent);
    }
}
