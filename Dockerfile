# === STAGE 1: Build Aplikasi ===
# Ubah dari node:18-alpine menjadi node:20-alpine atau node:22-alpine
FROM node:20-alpine AS build
WORKDIR /app

# Salin package.json dan install dependencies
COPY package*.json ./
RUN npm install

# Salin seluruh kode proyek dan lakukan build
COPY . .
RUN npm run build

# === STAGE 2: Production Server ===
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
# Jika pakai react-router, buka komen baris di bawah ini:
# COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
