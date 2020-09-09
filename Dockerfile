FROM node:14.9-alpine
WORKDIR '/app'
COPY package.json .
RUN npm install 
COPY . .
RUN npm run build

# /app/build <--- The folder with all the stuff that we care about
FROM nginx:1.19.2-alpine
# It's for communication between developers. To understand that this container probably needs to get a port mapped to port 80.
# This instruction does nothing automatically. Elasticbeanstalk will look at that and use that port for incoming traffic.
EXPOSE 80
# copy something from a different phase 
COPY --from=0 /app/build /usr/share/nginx/html
# The default command of nginx container will start nginx for us.