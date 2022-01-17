# this is the build phase, as specified by the 'build' alias
FROM node:16-alpine as build
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# Elastic Beanstalk will use this to route traffic to port 80 in our Docker container.
EXPOSE 80
# this means copy something from another phase i.e. in this case the build phase
COPY --from=build /app/build /usr/share/nginx/html
# Note: we don't actually need to start nginx because the default command with nginx is to start nginx


