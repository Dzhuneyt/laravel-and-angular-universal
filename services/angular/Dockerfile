### STAGE 1: Build ###

# We label our stage as ‘builder’
FROM node:10-alpine as builder

COPY package.json package-lock.json ./

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build

RUN npm ci && mkdir /ng-app && mv ./node_modules ./ng-app

WORKDIR /ng-app

COPY . .

## Build the angular app in production mode and store the artifacts in dist folder

RUN npm run build:ssr


### STAGE 2: Setup ###

FROM node:10-alpine

RUN npm install pm2 -g

WORKDIR /app

## From ‘builder’ stage copy over the artifacts
COPY --from=builder /ng-app/dist /app/dist
EXPOSE 4000

CMD ["pm2-runtime", "dist/server"]
