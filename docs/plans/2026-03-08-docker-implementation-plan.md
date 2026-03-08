# Implementation Plan: Docker Configuration

**Design Document:** `docs/plans/2026-03-08-docker-configuration-design.md`

## Overview

Coolify deployment için production-ready Dockerfile oluşturmak.

---

## Step 1: Create Dockerfile

**File:** `Dockerfile`

Create multi-stage Dockerfile:
- Stage 1 (builder): Node 18 Alpine, install deps, run build
- Stage 2 (production): Nginx Alpine, copy dist, embed nginx.conf

**Implementation details:**
```dockerfile
# Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
# Embed nginx.conf for SPA routing
RUN echo 'server { \
    listen 80; \
    location / { \
        root /usr/share/nginx/html; \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

---

## Step 2: Add .dockerignore

**File:** `.dockerignore`

Exclude unnecessary files from build context:
- `node_modules`
- `dist`
- `.git`
- `*.md`
- `.env*`

---

## Verification

1. Build the image: `docker build -t rickandmorty .`
2. Run container: `docker run -p 80:80 rickandmorty`
3. Test in browser: `http://localhost`

---

## Files Changed

| File | Action |
|------|--------|
| `Dockerfile` | Create |
| `.dockerignore` | Create |