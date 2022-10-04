FROM node:16-alpine as build-stage
#RUN npm install -g http-server
#RUN mkdir -p /s/app
WORKDIR /usr/src/app
COPY /avaliauto/package.json /usr/src/app/
RUN ls /usr/src/app
RUN node -v
RUN npm -v
RUN npm install -g npm@8.15.1 
RUN npm -v
RUN npm install
COPY /avaliauto/ /usr/src/app/
RUN ls /usr/src/app
RUN npm list
RUN npm run build
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html
RUN ls -l /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx","-g","daemon off;"]

