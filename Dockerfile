# Stage0: build front-end app
FROM node:10.16.0 as builder
# set up env
ENV PROJECT_ENV production
ENV NODE_ENV production
# create app folder
ADD . /app/
# enter app folder
WORKDIR /app
# copy the package.json under current folder to app
COPY package.json /app/
RUN yarn install
COPY ./ /app/
RUN yarn build

# Stage1: based on Nginx
FROM nginx:1.15
EXPOSE 80
COPY --from=builder /app/build/ /usr/share/nginx/html
# COPY nginx.conf /etc/nginx/nginx.conf