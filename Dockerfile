FROM node:12

WORKDIR /usr/ej4tezosDocs/docs

COPY package*.json ./

RUN npm install

COPY . .
