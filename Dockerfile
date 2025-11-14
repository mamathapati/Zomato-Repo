FROM node:20-slim AS builder
# Set working directory
WORKDIR /app
# Copy package files
COPY package*.json ./
# Install ALL dependencies (including dev)
RUN npm install
# Copy application source
COPY . .
# Build React app
RUN npm run build



FROM node:20-slim AS production
WORKDIR /app
# Only copy package.json to install prod deps
COPY package*.json ./
# Install ONLY production deps
RUN npm install --production
# Copy built files from builder stage
COPY --from=builder /app/build ./build
# Expose port
EXPOSE 3000
# Start app
CMD ["npm", "start"]
