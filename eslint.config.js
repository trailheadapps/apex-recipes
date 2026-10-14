'use strict';

const { defineConfig } = require('eslint/config');
const salesforceLwcConfig = require('@salesforce/eslint-config-lwc/recommended');

module.exports = defineConfig([
    {
        files: ['**/lwc/**/*.js'],
        extends: [salesforceLwcConfig]
    }
]);
