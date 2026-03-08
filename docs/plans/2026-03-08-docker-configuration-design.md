# Docker Yapılandırması Tasarımı

**Tarih:** 2026-03-08
**Amaç:** Coolify üzerinden production deployment için Dockerfile oluşturmak

## Kararlar

1. **Multi-stage Dockerfile** - Node.js ile build, Nginx ile serve
2. **Nginx conf gömülü** - Ayrı dosya yok, Dockerfile içinde echo ile oluşturuluyor
3. **docker-compose yok** - Coolify kendi orchestration'ını yapıyor

## Dockerfile Yapısı

### Stage 1: Build (Node 18 Alpine)
- `npm ci` ile bağımlılıkları yükle
- `npm run build` ile production build al
- `/app/dist` klasörü oluşur

### Stage 2: Production (Nginx Alpine)
- dist/ dosyalarını `/usr/share/nginx/html` kopyala
- nginx.conf'u gömülü olarak oluştur (SPA routing için try_files)
- Port 80 expose
- CMD nginx foreground

## Nginx Konfigürasyonu

SPA routing için gerekli ayarlar:
- `try_files $uri $uri/ /index.html` - Tüm route'lar index.html'e yönlendirilir
- gzip compression
- statik dosya cache

## Kullanım

```bash
# Build
docker build -t rickandmorty .

# Run
docker run -p 80:80 rickandmorty
```

## Coolify Deployment

Coolify'da:
1. Git repository bağla
2. Dockerfile otomatik algılanır
3. Deploy