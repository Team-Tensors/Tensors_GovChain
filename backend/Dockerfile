FROM node:20-alpine

WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install all dependencies including devDependencies
RUN npm install

# Copy source code
COPY . .

EXPOSE 5000

# Use dev script with ts-node-dev
CMD ["npm", "run", "dev"]
