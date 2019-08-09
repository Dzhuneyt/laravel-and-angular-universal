##!/usr/bin/env sh

# Run the Browser and Server builders in parallel
COMMAND_BUILD_BROWSER_AND_SERVER="npm run build:client-and-server-bundles:watch"
COMMAND_REBUILD_NODEJS_SERVER="npx wait-on --interval 1000 --delay 3000 ./dist/server/main.js && npm run compile:server:watch"

# Run the browser and server bundle builders and also the Universal builder
npx concurrently --names bundles,universal "$COMMAND_BUILD_BROWSER_AND_SERVER" "$COMMAND_REBUILD_NODEJS_SERVER"
