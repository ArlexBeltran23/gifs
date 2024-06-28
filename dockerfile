# Usa una imagen base de Node.js 18 para construir la aplicación
FROM node:18 AS build

# Establece el directorio de trabajo en la imagen
WORKDIR /app

# Copia los archivos package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias de la aplicación
RUN npm install

# Copia el resto de los archivos de la aplicación
COPY . .

# Construye la aplicación Angular
RUN npm run build --prod

# Usa una imagen base de Nginx para servir la aplicación
FROM nginx:alpine

# Copia los archivos construidos de la etapa anterior
COPY --from=build /app/dist/gifs /usr/share/nginx/html

# Expone el puerto en el que la aplicación va a correr
EXPOSE 80

# Define el comando para correr Nginx
CMD ["nginx", "-g", "daemon off;"]
