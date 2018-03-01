FROM node:carbon

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

VOLUME /usr/src/app

EXPOSE 8080

CMD ["npm", "start"]