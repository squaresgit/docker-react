# build phase of the script /base image as we will then need ot run the nginx server 
FROM node:16-alpine as builder
RUN mkdir -p /home/node/app
WORKDIR "/home/node/app"

COPY --chown=node ./package.json ./
RUN npm install

COPY . .
RUN npm run build

###################################################################################
# run phase where we take the output of the npm build folder o feed the nginx server

FROM nginx
EXPOSE 80
# from the builder phase copy the build folder ot the default suggested nginx static folder.
COPY --from=builder /home/node/app/build /usr/share/nginx/html
