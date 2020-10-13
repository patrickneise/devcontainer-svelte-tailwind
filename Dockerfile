FROM node:13.12.0-alpine as build

WORKDIR /app

COPY package.json ./
COPY yarn.lock ./

RUN yarn install

COPY . ./

RUN npm run build

FROM nginx:stable-alpine

COPY --chown=nginx:nginx --from=build /app/public /usr/share/nginx/html

COPY --chown=nginx:nginx nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
