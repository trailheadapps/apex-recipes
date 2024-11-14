#!/bin/bash
SCRIPT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd $SCRIPT_PATH/..

# Remove old docs
rm -fr docs && \
rm -fr force-app/main/default/staticresources/documentation && \

# Generate Apex doc files
./node_modules/.bin/apexdocs markdown -p global public private protected namespaceaccessible -s force-app/main/default/classes && \

# Remove doc index
rm docs/index.md && \

# Flatten directory structure
find docs/* -mindepth 1 -type f -exec mv -i '{}' docs ';' && \

# Remove empty folders
find docs/* -type d -empty -delete && \

# Replace relative links and remove .md extension
find docs/ -type f -name "*.md" -print0 | xargs -0 sed -i "" -E "s@]\(\.\/(.*)\.md@](https://github.com/trailheadapps/apex-recipes/wiki/\1@g" && \
find docs/ -type f -name "*.md" -print0 | xargs -0 sed -i "" -E "s@\]\(\.\.\/.*\/(.*)\.md@](https://github.com/trailheadapps/apex-recipes/wiki/\1@g" && \

# Move docs
mv docs force-app/main/default/staticresources/documentation
