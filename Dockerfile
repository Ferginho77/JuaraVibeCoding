# === STAGE 1: Build Aplikasi React ===
FROM node:20-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# === STAGE 2: Server Production Nginx ===
FROM nginx:alpine

# 1. Ambil hasil build React
COPY --from=build /app/dist /usr/share/nginx/html

# 2. WAJIB: Salin file konfigurasi Nginx kustom kamu (PASTIKAN TIDAK ADA TANDA # DI DEPAN)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 3. Ekspos port 8080
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
