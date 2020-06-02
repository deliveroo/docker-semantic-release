FROM node:14-alpine
RUN apk add --no-cache git
COPY package.json .
COPY package-lock.json .
RUN npm set progress=false && \
	npm config set depth 0 && \
	npm install
ENV PATH /node_modules/.bin:$PATH
