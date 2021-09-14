FROM node:14 AS build

WORKDIR /app

COPY ./package*.json ./

RUN npm install

COPY ./ ./

RUN npm run build

FROM nginx:1.14.0-alpine

MAINTAINER Richard Chesterwood "richard@inceptiontraining.co.uk"

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/

CMD ["nginx", "-g", "daemon off;"]
