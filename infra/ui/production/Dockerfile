FROM node:8.15.0

WORKDIR /usr/src/app

COPY ./ui ./

RUN npm install

RUN npm run build

CMD ["/bin/bash"]
