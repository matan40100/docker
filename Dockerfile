FROM node:alpine AS client
WORKDIR /app/client/
COPY /client/package.json .
RUN npm i
COPY /client/ .
RUN npm run build

FROM node:alpine AS common
WORKDIR /app/common/
COPY /common/ .


FROM node:alpine AS server
WORKDIR /app/server/
COPY --from=client /app/client/build/ /client/build
WORKDIR /app/server/
COPY /server/package.json .
RUN npm i
COPY /server/ .
EXPOSE 3000
CMD ["node","server"]