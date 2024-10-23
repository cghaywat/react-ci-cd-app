# Stage 1: Build the React app
FROM node:14 as build

# Set the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install
RUN npx browserslist@latest --update-db

# Copy the rest of the application code
COPY . ./

# Build the React app
#RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Copy the build output from the previous stage to Nginx's html folder
COPY --from=build /var/lib/jenkins/workspace/NETfLIX_CICD/build/ /usr/share/nginx/html/

# Expose port .
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

