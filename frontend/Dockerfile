# Stage 1: Build the React app
FROM node:20-alpine AS build

WORKDIR /app

# Copy package files first (better layer caching)
COPY package*.json ./
RUN npm install

# Copy rest of the application
COPY . .

# Build the production version
RUN npm run build

# Stage 2: Serve with a lightweight web server (nginx)
FROM nginx:alpine

# Copy the build output to nginx's html directory
COPY --from=build /app/dist /usr/share/nginx/html

# Copy custom nginx config (optional)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
