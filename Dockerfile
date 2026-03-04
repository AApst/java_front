# ===============================
# Stage 1 - Build Angular App
# ===============================
FROM node:20-alpine AS builder

WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./
RUN npm install

# Copier le reste du projet
COPY . .

# Build Angular
RUN npm run build


# ===============================
# Stage 2 - Serve with Nginx
# ===============================
FROM nginx:alpine

COPY --from=builder /app/dist/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]