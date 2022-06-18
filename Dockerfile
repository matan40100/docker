FROM node:alpine AS client
WORKDIR /app/client/
COPY package.json .
RUN npm i
COPY . .
RUN npm run build

FROM node:alpine AS common
WORKDIR /app/common/
COPY . .


FROM node:alpine AS server
WORKDIR /app/server/
COPY --from=client /app/client/build/ ./client/build
WORKDIR /app/server/
COPY package.json .
RUN npm i
COPY server.js .
EXPOSE 3000
CMD ['node','server']