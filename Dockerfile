FROM node:12

# LABEL description="A demo Dockerfile for build Docsify."

WORKDIR /usr/ej4tezosDocs/docs

COPY package*.json ./

RUN npm install

COPY . .

# RUN npm install -g docsify-cli@latest

# EXPOSE 3000/tcp

# ENTRYPOINT docsify serve .