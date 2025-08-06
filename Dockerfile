#Build the docker image
# Stage 1: Build stage
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Stage 2: Runtime stage
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy only necessary files from build stage
COPY --from=build /app /app

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]

