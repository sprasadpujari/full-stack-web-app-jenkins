
FROM node:alpine 

WORKDIR /app/backend

COPY ./backend .

RUN npm install

CMD ["node","server.js"]