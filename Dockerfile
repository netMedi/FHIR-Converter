#########################################
### Base Image                         ##
#########################################
FROM node:14 AS build
COPY . /app
WORKDIR /app
RUN npm install --only=production --no-fund --no-optional --no-audit

#########################################
### Prod Image                         ##
#########################################
FROM node:14-slim
RUN  apt-get update && apt install libcurl4-gnutls-dev -y && apt autoremove -y
COPY --from=build /app /app
WORKDIR /app
RUN ["chmod", "+x", "/app/deploy/webapp.sh"]
EXPOSE 2019
CMD [ "npm", "start" ]
