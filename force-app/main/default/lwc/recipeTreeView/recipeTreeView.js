import { LightningElement } from 'lwc';
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

function toggleExpandNode(nodes, targetName) {
    let isFound = false;
    for (let i = 0; !isFound && i < nodes.length; i++) {
        if (nodes[i].items) {
            if (nodes[i].name === targetName) {
                isFound = true;
                nodes[i].expanded = !nodes[i].expanded;
            } else {
                nodes[i].items = toggleExpandNode(nodes[i].items, targetName);
            }
        }
    }
    return nodes;
}

export default class RecipeTreeView extends LightningElement {
    treeData;
    selectedItem;
    error;

    async connectedCallback() {
        try {
            this.treeData = await generateTreeData();
        } catch (error) {
            this.error = error;
        }
    }

    handleTreeItemSelect(event) {
        let selectedItemName = event.detail.name;
        // Prevent selection of tree nodes and instead toggle collapse
        if (isTreeNode(this.treeData, selectedItemName)) {
            // Clone tree data to allow modifications
            const treeData = JSON.parse(JSON.stringify(this.treeData));
            // Toggle expand/collapse selected node
            this.treeData = toggleExpandNode(treeData, selectedItemName);
            // For async selection to prevent selection bug
            Promise.resolve().then(() => {
                this.selectedItem = event.detail.name;
            });
            selectedItemName = undefined;
        }
        this.dispatchEvent(
            new CustomEvent('recipeselect', {
                detail: selectedItemName
            })
        );
    }
}
