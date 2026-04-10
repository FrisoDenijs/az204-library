# based on https://medium.com/@ardasugur/angular-17-ssr-dockerization-fb653b4130c6
FROM node:24.13.0 as build
WORKDIR /app/src
COPY package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

FROM node:24.13.0
WORKDIR /usr/app
COPY --from=build /app/src/dist/library-ui/ ./
CMD node server/server.mjs
EXPOSE 4000