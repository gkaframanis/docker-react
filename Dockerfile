FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install 
COPY . .
RUN npm run build

# /app/build <--- The folder with all the stuff that we care about
FROM nginx
# copy something from a different phase 
COPY --from=builder /app/build /usr/share/nginx/html
# The default command of nginx container will start nginx for us.