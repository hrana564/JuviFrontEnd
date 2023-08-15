# Use the official Node.js image as the base
FROM node:latest as build

# Set the working directory
WORKDIR /app

# Install Git
RUN apt-get update && apt-get install -y git

# Clone your Git repository
RUN git clone https://github.com/hrana564/JuviFrontEnd.git .

# Install dependencies
RUN npm install

# Build the AngularJS app
RUN npm run build

# Use the official NGINX image as the web server
FROM nginx:latest

# Remove the default NGINX configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom NGINX configuration file
COPY nginx.conf /etc/nginx/conf.d/

# Copy the built app from the previous stage
COPY --from=build /app/dist/my-app /usr/share/nginx/html