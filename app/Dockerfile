# Stage 1: Build
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .

# Stage 2: Runtime (non-root user + healthcheck)
FROM node:18-alpine
WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy built files
COPY --from=build /app /app

# Change ownership
RUN chown -R appuser:appgroup /app

USER appuser
EXPOSE 3000

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s \
  CMD wget -qO- http://localhost:3000/ || exit 1

CMD ["node", "index.js"]

