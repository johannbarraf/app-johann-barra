FROM node:24 AS develope

WORKDIR /usr/app
COPY package*.json .
RUN npm install

COPY nest-cli.json tsconfig*.json ./
COPY src ./src
RUN npm run build

FROM node:24-alpine AS prod

WORKDIR /usr/app
COPY package*.json .
RUN npm install --omit-dev
COPY --from=develope /usr/app/dist ./dist
EXPOSE 3000

CMD ["node", "dist/main.js"]