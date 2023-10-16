/**
 * @description This is a setup class used for two purposes.
 *  1. to create file attachments from static resources.
 *  2. to reset the app menu order so that Apex Recipes is front and center.
 * This files does *not* get pushed to the Salesforce org  but it is version controlled
 */

// Attach 3 files to the first 5 accounts.
Account[] accts = [SELECT Id FROM Account LIMIT 5];

StaticResource[] testData = [
    SELECT Id, Body, Name
    FROM StaticResource
    WHERE Name IN ('helloaudio', 'helloworld', 'logo')
    ORDER BY ID
];

for (Account acct : accts) {
    for (StaticResource resource : testData) {
        String fileName = '';
        if (resource.Name.equalsIgnoreCase('logo')) {
            fileName = resource.Name + '.png';
        } else if (resource.Name.equalsIgnoreCase('helloworld')) {
            fileName = resource.Name + '.docx';
        } else {
            filename = resource.Name + '.m4a';
        }
        FilesRecipes.createFileAttachedToRecord(
            resource.Body,
            acct.Id,
            fileName
        );
    }
}

// Reorder App Menu
System.enqueueJob(new OrderAppMenu());
