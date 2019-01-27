FROM node:carbon

WORKDIR /usr/src/app

COPY ./ui/package*.json ./

RUN npm install

VOLUME /usr/src/app

CMD ["npm", "start"]
