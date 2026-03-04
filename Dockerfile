# ===============================
# Stage 1 - Build Angular App
# ===============================
FROM node:20-alpine AS builder

WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste du projet
COPY . .

# Build Angular en production
RUN npm run build -- --configuration production


# ===============================
# Stage 2 - Serve with Nginx
# ===============================
FROM nginx:alpine

# Supprimer la config par défaut
RUN rm -rf /usr/share/nginx/html/*

# Copier les fichiers build Angular
COPY --from=builder /app/dist/ /usr/share/nginx/html/

# Exposer le port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]