# Stage 1: Dependencies (install ALL dependencies including devDependencies for build)
FROM node:20-alpine AS deps
WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install all dependencies (including devDependencies needed for build)
RUN npm ci

# Stage 2: Builder
FROM node:20-alpine AS builder
WORKDIR /app

# Set to production
ENV NODE_ENV=production

# Copy dependencies from deps stage
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Build the application
RUN npm run build

# Stage 3: Runner (nginx for static files)
FROM nginx:alpine AS runner
WORKDIR /app

# Create non-root user for security
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup

# Copy built files from builder
COPY --from=builder /app/dist /usr/share/nginx/html

# Create nginx config for SPA routing with proper permissions
RUN echo 'server { \
    listen 3000; \
    server_name localhost; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
    gzip on; \
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml; \
}' > /etc/nginx/conf.d/default.conf

# Set proper permissions
RUN chown -R appuser:appgroup /usr/share/nginx/html && \
    chown -R appuser:appgroup /var/cache/nginx && \
    chown -R appuser:appgroup /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown -R appuser:appgroup /var/run/nginx.pid

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 3000

# Set port
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# Start nginx
CMD ["nginx", "-g", "daemon off;"]