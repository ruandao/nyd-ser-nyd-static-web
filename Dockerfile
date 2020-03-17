FROM node:alpine as builder

## Install build toolchain, install node deps and compile native add-ons
RUN apk add --no-cache python make g++


WORKDIR /app

COPY ser /app/
RUN npm install

COPY ser /appx/
RUN rm -rf /appx/node_modules
RUN cp -r /appx/* /app/

FROM node:alpine as app

## Copy built node modules and binaries without including the toolchain
COPY --from=builder /app /app

WORKDIR /app

CMD ["npm", "start"]
