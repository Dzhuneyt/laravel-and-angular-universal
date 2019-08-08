##!/usr/bin/env sh

COMMAND_BUILD_BROWSER_BUNDLE="ng build --prod --watch"
COMMAND_BUILD_SERVER_BUNDLE="ng run frontend:server:production --bundleDependencies all --watch"

# Run the Browser and Server builders in parallel
COMMAND_BUILD_BROWSER_AND_SERVER="npm run build:client-and-server-bundles:watch"
COMMAND_REBUILD_NODEJS_SERVER="npx wait-on ./dist/server/main.js && npm run compile:server:watch"

npx concurrently --names bundles,universal "$COMMAND_BUILD_BROWSER_AND_SERVER" "$COMMAND_REBUILD_NODEJS_SERVER"
