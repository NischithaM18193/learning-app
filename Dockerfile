# Use the official Node.js image as the base image
FROM node:latest AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular application with verbose logging
RUN npm run build

# Use Nginx to serve the application
FROM nginx:alpine

# Copy the built Angular application to the Nginx HTML directory
COPY --from=build /app/dist/learning-app /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]