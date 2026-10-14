#!/bin/bash
# Derived from: https://github.com/SwiftDocOrg/github-wiki-publish-action
# Author: Mattt (@mattt)
# License: MIT

set -euo pipefail

function debug() {
    echo "::debug file=${BASH_SOURCE[0]},line=${BASH_LINENO[0]}::$1"
}

function warning() {
    echo "::warning file=${BASH_SOURCE[0]},line=${BASH_LINENO[0]}::$1"
}

function error() {
    echo "::error file=${BASH_SOURCE[0]},line=${BASH_LINENO[0]}::$1"
}

function add_mask() {
    echo "::add-mask::$1"
}

if [ -z "$GITHUB_ACTOR" ]; then
    error "GITHUB_ACTOR environment variable is not set"
    exit 1
fi

if [ -z "$GH_PERSONAL_ACCESS_TOKEN" ]; then
    error "GH_PERSONAL_ACCESS_TOKEN environment variable is not set"
    exit 1
fi

add_mask "${GH_PERSONAL_ACCESS_TOKEN}"

GIT_REPOSITORY_URL="https://${GH_PERSONAL_ACCESS_TOKEN}@github.com/trailheadapps/apex-recipes.wiki.git"

debug "Checking out wiki repository"
tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
(
    cd "$tmp_dir" || exit 1
    git init
    git config user.name "$GITHUB_ACTOR"
    git config user.email "$GITHUB_ACTOR@users.noreply.github.com"
    git pull "$GIT_REPOSITORY_URL"
) || exit 1

debug "Enumerating contents of $1"
for file in $(find "$1" -maxdepth 1 -type f -name '*.md' -execdir basename '{}' ';'); do
    debug "Copying $file"
    cp "$1/$file" "$tmp_dir"
done

debug "Committing and pushing changes"
(
    cd "$tmp_dir" || exit 1
    git add .
    if git diff --cached --quiet; then
        debug "No changes to publish"
    else
        git commit -m "Automatically publish wiki"
        git push --set-upstream "$GIT_REPOSITORY_URL" master
    fi
) || exit 1

rm -rf "$tmp_dir"
exit 0