FROM node:18.10.0

WORKDIR /appq

COPY ./FrontEnd/package.json .
COPY ./FrontEnd/package-lock.json .

RUN npm install

COPY ./FrontEnd .

EXPOSE 3000

