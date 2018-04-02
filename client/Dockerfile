FROM node:carbon

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

VOLUME /usr/src/app

EXPOSE 3000

CMD ["npm", "start"]