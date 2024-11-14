# Apex Recipes

[![CI Workflow](https://github.com/trailheadapps/apex-recipes/workflows/CI/badge.svg)](https://github.com/trailheadapps/apex-recipes/actions?query=workflow%3ACI) [![Packaging Workflow](https://github.com/trailheadapps/apex-recipes/workflows/Packaging/badge.svg)](https://github.com/trailheadapps/apex-recipes/actions?query=workflow%3APackaging) [![codecov](https://codecov.io/gh/trailheadapps/apex-recipes/branch/main/graph/badge.svg)](https://codecov.io/gh/trailheadapps/apex-recipes)

## Introduction

Apex Recipes is a library of concise, meaningful examples of code for common use cases utilizing best practices. They reflect enterprise patterns that can be utilized
for real world solutions and should be relevant to developers of all skill levels. The code is intended to reflect clarity while trying to maintain brevity. See the Table of Contents for installation options. We recommend using the [Salesforce CLI](https://developer.salesforce.com/tools/sfdxcli) and a scratch org for your initial deployment.

<div>
   <img src="https://res.cloudinary.com/hy4kyit2a/f_auto,fl_lossy,q_70/learn/projects/quick-start-explore-the-apex-recipes-sample-app/185b61248727a9711d31e2f54b62e230_badge.png" align="left" alt="Trailhead Badge" height="40px" width="40px"/>
   <p>Learn more about this app by completing the <a href="https://trailhead.salesforce.com/content/learn/projects/quick-start-explore-the-apex-recipes-sample-app">Quick Start: Explore the Apex Recipes Sample App</a> Trailhead project or by watching this <a href="https://www.youtube.com/watch?v=Fd0m1Cyaq4Q&list=PLgIMQe2PKPSJcuCwM61dEc4jFG_jHqV2t&index=5">short presentation video</a>.</p>
</div>

## Table of contents

-   [Installing Apex Recipes Using a Scratch Org](#installing-the-app-using-a-scratch-org): This is the recommended installation option. Use this option if you are a developer who wants to experience the app and the code.

-   [Installing Apex Recipes Using an Unlocked Package](#installing-the-app-using-an-unlocked-package): This option allows anybody to experience the sample app without installing a local development environment.

-   [Installing Apex Recipes using a Developer Edition Org or a Trailhead Playground via the Salesforce CLI](#installing-the-app-using-a-developer-edition-org-or-a-trailhead-playground): Useful when tackling Trailhead Badges or if you want the app deployed to a more permanent environment than a Scratch org.

-   [Optional installation instructions](#optional-installation-instructions)

## Installing the app using a Scratch Org

1. Set up your environment. Follow the steps in the [Quick Start: Lightning Web Components](https://trailhead.salesforce.com/content/learn/projects/quick-start-lightning-web-components/) Trailhead project. The steps include:

    - Enable Dev Hub in your Trailhead Playground
    - Install Salesforce CLI
    - Install Visual Studio Code
    - Install the Visual Studio Code Salesforce extensions

1. If you haven't already done so, authorize with your hub org and provide it with an alias (**myhuborg** in the command below):

    ```
    sf org login web -d -a myhuborg
    ```

1. Clone the apex-recipes repository:

    ```
    git clone https://github.com/trailheadapps/apex-recipes
    cd apex-recipes
    ```

1. Create a scratch org and provide it with an alias (**apex-recipes** in the command below):

    ```
    sf org create scratch -d -f config/project-scratch-def.json -a apex-recipes
    ```

1. Push the app to your scratch org:

    ```
    sf project deploy start
    ```

1. Assign the **Apex_Recipes** permission set to the default user:

    ```
    sf org assign permset -n Apex_Recipes
    ```

1. Assign the **Walkthroughs** permission set to the default user:

    ```
    sf org assign permset -n Walkthroughs
    ```

1. Import Sample Data

    ```
    sf data tree import -p ./data/data-plan.json
    sf data tree import -p ./data/data-plan2.json
    ```

1. Execute the Anonymous Apex setup script

    ```
    sf apex run --file data/setup.apex
    ```

1. Open the scratch org:

    ```
    sf org open
    ```

1. In App Launcher, select the **Apex Recipes** app.

## Installing the app using an Unlocked Package

Follow this set of instructions if you want to deploy the app to a more permanent environment than a Scratch org or if you don't want to install the local developement tools. You can use a non source-tracked orgs such as a free [Developer Edition Org](https://developer.salesforce.com/signup) or a [Trailhead Playground](https://trailhead.salesforce.com/).

Make sure to start from a **brand-new environment** to avoid conflicts with previous work you may have done.

1. Log in to your org

1. Go to **Setup**, under **Platform Cache**, and click the "Request Trial Capacity" button. [Request a Platform Cache Trial](https://help.salesforce.com/articleView?id=data_platform_cache_trial.htm&type=5)

1. Click [this link](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tKf000000D7x9IAC) to install the Apex Recipes unlocked package in your org.

1. Select **Install for All Users**

1. Once installed:

1. (Optional) Add additional data examples. [In the data folder](https://github.com/trailheadapps/apex-recipes/tree/main/data/) are sample CSV files which can be
   used by dataloader.io or the Import Data Wizard.

1. (Optional) Load the sample Junction objects data:

    - Click the **Setup Gear Icon**
    - Click **Developer Console**
    - Click **Debug**
    - Click **Open Execute Anonymous Window**
    - Enter: `DataFactoryForPackageInstalls.generateData();`
    - Click **Execute**

1. Add the Apex Recipes permission set to your user:

    - Go to **Setup > Users > Permission Sets**.
    - Click **Apex_Recipes**.
    - Click **Manage Assignments**.
    - Check your user and click **Add Assignments**.

1. In App Launcher, select the **Apex Recipes** app.

    - If the app does not load, please double check that the Apex Recipes permission set active on your user.

## Installing the App using a Developer Edition Org or a Trailhead Playground via the Salesforce CLI

Follow this set of instructions if you want to deploy the app to a more permanent environment than a Scratch org.
This includes non source-tracked orgs such as a [free Developer Edition Org](https://developer.salesforce.com/signup) or a [Trailhead Playground](https://trailhead.salesforce.com/).

Make sure to start from a brand-new environment to avoid conflicts with previous work you may have done.

1. Clone this repository:

    ```
    git clone https://github.com/trailheadapps/apex-recipes
    cd apex-recipes
    ```

1. Authorize with your Trailhead Playground or Developer Edition org and provide it with an alias (**mydevorg** in the command below):

    ```
    sf org login web -s -a mydevorg
    ```

1. If you are setting up a Developer Edition: go to **Setup**, under **Platform Cache**, and click the "Request Trial Capacity" button. [Request a Platform Cache Trial](https://help.salesforce.com/articleView?id=data_platform_cache_trial.htm&type=5)

1. Run this command in a terminal to deploy the app.

    ```
    sf project deploy start -d force-app
    ```

1. Assign the `Apex_Recipes` permission set to the default user.

    ```
    sf org assign permset -n Apex_Recipes
    ```

1. Import Sample Data

    ```
    sf data tree import -p ./data/data-plan.json
    sf data tree import -p ./data/data-plan2.json
    ```

1. Execute the Anonymous Apex setup script

    ```
    sf apex run --file data/setup.apex
    ```

1. If your org isn't already open, open it now:

    ```
    sf org open -o mydevorg
    ```

1. In App Launcher, select the **Apex Recipes** app.
    - If the app does not load, please double check that the **Apex Recipes** permission set active on your user.

## Optional Installation Instructions

This repository contains several files that are relevant if you want to integrate modern web development tooling to your Salesforce development processes, or to your continuous integration/continuous deployment processes.

### Code formatting

[Prettier](https://prettier.io/) is a code formatter used to ensure consistent formatting across your code base. To use Prettier with Visual Studio Code, install [this extension](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) from the Visual Studio Code Marketplace. The [.prettierignore](/.prettierignore) and [.prettierrc](/.prettierrc) files are provided as part of this repository to control the behavior of the Prettier formatter.

> **Warning**
> The current Apex Prettier plugin version requires that you install Java 11 or above.

### Code linting

[ESLint](https://eslint.org/) is a popular JavaScript linting tool used to identify stylistic errors and erroneous constructs. To use ESLint with Visual Studio Code, install [this extension](https://marketplace.visualstudio.com/items?itemName=salesforce.salesforcedx-vscode-lwc) from the Visual Studio Code Marketplace. The [.eslintignore](/.eslintignore) file is provided as part of this repository to exclude specific files from the linting process in the context of Lighning Web Components development.

### Apex Docs

[ApexDocs](https://github.com/cesarParra/apexdocs#readme) is a NPM package for generating Markdown (.md) files from the Classes in this repository. The package.json file in
this repo includes an npm script for generating these Apex docs. Execute `npm run apexdocs` to generate fresh docs. These docs are shipped as part of a Static Resource and are available in your org via the Apex Recipes app. Navigate to any class and click it's coresponding Docs tab.

### Pre-commit hook

This repository also comes with a [package.json](./package.json) file that makes it easy to set up a pre-commit hook that enforces code formatting and linting by running Prettier and ESLint every time you `git commit` changes.

To set up the formatting and linting pre-commit hook:

1. Install [Node.js](https://nodejs.org) if you haven't already done so
1. Run `npm install` in your project's root folder to install the ESLint and Prettier modules (Note: Mac users should verify that Xcode command line tools are installed before running this command.)

> Note: This projects also contains [Jest](https://jestjs.io) tests for unit testing Lightning Web Components. If you experience errors regarding `deasync` when running `npm install` please check out the troubleshooting information in the [lwc-jest repository](https://github.com/salesforce/lwc-jest#troubleshooting-deasync-installation-errors).

Prettier and ESLint will now run automatically every time you commit changes. The commit will fail if linting errors are detected. You can also run the formatting and linting from the command line using the following commands (check out [package.json](./package.json) for the full list):

```
npm run lint
npm run prettier
```
